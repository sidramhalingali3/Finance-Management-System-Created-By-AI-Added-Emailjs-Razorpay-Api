<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pay via UPI - Finance Management</title>
    
<style>
@import url('https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap');

:root {
    --primary-color: #2563eb;
    --primary-hover: #1d4ed8;
    --bg-gradient-1: #f0f9ff;
    --bg-gradient-2: #e0f2fe;
    --card-bg: rgba(255, 255, 255, 0.75);
    --text-main: #0f172a;
    --text-muted: #475569;
    --border-color: rgba(255, 255, 255, 0.5);
    --danger-color: #ef4444;
    --danger-hover: #dc2626;
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

body::before {
    content: '';
    position: absolute;
    top: -15%;
    left: -10%;
    width: 60%;
    height: 60%;
    background: radial-gradient(circle, rgba(59, 130, 246, 0.15) 0%, transparent 70%);
    border-radius: 50%;
    z-index: -1;
    animation: float 15s infinite alternate ease-in-out;
}

body::after {
    content: '';
    position: absolute;
    bottom: -15%;
    right: -10%;
    width: 60%;
    height: 60%;
    background: radial-gradient(circle, rgba(14, 165, 233, 0.15) 0%, transparent 70%);
    border-radius: 50%;
    z-index: -1;
    animation: float 18s infinite alternate-reverse ease-in-out;
}

@keyframes float {
    0% { transform: translate(0, 0) scale(1); }
    100% { transform: translate(40px, -40px) scale(1.1); }
}

.container {
    width: 92%;
    max-width: 1100px;
    margin: 3rem auto;
    background: var(--card-bg);
    backdrop-filter: blur(24px);
    -webkit-backdrop-filter: blur(24px);
    border: 1px solid var(--border-color);
    border-radius: 24px;
    padding: 3.5rem;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.15), inset 0 0 0 1px rgba(255, 255, 255, 0.8);
    animation: fadeIn 0.6s cubic-bezier(0.16, 1, 0.3, 1);
    position: relative;
    z-index: 1;
}

.login-container {
    max-width: 450px;
    margin-top: 15vh;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(30px); }
    to { opacity: 1; transform: translateY(0); }
}

h1, h2, h3 {
    text-align: center;
    margin-bottom: 2rem;
    font-weight: 700;
    letter-spacing: -0.03em;
    background: linear-gradient(135deg, #1e3a8a, #3b82f6);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}

h1 { font-size: 2.75rem; }
h2 { font-size: 2.25rem; text-align: left; background: transparent; -webkit-text-fill-color: initial; color: var(--text-main); }
h3 { font-size: 1.75rem; text-align: left; background: transparent; -webkit-text-fill-color: initial; color: var(--text-main); }

.form-group {
    margin-bottom: 1.5rem;
    position: relative;
}

.form-group label {
    display: block;
    margin-bottom: 0.5rem;
    font-size: 0.95rem;
    color: var(--text-muted);
    font-weight: 500;
}

input[type="text"],
input[type="password"],
input[type="number"],
input[type="date"],
select {
    width: 100%;
    padding: 1rem 1.25rem;
    background: rgba(255, 255, 255, 0.8);
    border: 1px solid rgba(0, 0, 0, 0.08);
    border-radius: 14px;
    color: var(--text-main);
    font-size: 1rem;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: inset 0 2px 4px rgba(0,0,0,0.02);
}

input:focus, select:focus {
    outline: none;
    background: #ffffff;
    border-color: var(--primary-color);
    box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.15), inset 0 2px 4px rgba(0,0,0,0.02);
    transform: translateY(-1px);
}

.btn {
    display: inline-flex;
    align-items: center;
    justify-content: center;
    width: 100%;
    padding: 1rem 1.5rem;
    background: linear-gradient(135deg, var(--primary-color), var(--primary-hover));
    color: white;
    border: none;
    border-radius: 14px;
    font-size: 1.05rem;
    font-weight: 600;
    cursor: pointer;
    text-decoration: none;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
    position: relative;
    overflow: hidden;
}

.btn::after {
    content: '';
    position: absolute;
    top: 0; left: 0; width: 100%; height: 100%;
    background: linear-gradient(to right, rgba(255,255,255,0) 0%, rgba(255,255,255,0.2) 50%, rgba(255,255,255,0) 100%);
    transform: translateX(-100%);
    transition: transform 0.6s ease;
}

.btn:hover::after {
    transform: translateX(100%);
}

.btn:hover {
    transform: translateY(-3px);
    box-shadow: 0 8px 20px rgba(59, 130, 246, 0.4);
    color: white;
}

.btn:active {
    transform: translateY(-1px);
}

.btn-danger {
    background: linear-gradient(135deg, var(--danger-color), var(--danger-hover));
    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
    width: auto;
}

.btn-danger:hover {
    box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
    background: linear-gradient(135deg, var(--danger-hover), #b91c1c);
}

.btn-outline {
    background: rgba(255, 255, 255, 0.5);
    border: 2px solid var(--primary-color);
    color: var(--primary-color);
    box-shadow: none;
    width: auto;
}

.btn-outline:hover {
    background: rgba(59, 130, 246, 0.1);
    color: var(--primary-color);
}

.btn-outline::after {
    display: none;
}

.header-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 3rem;
    padding-bottom: 1.5rem;
    border-bottom: 1px solid rgba(0, 0, 0, 0.06);
}

.header-actions h2 {
    margin: 0;
}

.header-actions > div:last-child {
    display: flex;
    gap: 1rem;
    align-items: center;
}

.welcome-text {
    color: var(--primary-color);
    font-size: 1rem;
    font-weight: 600;
    margin-bottom: 0.5rem;
    letter-spacing: 0.02em;
    text-transform: uppercase;
}

.alert {
    padding: 1.25rem 1.5rem;
    border-radius: 14px;
    margin-bottom: 2rem;
    font-size: 1rem;
    font-weight: 500;
    display: flex;
    align-items: center;
    animation: slideInDown 0.4s cubic-bezier(0.16, 1, 0.3, 1);
}

@keyframes slideInDown {
    from { opacity: 0; transform: translateY(-15px); }
    to { opacity: 1; transform: translateY(0); }
}

.alert-error {
    background: rgba(254, 242, 242, 0.9);
    color: #b91c1c;
    border: 1px solid #fecaca;
    border-left: 5px solid #ef4444;
}

.alert-success {
    background: rgba(240, 253, 244, 0.9);
    color: #15803d;
    border: 1px solid #bbf7d0;
    border-left: 5px solid #10b981;
}

.table-responsive {
    overflow-x: auto;
    margin-top: 2rem;
    border-radius: 18px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.06);
    background: #ffffff;
    border: 1px solid rgba(0,0,0,0.05);
}

