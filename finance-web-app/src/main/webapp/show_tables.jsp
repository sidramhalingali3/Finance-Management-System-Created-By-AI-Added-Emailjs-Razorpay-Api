<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.finance.DBConnection" %>
<!DOCTYPE html>
<html>
<body>
    <h2>Database Tables</h2>
    <table border="1">
        <tr><th>Table Name</th></tr>
        <%
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SHOW TABLES")) {
                while (rs.next()) {
                    out.println("<tr><td>" + rs.getString(1) + "</td></tr>");
                }
            } catch (Exception e) {
                out.println("<tr><td>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>
