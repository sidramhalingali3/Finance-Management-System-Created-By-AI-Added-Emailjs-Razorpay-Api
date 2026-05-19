<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.finance.DBConnection" %>
<!DOCTYPE html>
<html>
<body>
    <h2>Database Migration</h2>
    <%
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement()) {
            
            // Try to add the column. If it exists, it will throw an exception which we catch and ignore.
            try {
                stmt.executeUpdate("ALTER TABLE finance ADD COLUMN collector VARCHAR(100) DEFAULT 'Self/Unknown'");
                out.println("<p style='color:green;'>Successfully added 'collector' column to the finance table!</p>");
            } catch (SQLException e) {
                if (e.getMessage().contains("Duplicate column name")) {
                    out.println("<p style='color:blue;'>The 'collector' column already exists. No changes needed.</p>");
                } else {
                    out.println("<p style='color:red;'>Error adding column: " + e.getMessage() + "</p>");
                }
            }
        } catch (Exception e) {
            out.println("<p style='color:red;'>Database Connection Error: " + e.getMessage() + "</p>");
        }
    %>
    <p>Migration complete. Please return to the app.</p>
</body>
</html>
