<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.finance.DBConnection" %>
<!DOCTYPE html>
<html>
<body>
    <h2>Data Insertion Script</h2>
    <%
        String sql = "INSERT INTO finance (username, type, amount, description, date, collector) VALUES " +
            "('Appasab', 'Payment', 1500.00, 'May EMI Payment', '2026-05-17', 'Mahesh Halingali')," +
            "('Sunil Chavan', 'Payment', 2000.00, 'May EMI Payment', '2026-05-17', 'Mahesh Halingali')," +
            "('Arjun Malhotra', 'Payment', 1200.00, 'May EMI Payment', '2026-05-17', 'Mahesh Halingali')," +
            "('Ganesh Pawar', 'Payment', 3500.00, 'May EMI Payment', '2026-05-17', 'Mahesh Halingali')," +
            "('Shankar Nayak', 'Payment', 1800.00, 'May EMI Payment', '2026-05-17', 'Vinay Shetty')," +
            "('Vijay Desai', 'Payment', 2200.00, 'May EMI Payment', '2026-05-17', 'Vinay Shetty')," +
            "('Rohit Singh', 'Payment', 1100.00, 'May EMI Payment', '2026-05-17', 'Vinay Shetty')," +
            "('Akash Verma', 'Payment', 4000.00, 'May EMI Payment', '2026-05-17', 'Vinay Shetty')," +
            "('Manjunath Hegde', 'Payment', 2500.00, 'May EMI Payment', '2026-05-17', 'Sandeep Gowda')," +
            "('Harish Bhat', 'Payment', 1300.00, 'May EMI Payment', '2026-05-17', 'Sandeep Gowda')," +
            "('Deepak Kulkarni', 'Payment', 1900.00, 'May EMI Payment', '2026-05-17', 'Sandeep Gowda')," +
            "('Santosh Rao', 'Payment', 3100.00, 'May EMI Payment', '2026-05-17', 'Sandeep Gowda')," +
            "('Naveen Joshi', 'Payment', 1600.00, 'May EMI Payment', '2026-05-17', 'Manjunath Patil')," +
            "('Prakash Shetty', 'Payment', 2100.00, 'May EMI Payment', '2026-05-17', 'Manjunath Patil')," +
            "('Vinod Kumar', 'Payment', 1450.00, 'May EMI Payment', '2026-05-17', 'Manjunath Patil')," +
            "('Kiran Naik', 'Payment', 2800.00, 'May EMI Payment', '2026-05-17', 'Manjunath Patil')";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            
            int rows = stmt.executeUpdate(sql);
            out.println("<h3 style='color:green;'>Success! Inserted " + rows + " payment records into the database.</h3>");
            
        } catch (Exception e) {
            out.println("<h3 style='color:red;'>Error inserting data: " + e.getMessage() + "</h3>");
        }
    %>
    <br>
    <a href="login.jsp" style="display:inline-block; padding:10px 20px; background:#4f46e5; color:white; text-decoration:none; border-radius:5px;">Go back to Login</a>
</body>
</html>
