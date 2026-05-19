package com.finance;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/DeleteFinanceServlet")
public class DeleteFinanceServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String role = (String) session.getAttribute("role");
        if (role == null || !"Admin".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            try (Connection conn = DBConnection.getConnection()) {
                int id = Integer.parseInt(idStr);
                
                // First fetch details to sync loans table if it was an Approved payment
                String fetchSql = "SELECT amount, username, status FROM finance WHERE id = ?";
                try (PreparedStatement fetchPst = conn.prepareStatement(fetchSql)) {
                    fetchPst.setInt(1, id);
                    try (java.sql.ResultSet rs = fetchPst.executeQuery()) {
                        if (rs.next()) {
                            double amt = rs.getDouble("amount");
                            String user = rs.getString("username");
                            String status = rs.getString("status");
                            
                            if ("Approved".equals(status) || status == null) {
                                String updateLoanSql = "UPDATE loans SET paid_amount = paid_amount - ?, remaining_amount = remaining_amount + ? WHERE username = ?";
                                try (PreparedStatement updatePst = conn.prepareStatement(updateLoanSql)) {
                                    updatePst.setDouble(1, amt);
                                    updatePst.setDouble(2, amt);
                                    updatePst.setString(3, user);
                                    updatePst.executeUpdate();
                                }
                            }
                        }
                    }
                }
                
                String sql = "DELETE FROM finance WHERE id = ?";
                try (PreparedStatement pst = conn.prepareStatement(sql)) {
                    pst.setInt(1, id);
                    pst.executeUpdate();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        response.sendRedirect("admin.jsp");
    }
}
