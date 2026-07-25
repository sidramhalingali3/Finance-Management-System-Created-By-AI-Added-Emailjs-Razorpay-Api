<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Finance Management System</title>
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
<style>
@import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap');

:root {
    --primary-color: #6366f1;
    --primary-hover: #4f46e5;
    --card-bg: rgba(255, 255, 255, 0.95);
    --text-main: #0f172a;
    --text-muted: #64748b;
    --border-color: rgba(255, 255, 255, 0.2);
    --danger-color: #ef4444;
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
    justify-content: center;
    align-items: center;
    position: relative;
    overflow-x: hidden;
    padding: 1rem;
}

/* Background Animated Spheres */
body::before {
    content: '';
    position: absolute;
    top: -10%;
    left: -10%;
    width: 60vw;
    height: 60vw;
    max-width: 600px;
    max-height: 600px;
    background: radial-gradient(circle, rgba(99, 102, 241, 0.3) 0%, transparent 70%);
    border-radius: 50%;
    z-index: -1;
    animation: float 14s infinite alternate ease-in-out;
}

body::after {
    content: '';
    position: absolute;
    bottom: -10%;
    right: -10%;
    width: 60vw;
    height: 60vw;
    max-width: 600px;
    max-height: 600px;
    background: radial-gradient(circle, rgba(59, 130, 246, 0.25) 0%, transparent 70%);
    border-radius: 50%;
    z-index: -1;
    animation: float 18s infinite alternate-reverse ease-in-out;
}

@keyframes float {
    0% { transform: translate(0, 0) scale(1); }
    100% { transform: translate(35px, -35px) scale(1.1); }
}

.login-card {
    width: 100%;
    max-width: 440px;
    background: var(--card-bg);
    backdrop-filter: blur(24px);
    -webkit-backdrop-filter: blur(24px);
    border: 1px solid rgba(255, 255, 255, 0.4);
    border-radius: 24px;
    padding: 2.75rem 2.25rem;
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.35), 0 0 0 1px rgba(255, 255, 255, 0.6) inset;
    animation: cardPop 0.65s cubic-bezier(0.16, 1, 0.3, 1);
    position: relative;
    z-index: 1;
}

@keyframes cardPop {
    from { opacity: 0; transform: translateY(35px) scale(0.95); }
    to { opacity: 1; transform: translateY(0) scale(1); }
}

.brand-header {
    text-align: center;
    margin-bottom: 2rem;
}