table {
    width: 100%;
    border-collapse: collapse;
    text-align: left;
    background-color: #ffffff;
}

th, td {
    padding: 1.25rem 1.5rem;
    border-bottom: 1px solid #f1f5f9;
    transition: all 0.3s ease;
}

th {
    background: linear-gradient(to right, #1e3a8a, #3b82f6);
    font-weight: 600;
    color: #ffffff;
    text-transform: uppercase;
    font-size: 0.85rem;
    letter-spacing: 0.08em;
    border-bottom: none;
    position: sticky;
    top: 0;
    z-index: 10;
}

tr:last-child td {
    border-bottom: none;
}

tbody tr {
    background-color: #ffffff;
}

tbody tr:nth-child(even) {
    background-color: #f8fafc;
}

tbody tr:hover {
    background-color: #f1f5f9;
    transform: translateY(-2px) scale(1.005);
    box-shadow: 0 4px 12px -2px rgba(59, 130, 246, 0.15);
    position: relative;
    z-index: 5;
    border-radius: 12px;
}

tbody tr:hover td {
    color: #2563eb;
    border-bottom-color: transparent;
}

::-webkit-scrollbar {
    width: 10px;
    height: 10px;
}
::-webkit-scrollbar-track {
    background: transparent;
}
::-webkit-scrollbar-thumb {
    background: rgba(59, 130, 246, 0.3);
    border-radius: 10px;
}
::-webkit-scrollbar-thumb:hover {
    background: rgba(59, 130, 246, 0.6);
}

@media screen and (max-width: 768px) {
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
    .header-actions {
        flex-direction: column;
        align-items: flex-start;
        gap: 1.25rem;
    }
    .header-actions > div:last-child {
        width: 100%;
        flex-direction: column;
    }
    .header-actions .btn {
        width: 100%;
        margin-right: 0 !important;
        margin-bottom: 0.6rem;
    }
}
        width: 100%;
        flex-direction: column;
    }
    .header-actions .btn {
        width: 100%;
        margin-right: 0 !important;
        margin-bottom: 0.5rem;
    }
    
    .table-responsive {
        border: none;
        box-shadow: none;
        background: transparent;
    }
    
    table, thead, tbody, th, td, tr {
        display: block;
    }
    
    thead tr {
        position: absolute;
        top: -9999px;
        left: -9999px;
    }
    
    tr {
        margin-bottom: 1.5rem;
        border: 1px solid rgba(0,0,0,0.08);
        border-radius: 16px;
        background: #ffffff !important;
        box-shadow: 0 4px 12px rgba(0,0,0,0.03);
        overflow: hidden;
    }
    
    td {
        border: none;
        border-bottom: 1px solid #f1f5f9;
        position: relative;
        padding-left: 50%;
        text-align: right;
    }
    
    td::before {
        position: absolute;
        top: 1.25rem;
        left: 1.25rem;
        width: 40%;
        padding-right: 10px;
        white-space: nowrap;
        text-align: left;
        font-weight: 600;
        color: var(--text-muted);
        content: attr(data-label);
        font-size: 0.75rem;
        text-transform: uppercase;
    }
}
</style>

    <script>
        function openUpi() {
            const amount = document.getElementById('upiAmount').value;
            if (!amount || amount <= 0) {
                alert("Please enter a valid amount first.");
                return;
            }
            const upiId = "6363882198@sbi";
            const upiName = "Admin";
            // Create intent URL
            const intentUrl = `upi://pay?pa=${upiId}&pn=${upiName}&am=${amount}&cu=INR`;
            
            // Open the Intent
            window.location.href = intentUrl;
            
            // Show the next step (Enter UTR and submit)
            document.getElementById('step1').style.display = 'none';
            document.getElementById('step2').style.display = 'block';
            
            // Pre-fill the form amount
            document.getElementById('amount').value = amount;
            
            // Set today's date
            document.getElementById('date').valueAsDate = new Date();
        }
    </script>
