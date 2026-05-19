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

@WebServlet("/DeleteUserServlet")
public class DeleteUserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"Admin".equals(session.getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendRedirect("users.jsp");
            return;
        }

        try (Connection conn = DBConnection.getConnection()) {
            int id = Integer.parseInt(idStr);
            
            // Prevent deleting the main admin just in case
            String checkSql = "SELECT role FROM users WHERE id = ?";
            try (PreparedStatement pstCheck = conn.prepareStatement(checkSql)) {
                pstCheck.setInt(1, id);
                java.sql.ResultSet rs = pstCheck.executeQuery();
                if (rs.next() && "Admin".equals(rs.getString("role"))) {
                    response.sendRedirect("users.jsp?error=admin");
                    return;
                }
            }

            String sql = "DELETE FROM users WHERE id = ?";
            try (PreparedStatement pst = conn.prepareStatement(sql)) {
                pst.setInt(1, id);
                pst.executeUpdate();
            }
            
            response.sendRedirect("users.jsp?deleted=true");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("users.jsp?error=true");
        }
    }
}