.brand-icon-wrapper {
    width: 64px;
    height: 64px;
    margin: 0 auto 1.25rem;
    background: linear-gradient(135deg, #4338ca, #3b82f6);
    border-radius: 20px;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.75rem;
    box-shadow: 0 10px 25px -5px rgba(59, 130, 246, 0.4);
    animation: pulseIcon 3s infinite ease-in-out;
}

@keyframes pulseIcon {
    0%, 100% { transform: scale(1); box-shadow: 0 10px 25px -5px rgba(59, 130, 246, 0.4); }
    50% { transform: scale(1.05); box-shadow: 0 15px 35px rgba(59, 130, 246, 0.6); }
}

.brand-title {
    font-size: 1.85rem;
    font-weight: 800;
    letter-spacing: -0.03em;
    background: linear-gradient(135deg, #0f172a, #1e3a8a);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    margin-bottom: 0.35rem;
}

.brand-subtitle {
    font-size: 0.95rem;
    color: var(--text-muted);
    font-weight: 500;
}

.form-group {
    margin-bottom: 1.4rem;
}

.form-label {
    display: block;
    margin-bottom: 0.5rem;
    font-size: 0.9rem;
    color: #334155;
    font-weight: 600;
}

.input-wrapper {
    position: relative;
    display: flex;
    align-items: center;
}

.input-icon {
    position: absolute;
    left: 1.25rem;
    color: #94a3b8;
    font-size: 1.1rem;
    transition: color 0.3s ease;
}

.form-input {
    width: 100%;
    padding: 0.95rem 1.25rem 0.95rem 3rem;
    background: #f8fafc;
    border: 1.5px solid #e2e8f0;
    border-radius: 14px;
    color: var(--text-main);
    font-size: 1rem;
    font-weight: 500;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.form-input:focus {
    outline: none;
    background: #ffffff;
    border-color: #3b82f6;
    box-shadow: 0 0 0 4px rgba(59, 130, 246, 0.18);
    transform: translateY(-1px);
}

.form-input:focus + .input-icon,
.input-wrapper:focus-within .input-icon {
    color: #2563eb;
}

.btn-submit {
    width: 100%;
    padding: 1rem 1.5rem;
    background: linear-gradient(135deg, #3b82f6, #1d4ed8);
    color: white;
    border: none;
    border-radius: 14px;
    font-size: 1.05rem;
    font-weight: 700;
    cursor: pointer;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    box-shadow: 0 8px 20px -4px rgba(37, 99, 235, 0.4);
    position: relative;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
    gap: 0.5rem;
    margin-top: 0.5rem;
}

.btn-submit::after {
    content: '';
    position: absolute;
    top: 0; left: 0; width: 100%; height: 100%;
    background: linear-gradient(to right, rgba(255,255,255,0) 0%, rgba(255,255,255,0.3) 50%, rgba(255,255,255,0) 100%);
    transform: translateX(-100%);
    animation: shimmer 3s infinite;
}

@keyframes shimmer {
    0% { transform: translateX(-100%); }
    30% { transform: translateX(100%); }
    100% { transform: translateX(100%); }
}

.btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 12px 25px -4px rgba(37, 99, 235, 0.5);
}

.btn-submit:active {
    transform: scale(0.96);
    box-shadow: 0 4px 12px rgba(37, 99, 235, 0.3);
}

.alert {
    padding: 0.9rem 1.1rem;
    border-radius: 12px;
    margin-bottom: 1.5rem;
    font-size: 0.92rem;
    font-weight: 600;
    display: flex;
    align-items: center;
    gap: 0.6rem;
    animation: alertSlide 0.35s ease-out;
}

@keyframes alertSlide {
    from { opacity: 0; transform: translateY(-10px); }
    to { opacity: 1; transform: translateY(0); }
}

.alert-error {
    background: #fef2f2;
    color: #991b1b;
    border: 1px solid #fecaca;
}

.alert-success {
    background: #f0fdf4;
    color: #166534;
    border: 1px solid #bbf7d0;
}

@media screen and (max-width: 640px) {
    ::-webkit-scrollbar {
        display: none !important;
        width: 0px !important;
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
        background: radial-gradient(circle at 50% 0%, #1e1b4b 0%, #0f172a 60%, #020617 100%) !important;
        overflow-x: hidden !important;
    }
    .login-card {
        width: 100% !important;
        max-width: 100% !important;
        padding: 2.25rem 1.5rem !important;
        margin: 0 !important;
        border-radius: 0 !important;
        border: none !important;
        box-shadow: none !important;
        background: #ffffff !important;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
    }
}
</style>
</head>
<body>
    <div class="login-card">
        <div class="brand-header">
            <div class="brand-icon-wrapper">
                <i class="fa-solid fa-shield-halved"></i>
            </div>
            <h1 class="brand-title">Finance Management</h1>
            <p class="brand-subtitle">Sign in to access your dashboard</p>
        </div>
        
        <% if ("true".equals(request.getParameter("logout"))) { %>
            <div class="alert alert-success">
                <i class="fa-solid fa-circle-check"></i> Successfully logged out.
            </div>
        <% } %>
        
        <% 
            String error = (String) request.getAttribute("error");
            if (error != null && !error.isEmpty()) { 
        %>
            <div class="alert alert-error">
                <i class="fa-solid fa-circle-exclamation"></i> <%= error %>
            </div>
        <% } %>

        <form action="login" method="post">
            <div class="form-group">
                <label for="username" class="form-label">Username</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-user input-icon"></i>
                    <input type="text" id="username" name="username" class="form-input" required placeholder="Enter your username">
                </div>
            </div>
            <div class="form-group">
                <label for="password" class="form-label">Password</label>
                <div class="input-wrapper">
                    <i class="fa-solid fa-lock input-icon"></i>
                    <input type="password" id="password" name="password" class="form-input" required placeholder="Enter your password">
                </div>
            </div>
            <button type="submit" class="btn-submit">
                <span>Sign In</span>
                <i class="fa-solid fa-arrow-right"></i>
            </button>
        </form>
    </div>
</body>
</html>
