<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.finance.model.Finance" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - Finance Management</title>
    
<style>
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap');

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
    --danger-hover: #e11d48;
    --success-color: #10b981;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, sans-serif;
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
    max-width: 1280px;
    margin: 2rem auto;
    background: var(--card-bg);
    backdrop-filter: blur(24px);
    -webkit-backdrop-filter: blur(24px);
    border: 1px solid var(--border-color);
    border-radius: 20px;
    padding: 1.5rem 1.5rem;
    box-shadow: 0 20px 40px -10px rgba(0, 0, 0, 0.3);
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
    padding: 0.75rem 0.8rem;
    border-bottom: 1px solid #e2e8f0;
    transition: all 0.2s ease;
    font-size: 0.88rem;
    font-weight: 500;
    white-space: nowrap;
}

th {
    padding: 0.85rem 1rem;
    background: linear-gradient(135deg, #1e1b4b 0%, #312e81 40%, #4338ca 100%);
    font-weight: 700;
    color: #ffffff;
    text-transform: uppercase;
    font-size: 0.82rem;
    letter-spacing: 0.05em;
    border-bottom: none;
    position: sticky;
    top: 0;
    z-index: 10;
    white-space: nowrap !important;
}

td[data-label="Description"] {
    white-space: normal !important;
    min-width: 200px !important;
    max-width: 320px !important;
    word-break: normal !important;
    word-wrap: break-word !important;
}

th:nth-child(4) {
    white-space: nowrap !important;
    min-width: 200px !important;
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

.badge {
    padding: 0.4rem 0.85rem;
    border-radius: 50px;
    font-size: 0.85rem;
    font-weight: 700;
    display: inline-flex;
    align-items: center;
    gap: 0.35rem;
    letter-spacing: 0.03em;
}

.badge-success {
    background: #dcfce7;
    color: #15803d;
    border: 1px solid #86efac;
    box-shadow: 0 2px 6px rgba(22, 163, 74, 0.15);
}

.badge-warning {
    background: #fef3c7;
    color: #b45309;
    border: 1px solid #fde68a;
    box-shadow: 0 2px 6px rgba(217, 119, 6, 0.15);
}

.badge-danger {
    background: #ffe4e6;
    color: #be123c;
    border: 1px solid #fecdd3;
    box-shadow: 0 2px 6px rgba(225, 29, 72, 0.15);
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
    
    .table-responsive {
        border: none;
        box-shadow: none;
        background: transparent;
        width: 100% !important;
        max-width: 100% !important;
        overflow-x: hidden !important;
    }
    
    table, thead, tbody, th, td, tr {
        display: block;
        width: 100% !important;
        box-sizing: border-box !important;
    }
    
    thead tr {
        position: absolute;
        top: -9999px;
        left: -9999px;
    }
    
    tr {
        margin-bottom: 1.25rem;
        border: 1px solid rgba(226, 232, 240, 0.9);
        border-radius: 16px;
        background: #ffffff !important;
        box-shadow: 0 8px 20px -4px rgba(0, 0, 0, 0.08);
        overflow: hidden;
        width: 100% !important;
    }
    
    td {
        border: none;
        border-bottom: 1px solid #f1f5f9;
        position: relative;
        padding: 0.75rem 0.6rem 0.75rem 42% !important;
        text-align: right;
        font-size: 0.88rem;
        white-space: normal !important;
        word-break: break-all !important;
        overflow-wrap: anywhere !important;
    }
    
    td[data-label="Description"] {
        width: 100% !important;
        max-width: 100% !important;
        text-align: right;
        white-space: normal !important;
        word-break: break-word !important;
        overflow-wrap: anywhere !important;
    }
    
    td::before {
        position: absolute;
        top: 0.75rem;
        left: 0.6rem;
        width: 38%;
        padding-right: 5px;
        white-space: normal !important;
        word-break: break-word !important;
        text-align: left;
        font-weight: 700;
        color: #475569;
        content: attr(data-label);
        font-size: 0.75rem;
        text-transform: uppercase;
        letter-spacing: 0.02em;
    }
    
    .pagination-container {
        flex-wrap: wrap;
        gap: 0.5rem;
        justify-content: center;
    }
}
</style>

</head>
<body>
    <div class="container">
        <div class="header-actions">
            <div>
                <div class="welcome-text">Welcome back, <%= session.getAttribute("username") %> (Admin)</div>
                <h2>Admin Dashboard</h2>
            </div>
            <div>
                <a href="users" class="btn" style="margin-right: 20px; background-color: #6366f1;">View Users</a>
                <a href="logout" class="btn btn-outline">Logout</a>
            </div>
        </div>

        <% if ("true".equals(request.getParameter("success"))) { %>
            <div class='alert alert-success'>Action completed successfully!</div>
        <% } %>
        <% if ("true".equals(request.getParameter("userSuccess"))) { %>
            <div class='alert alert-success'>User created successfully!</div>
        <% } %>
        <% if ("true".equals(request.getParameter("loanSuccess"))) { %>
            <div class='alert alert-success'>Loan added successfully!</div>
        <% } %>
        
        <%
            Double totalLoans = (Double) request.getAttribute("totalLoans");
            if (totalLoans == null) totalLoans = 0.0;
            Double totalCollected = (Double) request.getAttribute("totalCollected");
            if (totalCollected == null) totalCollected = 0.0;
        %>
        <div style="display: flex; gap: 20px; flex-wrap: wrap; margin-bottom: 30px;">
            <a href="loans" class="card" style="flex: 1; padding: 20px; background: rgba(59, 130, 246, 0.1); border-radius: 12px; border-left: 4px solid #3b82f6; text-decoration: none; display: block; transition: transform 0.2s, background 0.2s;" onmouseover="this.style.transform='scale(1.02)'; this.style.background='rgba(59, 130, 246, 0.15)';" onmouseout="this.style.transform='scale(1)'; this.style.background='rgba(59, 130, 246, 0.1)';">
                <h4 style="margin: 0; color: #475569; font-weight: normal;">Total System Loans <span style="font-size: 0.8rem; color: #3b82f6;">(Click to view details &rarr;)</span></h4>
                <div style="font-size: 1.5rem; font-weight: bold; margin-top: 5px; color: #1e3a8a;">&#8377;<%= String.format("%,.0f", totalLoans) %></div>
            </a>
            <div class="card" style="flex: 1; padding: 20px; background: rgba(16, 185, 129, 0.1); border-radius: 12px; border-left: 4px solid #10b981;">
                <h4 style="margin: 0; color: #475569; font-weight: normal;">Total Collected (Approved)</h4>
                <div style="font-size: 1.5rem; font-weight: bold; margin-top: 5px; color: #10b981;">&#8377;<%= String.format("%,.0f", totalCollected) %></div>
            </div>
        </div>

        <h3>Platform Wide Collections</h3>
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Type</th>
                        <th>Amount</th>
                        <th>Description</th>
                        <th>Date</th>
                        <th>Customer</th>
                        <th>Collected By</th>
                        <th>Status</th>
                        <th>Running Paid</th>
                        <th>Running Balance</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Finance> financeList = (List<Finance>) request.getAttribute("financeList");
                        if (financeList != null && !financeList.isEmpty()) {
                            for (Finance f : financeList) {
                                String statusColor = "#10b981";
                                String currentStatus = (f.getStatus() == null || f.getStatus().isEmpty()) ? "Approved" : f.getStatus();
                                if ("Pending".equals(currentStatus)) statusColor = "#f59e0b";
                                else if ("Rejected".equals(currentStatus)) statusColor = "#ef4444";
                                
                                String collector = (f.getCollector() != null && !f.getCollector().isEmpty()) ? f.getCollector() : "Self/Unknown";
                                
                                Double cp = f.getCurrentPaidAmount();
                                Double cr = f.getCurrentRemainingAmount();
                    %>
                                <tr>
                                    <td data-label="ID"><%= f.getId() %></td>
                                    <td data-label="Type"><%= f.getType() %></td>
                                    <td data-label="Amount" style="color: #10b981; font-weight: 500;">&#8377;<%= String.format("%,.0f", f.getAmount()) %></td>
                                    <td data-label="Description"><%= f.getDescription() %></td>
                                    <td data-label="Date"><%= f.getDate() %></td>
                                    <td data-label="Customer"><%= f.getUsername() %></td>
                                    <td data-label="Collected By"><%= collector %></td>
                                    <td data-label="Status" style="color: <%= statusColor %>; font-weight: bold;"><%= currentStatus %></td>
                                    <td data-label="Running Paid" style="color: #6b7280;">
                                        <%= (cp != null && cp > 0) ? "&#8377;" + String.format("%,.0f", cp) : "-" %>
                                    </td>
                                    <td data-label="Running Balance" style="color: #6b7280; font-weight: bold;">
                                        <%= ((cp != null && cp > 0) || (cr != null && cr > 0)) ? "&#8377;" + String.format("%,.0f", cr != null ? cr : 0.0) : "-" %>
                                    </td>
                                    <td data-label="Action">
                                        <a href="deleteFinance?id=<%= f.getId() %>" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this record as Admin?');">Delete</a>
                                    </td>
                                </tr>
                    <%
                            }
                        } else {
                    %>
                            <tr><td colspan='11' style='text-align:center;'>No collections found.</td></tr>
                    <%
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const pageSize = 5;
            const tableBody = document.querySelector("table tbody");
            if (!tableBody) return;

            const rows = Array.from(tableBody.querySelectorAll("tr"));
            const validRows = rows.filter(r => !r.querySelector("td[colspan]"));

            if (validRows.length <= pageSize) return;

            let currentPage = 1;
            const totalPages = Math.ceil(validRows.length / pageSize);

            const tableResponsive = document.querySelector(".table-responsive");
            const pagContainer = document.createElement("div");
            pagContainer.className = "pagination-container";
            pagContainer.style.cssText = "display: flex; justify-content: space-between; align-items: center; margin-top: 1.25rem; padding: 0.85rem 1.25rem; background: #ffffff; border-radius: 16px; border: 1px solid rgba(0,0,0,0.06); box-shadow: 0 4px 12px rgba(0,0,0,0.03);";

            pagContainer.innerHTML = `
                <div id="page-info" style="font-size: 0.9rem; color: #475569; font-weight: 500;"></div>
                <div id="page-btns" style="display: flex; gap: 6px; align-items: center;"></div>
            `;

            tableResponsive.after(pagContainer);

            const pageInfo = pagContainer.querySelector("#page-info");
            const pageBtns = pagContainer.querySelector("#page-btns");

            function renderPage(page) {
                currentPage = page;
                const start = (page - 1) * pageSize;
                const end = start + pageSize;

                validRows.forEach((row, index) => {
                    if (index >= start && index < end) {
                        row.style.display = "";
                    } else {
                        row.style.display = "none";
                    }
                });

                const shownStart = start + 1;
                const shownEnd = Math.min(end, validRows.length);
                pageInfo.innerHTML = "Showing <strong>" + shownStart + "</strong> - <strong>" + shownEnd + "</strong> of <strong>" + validRows.length + "</strong> records";

                let btnsHtml = '<button type="button" class="pag-btn prev-btn" ' + (page === 1 ? 'disabled' : '') + ' style="padding: 0.45rem 0.85rem; border-radius: 8px; border: 1px solid #cbd5e1; background: ' + (page === 1 ? '#f1f5f9' : '#fff') + '; cursor: ' + (page === 1 ? 'not-allowed' : 'pointer') + '; font-weight: 600; font-size: 0.85rem; color: ' + (page === 1 ? '#94a3b8' : '#334155') + '; transition: all 0.2s;">&laquo; Prev</button>';

                for (let i = 1; i <= totalPages; i++) {
                    const isActive = i === page;
                    btnsHtml += '<button type="button" class="pag-btn num-btn" data-page="' + i + '" style="padding: 0.45rem 0.8rem; border-radius: 8px; border: 1px solid ' + (isActive ? '#2563eb' : '#cbd5e1') + '; background: ' + (isActive ? '#2563eb' : '#fff') + '; color: ' + (isActive ? '#fff' : '#334155') + '; font-weight: 600; font-size: 0.85rem; cursor: pointer; transition: all 0.2s;">' + i + '</button>';
                }

                btnsHtml += '<button type="button" class="pag-btn next-btn" ' + (page === totalPages ? 'disabled' : '') + ' style="padding: 0.45rem 0.85rem; border-radius: 8px; border: 1px solid #cbd5e1; background: ' + (page === totalPages ? '#f1f5f9' : '#fff') + '; cursor: ' + (page === totalPages ? 'not-allowed' : 'pointer') + '; font-weight: 600; font-size: 0.85rem; color: ' + (page === totalPages ? '#94a3b8' : '#334155') + '; transition: all 0.2s;">Next &raquo;</button>';

                pageBtns.innerHTML = btnsHtml;

                pageBtns.querySelector(".prev-btn")?.addEventListener("click", () => {
                    if (currentPage > 1) renderPage(currentPage - 1);
                });

                pageBtns.querySelector(".next-btn")?.addEventListener("click", () => {
                    if (currentPage < totalPages) renderPage(currentPage + 1);
                });

                pageBtns.querySelectorAll(".num-btn").forEach(btn => {
                    btn.addEventListener("click", function () {
                        const p = parseInt(this.getAttribute("data-page"));
                        renderPage(p);
                    });
                });
            }

            renderPage(1);
        });
    </script>
</body>
</html>
