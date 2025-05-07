package controller;

import util.DbUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/tickets/update")
public class UpdateTicketServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id          = req.getParameter("id");
        String subject     = req.getParameter("subject");
        String description = req.getParameter("description");
        String priority    = req.getParameter("priority");
        String status      = req.getParameter("status");
        if (id==null) { resp.sendError(400); return; }

        String sql = """
            UPDATE tickets
               SET subject = ?, description = ?, priority = ?, status = ?, updated_at = CURRENT_TIMESTAMP
             WHERE id = ?
        """;
        try (Connection c = DbUtil.getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, subject);
            ps.setString(2, description);
            ps.setString(3, priority);
            ps.setString(4, status);
            ps.setString(5, id);
            ps.executeUpdate();
            resp.sendRedirect(req.getContextPath() + "/ticket?id=" + id);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
