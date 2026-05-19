<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.finance.DBConnection" %>
<!DOCTYPE html>
<html>
<body>
    <h2>Finance Table Schema</h2>
    <table border="1">
        <tr><th>Field</th><th>Type</th></tr>
        <%
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("DESCRIBE finance")) {
                while (rs.next()) {
                    out.println("<tr><td>" + rs.getString("Field") + "</td><td>" + rs.getString("Type") + "</td></tr>");
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='2'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>
