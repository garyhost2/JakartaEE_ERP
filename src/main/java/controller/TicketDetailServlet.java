package controller;

import model.Ticket;
import util.DbUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/ticket")
public class TicketDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String id = req.getParameter("id");
        if (id==null) {
            resp.sendError(400, "Missing id");
            return;
        }

        String sql = """
            SELECT id, subject, description, priority, status, created_at, updated_at
              FROM tickets WHERE id = ?
        """;
        try (Connection c = DbUtil.getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) {
                    resp.sendError(404);
                    return;
                }
                Ticket t = new Ticket();
                t.setId(rs.getString("id"));
                t.setSubject(rs.getString("subject"));
                t.setDescription(rs.getString("description"));
                t.setPriority(rs.getString("priority"));
                t.setStatus(rs.getString("status"));
                Timestamp ca = rs.getTimestamp("created_at");
                if (ca!=null) t.setCreatedAt(ca.toLocalDateTime());
                Timestamp ua = rs.getTimestamp("updated_at");
                if (ua!=null) t.setUpdatedAt(ua.toLocalDateTime());

                req.setAttribute("ticket", t);
                req.getRequestDispatcher("/WEB-INF/views/ticket.jsp")
                   .forward(req, resp);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
