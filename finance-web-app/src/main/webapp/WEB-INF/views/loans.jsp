<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.finance.model.Loan" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>System Loans - Finance Management</title>
    
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

body {
    background: linear-gradient(135deg, var(--bg-gradient-1), var(--bg-gradient-2));
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
    .container {
        width: 95%;
        padding: 2rem 1.5rem;
        margin: 1rem auto;
        border-radius: 20px;
    }
    .header-actions {
        flex-direction: column;
        align-items: flex-start;
        gap: 1.5rem;
    }
    .header-actions > div:last-child {
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

</head>
<body>
    <div class="container">
        <div class="header-actions">
            <div>
                <h2>System Loans</h2>
                <div class="welcome-text">Overview of all customer loans in the system.</div>
            </div>
            <div>
                <a href="addLoan" class="btn" style="margin-right: 10px; background-color: #3b82f6;">+ Assign Loan</a>
                <a href="admin" class="btn btn-outline" style="margin-right: 10px;">&larr; Back to Dashboard</a>
            </div>
        </div>

        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Loan Amount</th>
                        <th>Paid Amount</th>
                        <th>Remaining Balance</th>
                        <th>Date Assigned</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Loan> loans = (List<Loan>) request.getAttribute("loans");
                        if (loans != null && !loans.isEmpty()) {
                            for (Loan loan : loans) {
                                Double la = loan.getLoanAmount() != null ? loan.getLoanAmount() : 0.0;
                                Double pa = loan.getPaidAmount() != null ? loan.getPaidAmount() : 0.0;
                                Double ra = loan.getRemainingAmount() != null ? loan.getRemainingAmount() : 0.0;
                    %>
                                <tr>
                                    <td data-label="ID"><%= loan.getId() %></td>
                                    <td data-label="Username"><strong><%= loan.getUsername() %></strong></td>
                                    <td data-label="Loan Amount" style="color: #3b82f6; font-weight: bold;">&#8377;<%= String.format("%,.0f", la) %></td>
                                    <td data-label="Paid Amount" style="color: #10b981; font-weight: bold;">&#8377;<%= String.format("%,.0f", pa) %></td>
                                    <td data-label="Remaining Balance" style="color: <%= ra > 0 ? "#ef4444" : "#10b981" %>; font-weight: bold;">&#8377;<%= String.format("%,.0f", ra) %></td>
                                    <td data-label="Date Assigned"><%= loan.getDate() %></td>
                                </tr>
                    <%
                            }
                        } else {
                    %>
                            <tr><td colspan='6' style='text-align:center;'>No loans found in the system.</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
