package controller;

import model.Ticket;
import util.DbUtil;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.*;

@WebServlet("/tickets")
public class TicketListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        List<Ticket> all = new ArrayList<>();
        String sql = """
            SELECT id, subject, description, priority, status, created_at, updated_at
              FROM tickets
        """;

        try (Connection c = DbUtil.getConn();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Ticket t = new Ticket();
                t.setId(          rs.getString("id"));
                t.setSubject(     rs.getString("subject"));
                t.setDescription( rs.getString("description"));
                t.setPriority(    rs.getString("priority"));
                t.setStatus(      rs.getString("status"));
                Timestamp ca = rs.getTimestamp("created_at");
                if (ca!=null) t.setCreatedAt(ca.toLocalDateTime());
                Timestamp ua = rs.getTimestamp("updated_at");
                if (ua!=null) t.setUpdatedAt(ua.toLocalDateTime());
                all.add(t);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        // group by status
        Map<String,List<Ticket>> byStatus = new LinkedHashMap<>();
        for (String s: List.of("open","in_progress","closed")) {
            byStatus.put(s, new ArrayList<>());
        }
        for (Ticket t: all) {
            byStatus.computeIfAbsent(t.getStatus(), k->new ArrayList<>()).add(t);
        }

        req.setAttribute("ticketsByStatus", byStatus);
        req.getRequestDispatcher("/WEB-INF/views/tickets.jsp")
           .forward(req, resp);
    }
}
