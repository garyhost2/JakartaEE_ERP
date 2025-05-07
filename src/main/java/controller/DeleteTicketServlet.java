package controller;

import util.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.UUID;

@WebServlet("/tickets/delete")
public class DeleteTicketServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam == null || idParam.isBlank()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ticket id");
            return;
        }

        // Parse into UUID for Postgres
        UUID ticketId;
        try {
            ticketId = UUID.fromString(idParam);
        } catch (IllegalArgumentException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid UUID");
            return;
        }

        String sql = "DELETE FROM tickets WHERE id = ?";
        try (Connection conn = DbUtil.getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setObject(1, ticketId);
            int deleted = ps.executeUpdate();
            if (deleted == 0) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Ticket not found");
            } else {
                // return 200 OK; JS will remove from DOM
                resp.setStatus(HttpServletResponse.SC_OK);
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
