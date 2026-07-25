<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Razorpay Online Payment - Finance Management</title>
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
<style>
:root {
    --primary-color: #6366f1;
    --primary-hover: #4f46e5;
    --bg-gradient-1: #0f172a;
    --bg-gradient-2: #1e1b4b;
    --card-bg: rgba(255, 255, 255, 0.96);
    --text-main: #0f172a;
    --text-muted: #475569;
    --border-color: rgba(255, 255, 255, 0.2);
    --danger-color: #f43f5e;
    --success-color: #10b981;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Outfit', sans-serif;
}

html {
    scroll-behavior: smooth;
    -webkit-overflow-scrolling: touch;
}

body {
    -webkit-overflow-scrolling: touch;
    touch-action: manipulation;
    background: radial-gradient(circle at 50% 0%, #1e1b4b 0%, #0f172a 60%, #020617 100%);
    background-attachment: fixed;
    color: var(--text-main);
    min-height: 100vh;
    display: flex;
    flex-direction: column;
    align-items: center;
    position: relative;
    overflow-x: hidden;
}

.container {
    width: 92%;
    max-width: 900px;
    margin: 2.5rem auto;
    background: var(--card-bg);
    backdrop-filter: blur(24px);
    -webkit-backdrop-filter: blur(24px);
    border: 1px solid var(--border-color);
    border-radius: 24px;
    padding: 2.5rem;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.12);
    position: relative;
    z-index: 1;
}

.header-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 2rem;
    padding-bottom: 1rem;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08);
}

.header-actions h2 {
    font-size: 1.8rem;
    font-weight: 700;
    color: #1e3a8a;
    display: flex;
    align-items: center;
    gap: 10px;
}

.btn-back {
    padding: 0.6rem 1.2rem;
    background: rgba(255, 255, 255, 0.8);
    border: 1px solid #cbd5e1;
    border-radius: 12px;
    color: var(--text-main);
    text-decoration: none;
    font-weight: 600;
    font-size: 0.9rem;
    transition: all 0.2s;
    display: inline-flex;
    align-items: center;
    gap: 6px;
}

.btn-back:hover {
    background: #ffffff;
    border-color: var(--primary-color);
    color: var(--primary-color);
}

.form-group {
    margin-bottom: 1.5rem;
}

.form-label {
    display: block;
    margin-bottom: 0.5rem;
    font-size: 0.95rem;
    font-weight: 600;
    color: var(--text-muted);
}

.amount-presets {
    display: grid;
    grid-template-columns: repeat(4, 1fr);
    gap: 10px;
    margin-bottom: 1rem;
}

.btn-preset {
    padding: 0.75rem;
    background: #ffffff;
    border: 2px solid #e2e8f0;
    border-radius: 12px;
    font-weight: 600;
    font-size: 1rem;
    color: #334155;
    cursor: pointer;
    transition: all 0.2s;
}

.btn-preset:hover, .btn-preset.active {
    border-color: var(--primary-color);
    background: rgba(37, 99, 235, 0.08);
    color: var(--primary-color);
}

.input-wrapper {
    position: relative;
    display: flex;
    align-items: center;
}

.currency-symbol {
    position: absolute;
    left: 1rem;
    font-size: 1.2rem;
    font-weight: 700;
    color: #64748b;
}

.input-icon {
    position: absolute;
    left: 1rem;
    color: #64748b;
}

.form-control {
    width: 100%;
    padding: 0.9rem 1.25rem 0.9rem 2.75rem;
    background: #ffffff;
    border: 1px solid #cbd5e1;
    border-radius: 14px;
    font-size: 1rem;
    color: var(--text-main);
    transition: all 0.2s;
}

.amount-input {
    padding-left: 2.75rem;
    font-size: 1.25rem;
    font-weight: 700;
    color: #1e293b;
}

.form-control:focus {
    outline: none;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 3px rgba(37, 99, 235, 0.15);
}

.form-row {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
}