</head>
<body>
    <div class="container login-container" style="max-width: 500px;">
        <div class="header-actions" style="margin-bottom: 1.5rem; padding-bottom: 0.5rem; border-bottom: 1px solid rgba(255,255,255,0.1);">
            <h2 style="margin-bottom: 0; color: #a855f7;">Make a Payment</h2>
            <a href="customer" class="btn btn-outline" style="padding: 0.5rem 1rem; font-size: 0.875rem;">&larr; Back</a>
        </div>

        <div id="step1" style="text-align: center;">
            <p style="color: #ccc; margin-bottom: 20px;">Enter the amount you wish to pay, then click below to open your UPI app (PhonePe, GPay, Paytm).</p>
            
            <div class="form-group" style="text-align: left;">
                <label for="upiAmount">Amount (₹)</label>
                <input type="number" id="upiAmount" step="0.01" min="1" placeholder="0.00" required>
            </div>
            
            <button onclick="openUpi()" class="btn" style="background-color: #5f259f; font-size: 1.1rem; padding: 12px; display: flex; align-items: center; justify-content: center; gap: 10px; width: 100%;">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M12 2v20M17 5H9.5a3.5 3.5 0 0 0 0 7h5a3.5 3.5 0 0 1 0 7H6"/></svg>
                Pay via UPI App
            </button>
            
            <div style="margin-top: 30px; padding: 15px; background: rgba(255,255,255,0.05); border-radius: 8px;">
                <p style="font-size: 0.9rem; color: #999; margin:0 0 10px 0;">Or scan to pay (Laptop Users):</p>
                <img src="Admin.jpeg?v=2" alt="Scan QR" style="max-width: 150px; border-radius: 8px; border: 2px solid #5f259f;">
                <p style="font-size: 0.85rem; color: #666; margin: 10px 0 0 0;">UPI ID: <strong>6363882198@sbi</strong></p>
                <button type="button" onclick="document.getElementById('step1').style.display='none'; document.getElementById('step2').style.display='block'; let amt = document.getElementById('upiAmount').value; if(amt) document.getElementById('amount').value = amt; document.getElementById('date').valueAsDate=new Date();" class="btn btn-outline" style="margin-top: 15px; width: 100%;">I have already paid</button>
            </div>
        </div>

        <div id="step2" style="display: none;">
            <div style="background: rgba(16, 185, 129, 0.1); border: 1px solid #10b981; padding: 15px; border-radius: 8px; margin-bottom: 20px; text-align: center;">
                <h4 style="color: #10b981; margin: 0 0 5px 0;">Great! Payment Initiated.</h4>
                <p style="font-size: 0.9rem; margin: 0; color: #ddd;">After successfully paying in your app, please enter the 12-digit UTR/Transaction ID below to confirm your payment.</p>
            </div>
            
            <form action="addFinance" method="post">
                <input type="hidden" name="type" value="Payment">
                <input type="hidden" name="customerUsername" value="<%= session.getAttribute("username") %>">
                
                <div class="form-group">
                    <label for="amount">Amount Paid (₹)</label>
                    <input type="number" id="amount" name="amount" step="0.01" min="1" required>
                </div>
                
                <div class="form-group">
                    <label for="description">12-digit UTR / Transaction ID</label>
                    <input type="text" id="description" name="description" required placeholder="e.g. 312345678901" pattern="\d{12}" title="Please enter exactly 12 digits for the UTR">
                </div>
                
                <div class="form-group" style="display:none;">
                    <label for="date">Date</label>
                    <input type="date" id="date" name="date" required>
                </div>
                
                <button type="submit" class="btn" style="background-color: #10b981;">Confirm Payment</button>
            </form>
        </div>
    </div>
</body>
</html>
