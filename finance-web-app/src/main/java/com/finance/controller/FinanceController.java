package com.finance.controller;

import com.finance.dao.FinanceDao;
import com.finance.dao.LoanDao;
import com.finance.model.Finance;
import com.finance.model.Loan;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

@Controller
public class FinanceController {

    @Autowired
    private FinanceDao financeDao;

    @Autowired
    private LoanDao loanDao;

    @GetMapping("/addFinance")
    public String showAddFinance(HttpSession session) {
        String role = (String) session.getAttribute("role");
        if (!"Collector".equals(role) && !"Customer".equals(role)) return "redirect:/login";
        return "addFinance";
    }

    @PostMapping("/addFinance")
    public String addFinance(
            @RequestParam(value = "customerUsername", required = false) String customerUsername,
            @RequestParam("type") String type,
            @RequestParam("amount") Double amount,
            @RequestParam("description") String description,
            HttpSession session) {

        String role = (String) session.getAttribute("role");
        if (role == null) return "redirect:/login";

        try {
            Finance finance = new Finance();
            
            if ("Customer".equals(role)) {
                finance.setUsername((String) session.getAttribute("username"));
                finance.setStatus("Pending");
            } else {
                finance.setUsername(customerUsername);
                finance.setCollector((String) session.getAttribute("username"));
                finance.setStatus("Approved");
                
                List<Loan> loans = loanDao.findByUsername(customerUsername);
                if (loans != null && !loans.isEmpty()) {
                    Loan loan = loans.get(0);
                    
                    double currentPaid = loan.getPaidAmount() != null ? loan.getPaidAmount() : 0.0;
                    double currentRemaining = loan.getRemainingAmount() != null ? loan.getRemainingAmount() : 0.0;
                    
                    loan.setPaidAmount(currentPaid + amount);
                    loan.setRemainingAmount(currentRemaining - amount);
                    loanDao.update(loan);
                    
                    finance.setCurrentPaidAmount(loan.getPaidAmount());
                    finance.setCurrentRemainingAmount(loan.getRemainingAmount());
                }
            }
            
            finance.setType(type);
            finance.setAmount(amount);
            finance.setDescription(description);
            finance.setDate(new java.sql.Date(System.currentTimeMillis()));
            
            financeDao.save(finance);
            
            if ("Customer".equals(role)) {
                return "redirect:/customer?success=true";
            } else {
                return "redirect:/collector?success=true";
            }
        } catch (Exception e) {
            return "redirect:/addFinance?error=insert_failed";
        }
    }

    @GetMapping("/deleteFinance")
    public String deleteFinance(@RequestParam("id") Integer id, HttpSession session) {
        if (!"Admin".equals(session.getAttribute("role"))) return "redirect:/login";
        financeDao.delete(id);
        return "redirect:/admin?success=true";
    }
    
    @PostMapping("/verifyPayment")
    public String verifyPayment(
            @RequestParam("id") Integer id,
            @RequestParam("action") String action,
            HttpSession session) {
            
        if (!"Collector".equals(session.getAttribute("role"))) return "redirect:/login";
        
        Finance finance = financeDao.findById(id);
        if (finance != null) {
            if ("approve".equals(action) && !"Approved".equals(finance.getStatus())) {
                finance.setStatus("Approved");
                finance.setCollector((String) session.getAttribute("username"));
                
                List<Loan> loans = loanDao.findByUsername(finance.getUsername());
                if (loans != null && !loans.isEmpty()) {
                    Loan loan = loans.get(0);
                    
                    double currentPaid = loan.getPaidAmount() != null ? loan.getPaidAmount() : 0.0;
                    double currentRemaining = loan.getRemainingAmount() != null ? loan.getRemainingAmount() : 0.0;
                    
                    loan.setPaidAmount(currentPaid + finance.getAmount());
                    loan.setRemainingAmount(currentRemaining - finance.getAmount());
                    loanDao.update(loan);
                    
                    finance.setCurrentPaidAmount(loan.getPaidAmount());
                    finance.setCurrentRemainingAmount(loan.getRemainingAmount());
                }
            } else if ("reject".equals(action)) {
                finance.setStatus("Rejected");
            }
            financeDao.update(finance);
            return "redirect:/collector?success=verified";
        }
        return "redirect:/collector?error=true";
    }
}
