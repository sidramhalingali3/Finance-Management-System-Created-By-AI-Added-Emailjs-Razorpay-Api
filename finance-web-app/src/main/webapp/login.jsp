<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Finance Management System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <div class="container login-container">
        <h1>Finance System</h1>
        
        <% 
            try {
                java.sql.Connection migConn = com.finance.DBConnection.getConnection();
                java.sql.Statement migStmt = migConn.createStatement();
                try { migStmt.executeUpdate("ALTER TABLE loans ADD COLUMN paid_amount DECIMAL(10,2) DEFAULT 0.0"); } catch(Exception ignore){}
                try { migStmt.executeUpdate("ALTER TABLE loans ADD COLUMN remaining_amount DECIMAL(10,2) DEFAULT 0.0"); } catch(Exception ignore){}
                
                try { migStmt.executeUpdate("ALTER TABLE finance ADD COLUMN current_paid_amount DECIMAL(10,2) DEFAULT 0.0"); } catch(Exception ignore){}
                try { migStmt.executeUpdate("ALTER TABLE finance ADD COLUMN current_remaining_amount DECIMAL(10,2) DEFAULT 0.0"); } catch(Exception ignore){}
                
                // Backfill historical data so old loans don't show 0
                try {
                    migStmt.executeUpdate("UPDATE loans l SET paid_amount = IFNULL((SELECT SUM(amount) FROM finance f WHERE f.username = l.username AND (f.status = 'Approved' OR f.status IS NULL)), 0.0)");
                    migStmt.executeUpdate("UPDATE loans SET remaining_amount = loan_amount - paid_amount");
                    
                    // Simple backfill for finance table based on current loan state (imperfect for true history, but avoids 0s)
                    migStmt.executeUpdate("UPDATE finance f INNER JOIN loans l ON f.username = l.username SET f.current_paid_amount = l.paid_amount, f.current_remaining_amount = l.remaining_amount WHERE f.current_paid_amount = 0.0");
                } catch(Exception ignore){}
                
                migStmt.close();
                migConn.close();
            } catch(Exception e) {}
            
            if ("true".equals(request.getParameter("logout"))) {
                session.invalidate();
                out.println("<div class='alert alert-success'>Successfully logged out.</div>");
            }
            String error = request.getParameter("error");
            if (error != null) {
                String msg = "";
                if (error.equals("invalid_credentials")) msg = "Invalid username or password.";
                else if (error.equals("invalid_role")) msg = "Invalid user role.";
                else if (error.equals("database_error")) msg = "Database connection error.";
                out.println("<div class='alert alert-error'>" + msg + "</div>");
            }
        %>

        <form action="LoginServlet" method="post">
            <div class="form-group">
                <label for="username">Username</label>
                <input type="text" id="username" name="username" required placeholder="Enter your username">
            </div>
            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password" required placeholder="Enter your password">
            </div>
            <button type="submit" class="btn">Sign In</button>
        </form>
    </div>
</body>
</html>
