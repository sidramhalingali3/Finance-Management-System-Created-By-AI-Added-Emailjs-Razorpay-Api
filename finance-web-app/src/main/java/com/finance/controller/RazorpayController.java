package com.finance.controller;

import com.finance.dto.ApiResponse;
import com.finance.dto.OrderRequest;
import com.finance.dto.OrderResponse;
import com.finance.dto.PaymentVerificationRequest;
import com.finance.model.Finance;
import com.finance.model.PaymentOrder;
import com.finance.service.RazorpayService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/payment")
@CrossOrigin(origins = "*")
public class RazorpayController {

    @Autowired
    private RazorpayService razorpayService;

    /**
     * Step 1: Endpoint to create Razorpay Order
     */
    @PostMapping("/create-order")
    public ResponseEntity<ApiResponse<OrderResponse>> createOrder(@RequestBody OrderRequest orderRequest, HttpSession session) {
        try {
            String username = (String) session.getAttribute("username");
            if (username == null) {
                return ResponseEntity.status(401).body(ApiResponse.error("User not logged in"));
            }

            OrderResponse response = razorpayService.createOrder(orderRequest, username);
            return ResponseEntity.ok(ApiResponse.success("Order created successfully", response));
        } catch (IllegalArgumentException e) {
            return ResponseEntity.badRequest().body(ApiResponse.error(e.getMessage()));
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(ApiResponse.error("Failed to create Razorpay order: " + e.getMessage()));
        }
    }

    /**
     * Step 2: Endpoint to verify payment signature after Razorpay Checkout completes
     */
    @PostMapping("/verify-payment")
    public ResponseEntity<ApiResponse<Finance>> verifyPayment(@RequestBody PaymentVerificationRequest request, HttpSession session) {
        try {
            String username = (String) session.getAttribute("username");
            if (username == null) {
                return ResponseEntity.status(401).body(ApiResponse.error("User not logged in"));
            }

            Finance financeRecord = razorpayService.verifyAndSavePayment(request);

            if (financeRecord != null && "Approved".equals(financeRecord.getStatus())) {
                return ResponseEntity.ok(ApiResponse.success("Payment verified successfully", financeRecord));
            } else {
                return ResponseEntity.badRequest().body(ApiResponse.error("Payment signature verification failed"));
            }
        } catch (Exception e) {
            return ResponseEntity.internalServerError().body(ApiResponse.error("Payment verification failed: " + e.getMessage()));
        }
    }

    /**
     * Safe Config endpoint to fetch Key ID for checkout popup
     */
    @GetMapping("/config")
    public ResponseEntity<ApiResponse<Map<String, String>>> getConfig() {
        Map<String, String> config = new HashMap<>();
        config.put("keyId", razorpayService.getKeyId());
        return ResponseEntity.ok(ApiResponse.success("Config fetched", config));
    }

    /**
     * Get payment orders for current customer
     */
    @GetMapping("/orders")
    public ResponseEntity<ApiResponse<List<PaymentOrder>>> getUserOrders(HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username == null) {
            return ResponseEntity.status(401).body(ApiResponse.error("User not logged in"));
        }
        List<PaymentOrder> orders = razorpayService.getOrdersByUsername(username);
        return ResponseEntity.ok(ApiResponse.success("Orders fetched successfully", orders));
    }
}
