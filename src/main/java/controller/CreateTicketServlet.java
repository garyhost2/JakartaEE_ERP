package controller;

import util.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.UUID;

@WebServlet("/tickets/create")
public class CreateTicketServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String subject     = req.getParameter("subject");
        String description = req.getParameter("description");
        String priority    = req.getParameter("priority");
        // this was coming in as a String, but column is UUID
        String clientIdStr = (String) req.getSession().getAttribute("userId");

        // require at least a subject
        if (subject == null || subject.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Subject is required");
            return;
        }

        // parse the session userId into a UUID, or leave null
        UUID clientId = null;
        if (clientIdStr != null && !clientIdStr.isBlank()) {
            try {
                clientId = UUID.fromString(clientIdStr);
            } catch (IllegalArgumentException ex) {
                clientId = null;  // invalid format → treat as no client
            }
        }

        String sql = """
            INSERT INTO tickets (
              subject, description, priority,
              status, client_id, created_at
            ) VALUES (?, ?, ?,
                      'open', ?, CURRENT_TIMESTAMP)
        """;

        try (Connection conn = DbUtil.getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, subject.trim());
            ps.setString(2, (description != null ? description.trim() : ""));
            ps.setString(3, (priority != null ? priority.trim() : "normal"));

            if (clientId != null) {
                // map java.util.UUID → PG UUID
                ps.setObject(4, clientId);
            } else {
                // insert NULL into a UUID column
                ps.setNull(4, Types.OTHER);
            }

            ps.executeUpdate();
            resp.setStatus(HttpServletResponse.SC_CREATED);

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