.btn-pay {
    width: 100%;
    padding: 1.1rem;
    background: linear-gradient(135deg, #0284c7, #2563eb);
    color: #ffffff;
    border: none;
    border-radius: 14px;
    font-size: 1.15rem;
    font-weight: 700;
    cursor: pointer;
    box-shadow: 0 4px 14px rgba(37, 99, 235, 0.35);
    transition: all 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 10px;
}

.btn-pay:hover {
    transform: translateY(-2px);
    box-shadow: 0 6px 20px rgba(37, 99, 235, 0.45);
}

.btn-pay:disabled {
    opacity: 0.65;
    cursor: not-allowed;
    transform: none;
}

.spinner {
    width: 24px;
    height: 24px;
    border: 3px solid rgba(255,255,255,0.3);
    border-radius: 50%;
    border-top-color: #fff;
    animation: spin 0.8s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}

.hidden {
    display: none !important;
}

/* Modal Overlay */
.modal-overlay {
    position: fixed;
    top: 0; left: 0; width: 100%; height: 100%;
    background: rgba(15, 23, 42, 0.65);
    backdrop-filter: blur(8px);
    z-index: 100;
    display: flex;
    align-items: center;
    justify-content: center;
}

.modal-content {
    background: #ffffff;
    border-radius: 24px;
    padding: 2.5rem;
    width: 90%;
    max-width: 480px;
    text-align: center;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
    animation: popIn 0.3s cubic-bezier(0.16, 1, 0.3, 1);
}

@keyframes popIn {
    from { opacity: 0; transform: scale(0.9); }
    to { opacity: 1; transform: scale(1); }
}

.status-icon {
    width: 70px;
    height: 70px;
    border-radius: 50%;
    background: rgba(16, 185, 129, 0.1);
    color: #10b981;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 2.5rem;
    margin: 0 auto 1.25rem auto;
}

.receipt-details {
    background: #f8fafc;
    border-radius: 14px;
    padding: 1.25rem;
    margin: 1.5rem 0;
    text-align: left;
}

.receipt-row {
    display: flex;
    justify-content: space-between;
    padding: 0.5rem 0;
    border-bottom: 1px dashed #e2e8f0;
    font-size: 0.95rem;
}

.receipt-row:last-child {
    border-bottom: none;
}

.receipt-row .label {
    color: var(--text-muted);
}

.receipt-row .value {
    font-weight: 600;
    color: var(--text-main);
}

.highlight-val {
    color: var(--success-color);
    font-size: 1.1rem;
}

@media screen and (max-width: 640px) {
    ::-webkit-scrollbar {
        display: none !important;
        width: 0px !important;
        height: 0px !important;
    }
    html, body, * {
        scrollbar-width: none !important;
        -ms-overflow-style: none !important;
    }
    html, body {
        width: 100% !important;
        max-width: 100% !important;
        margin: 0 !important;
        padding: 0 !important;
        background: #f8fafc !important;
        overflow-x: hidden !important;
    }
    .container {
        width: 100% !important;
        max-width: 100% !important;
        padding: 1.25rem 1rem !important;
        margin: 0 !important;
        border-radius: 0 !important;
        border: none !important;
        box-shadow: none !important;
        background: #ffffff !important;
        box-sizing: border-box !important;
        min-height: 100vh;
    }
    .form-row { grid-template-columns: 1fr; }
    .amount-presets { grid-template-columns: repeat(2, 1fr); }
    .receipt-row .value {
        word-break: break-all;
        overflow-wrap: anywhere;
    }
}
</style>
</head>
<body>
    <div class="container">
        <div class="header-actions">
            <h2><i class="fa-solid fa-shield-halved" style="color: #2563eb;"></i> Online Payment</h2>
            <a href="customer" class="btn-back"><i class="fa-solid fa-arrow-left"></i> Dashboard</a>
        </div>

        <form id="razorpay-form">
            <!-- Preset Amount Options -->
            <div class="form-group">
                <label class="form-label">Select Loan Installment Amount (₹)</label>
                <div class="amount-presets">
                    <button type="button" class="btn-preset" data-amount="500">₹500</button>
                    <button type="button" class="btn-preset active" data-amount="1000">₹1,000</button>
                    <button type="button" class="btn-preset" data-amount="2500">₹2,500</button>
                    <button type="button" class="btn-preset" data-amount="5000">₹5,000</button>
                </div>
            </div>

            <!-- Amount Input -->
            <div class="form-group">
                <label for="amount" class="form-label">Payment Amount (INR)</label>
                <div class="input-wrapper">
                    <span class="currency-symbol">₹</span>
                    <input type="number" id="amount" class="form-control amount-input" value="1000" min="1" step="1" required>
                </div>
            </div>

            <!-- Customer Details -->
            <div class="form-row">
                <div class="form-group">
                    <label for="customerName" class="form-label">Customer Name</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-user input-icon"></i>
                        <input type="text" id="customerName" class="form-control" value="<%= session.getAttribute("username") %>" required>
                    </div>
                </div>
                <div class="form-group">
                    <label for="customerEmail" class="form-label">Email Address</label>
                    <div class="input-wrapper">
                        <i class="fa-solid fa-envelope input-icon"></i>
                        <input type="email" id="customerEmail" class="form-control" value="<%= session.getAttribute("username") %>@example.com" required>
                    </div>
                </div>
            </div>

            <div class="form-group">
                <label for="customerPhone" class="form-label">Phone Number</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-phone input-icon"></i>
                    <input type="tel" id="customerPhone" class="form-control" value="9876543210" placeholder="9876543210" required>
                </div>
            </div>

            <!-- Submit Button -->
            <button type="submit" id="pay-btn" class="btn-pay">
                <span id="btn-text"><i class="fa-solid fa-lock"></i> Pay Now with Razorpay</span>
                <div id="btn-loader" class="spinner hidden"></div>
            </button>
        </form>

        <div style="margin-top: 1.5rem; text-align: center; font-size: 0.85rem; color: #64748b;">
            <i class="fa-solid fa-shield-cat"></i> Official Razorpay Payment Integration &bull; 256-bit Signature Verification
        </div>
    </div>

    <!-- Success Modal Overlay -->
    <div id="result-modal" class="modal-overlay hidden">
        <div class="modal-content">
            <div class="status-icon">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <h2 style="color: #0f172a; margin-bottom: 0.5rem;">Payment Successful!</h2>
            <p style="color: #64748b; font-size: 0.95rem;">Your transaction has been verified and your loan balance has been credited.</p>

            <div class="receipt-details">
                <div class="receipt-row">
                    <span class="label">Amount Paid:</span>
                    <span id="res-amount" class="value highlight-val">₹0.00</span>
                </div>
                <div class="receipt-row">
                    <span class="label">Payment ID:</span>
                    <span id="res-payment-id" class="value" style="font-family: monospace;">-</span>
                </div>
                <div class="receipt-row">
                    <span class="label">Order ID:</span>
                    <span id="res-order-id" class="value" style="font-family: monospace;">-</span>
                </div>
                <div class="receipt-row">
                    <span class="label">Loan Status:</span>
                    <span class="value" style="color: #10b981;">CREDITED & APPROVED</span>
                </div>
            </div>

            <button id="close-modal-btn" class="btn-pay" style="width: 100%;">Return to Dashboard</button>
        </div>
    </div>

    <!-- Razorpay Checkout Script SDK -->
    <script src="https://checkout.razorpay.com/v1/checkout.js"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const form = document.getElementById("razorpay-form");
            const amountInput = document.getElementById("amount");
            const presetBtns = document.querySelectorAll(".btn-preset");
            const payBtn = document.getElementById("pay-btn");
            const btnText = document.getElementById("btn-text");
            const btnLoader = document.getElementById("btn-loader");

            const resultModal = document.getElementById("result-modal");
            const closeModalBtn = document.getElementById("close-modal-btn");
            const resAmount = document.getElementById("res-amount");
            const resPaymentId = document.getElementById("res-payment-id");
            const resOrderId = document.getElementById("res-order-id");

            presetBtns.forEach(btn => {
                btn.addEventListener("click", function () {
                    presetBtns.forEach(b => b.classList.remove("active"));
                    this.classList.add("active");
                    amountInput.value = this.getAttribute("data-amount");
                });
            });

            amountInput.addEventListener("input", function () {
                presetBtns.forEach(b => {
                    if (b.getAttribute("data-amount") === this.value) {
                        b.classList.add("active");
                    } else {
                        b.classList.remove("active");
                    }
                });
            });

            form.addEventListener("submit", async function (e) {
                e.preventDefault();

                const amount = parseFloat(amountInput.value);
                const customerName = document.getElementById("customerName").value;
                const customerEmail = document.getElementById("customerEmail").value;
                const customerPhone = document.getElementById("customerPhone").value;

                if (!amount || amount <= 0) {
                    alert("Please enter a valid payment amount.");
                    return;
                }

                setLoading(true);

                try {
                    // Step 1: Create Order on Backend
                    const response = await fetch("${pageContext.request.contextPath}/api/payment/create-order", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify({
                            amount: amount,
                            customerName: customerName,
                            customerEmail: customerEmail,
                            customerPhone: customerPhone
                        })
                    });

                    const result = await response.json();

                    if (!result.success) {
                        alert("Failed to create order: " + result.message);
                        setLoading(false);
                        return;
                    }

                    const orderData = result.data;

                    // Step 2: Open Razorpay Checkout Modal
                    openRazorpayCheckout(orderData, customerName, customerEmail, customerPhone);

                } catch (err) {
                    console.error("Payment Order error:", err);
                    alert("Unable to reach payment server. Please try again.");
                    setLoading(false);
                }
            });

               function openRazorpayCheckout(orderData, name, email, phone) {
                const validPhone = (phone && phone.trim().length >= 10) ? phone.trim() : "9999999999";
                const validEmail = (email && email.trim().length > 0) ? email.trim() : "customer@example.com";
                const validName = (name && name.trim().length > 0) ? name.trim() : "Customer";

                const options = {
                    key: orderData.keyId,
                    amount: orderData.amountInPaise,
                    currency: orderData.currency || "INR",
                    name: "Finance Management System",
                    description: "Loan Payment #" + orderData.orderId,
                    image: "https://razorpay.com/assets/razorpay-glyph.svg",
                    order_id: orderData.orderId,
                    prefill: {
                        name: validName,
                        email: validEmail,
                        contact: validPhone
                    },
                    theme: {
                        color: "#6366f1"
                    },
                    retry: {
                        enabled: true
                    },
                    modal: {
                        handleback: true,
                        confirm_close: true,
                        ondismiss: function () {
                            setLoading(false);
                        }
                    },
                    handler: async function (response) {
                        // Step 3: Verify Payment Signature & Credit Loan
                        await verifyPayment({
                            razorpayOrderId: response.razorpay_order_id,
                            razorpayPaymentId: response.razorpay_payment_id,
                            razorpaySignature: response.razorpay_signature
                        }, orderData.amountInRupees);
                    }
                };

                try {
                    const rzp = new Razorpay(options);
                    rzp.on('payment.failed', function (response) {
                        alert("Payment Failed: " + (response.error.description || "Transaction declined."));
                        setLoading(false);
                    });
                    rzp.open();
                } catch (err) {
                    console.error("Razorpay SDK launch error", err);
                    alert("Razorpay checkout error.");
                    setLoading(false);
                }
            }

            async function verifyPayment(verificationPayload, amountRupees) {
                setLoading(true);
                try {
                    const response = await fetch("${pageContext.request.contextPath}/api/payment/verify-payment", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify(verificationPayload)
                    });

                    const result = await response.json();
                    setLoading(false);

                    if (result.success && result.data) {
                        const f = result.data;
                        resAmount.textContent = "₹" + parseFloat(f.amount).toFixed(2);
                        resPaymentId.textContent = f.description ? f.description : "-";
                        resOrderId.textContent = "Record #" + f.id;
                        resultModal.classList.remove("hidden");

                        let formattedDateStr = "";
                        if (f.date) {
                            let d = new Date(typeof f.date === 'number' ? f.date : f.date);
                            formattedDateStr = isNaN(d.getTime()) ? f.date : d.toLocaleString("en-IN", { timeZone: "Asia/Kolkata", day: "2-digit", month: "2-digit", year: "numeric", hour: "2-digit", minute: "2-digit", second: "2-digit", hour12: true });
                        } else {
                            formattedDateStr = new Date().toLocaleString("en-IN", { timeZone: "Asia/Kolkata", day: "2-digit", month: "2-digit", year: "numeric", hour: "2-digit", minute: "2-digit", second: "2-digit", hour12: true });
                        }

                        // Trigger EmailJS Payment Confirmation Email with complete Finance record details
                        sendEmailNotification({
                            name: document.getElementById("customerName").value,
                            customer_name: document.getElementById("customerName").value,
                            to_name: document.getElementById("customerName").value,
                            email: document.getElementById("customerEmail").value,
                            to_email: document.getElementById("customerEmail").value,
                            company_name: "Finance Management System",
                            id: f.id,
                            finance_id: f.id,
                            type: f.type,
                            amount: "₹" + parseFloat(f.amount).toLocaleString(),
                            description: f.description,
                            date: formattedDateStr,
                            collector: f.collector,
                            status: f.status,
                            current_paid: "₹" + (f.currentPaidAmount ? parseFloat(f.currentPaidAmount).toLocaleString() : "0"),
                            current_remaining: "₹" + (f.currentRemainingAmount ? parseFloat(f.currentRemainingAmount).toLocaleString() : "0"),
                            running_paid: "₹" + (f.currentPaidAmount ? parseFloat(f.currentPaidAmount).toLocaleString() : "0"),
                            running_balance: "₹" + (f.currentRemainingAmount ? parseFloat(f.currentRemainingAmount).toLocaleString() : "0")
                        });
                    } else {
                        alert("Payment verification failed: " + result.message);
                    }
                } catch (err) {
                    console.error("Verification error:", err);
                    alert("Payment verification error.");
                    setLoading(false);
                }
            }

            async function sendEmailNotification(params) {
                const serviceID = "service_zprsp9e";
                const templateID = "template_5ejof3w";
                const publicKey = "Z6VPeKqIKfSPQWLho";

                const payload = {
                    service_id: serviceID,
                    template_id: templateID,
                    user_id: publicKey,
                    template_params: params
                };

                try {
                    const res = await fetch("https://api.emailjs.com/api/v1.0/email/send", {
                        method: "POST",
                        headers: { "Content-Type": "application/json" },
                        body: JSON.stringify(payload)
                    });

                    if (res.ok) {
                        console.log("EmailJS Email sent successfully!");
                    } else {
                        const errText = await res.text();
                        console.error("EmailJS Error:", res.status, errText);
                    }
                } catch (err) {
                    console.error("EmailJS Fetch Error:", err);
                }
            }

            closeModalBtn.addEventListener("click", function () {
                window.location.href = "customer";
            });

            function setLoading(isLoading) {
                if (isLoading) {
                    payBtn.disabled = true;
                    btnText.classList.add("hidden");
                    btnLoader.classList.remove("hidden");
                } else {
                    payBtn.disabled = false;
                    btnText.classList.remove("hidden");
                    btnLoader.classList.add("hidden");
                }
            }
        });
    </script>
</body>
</html>
