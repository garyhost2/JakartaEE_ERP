package controller;

import util.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.UUID;

@WebServlet("/tickets/updateStatus")
public class UpdateTicketStatusServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String idStr  = req.getParameter("id");
        String status = req.getParameter("status");

        if (idStr == null || status == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        // --- Normalize inputs -------------------------------------------------
        status = status.trim().toLowerCase();           // open | in_progress | closed
        UUID id;
        try {
            id = UUID.fromString(idStr);                // validate + convert to UUID
        } catch (IllegalArgumentException ex) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid UUID");
            return;
        }

        // --- Update -----------------------------------------------------------
        String sql = """
            UPDATE tickets
               SET status = ?,
                   updated_at = CURRENT_TIMESTAMP
             WHERE id = ?
        """;

        try (Connection conn = DbUtil.getConn();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setObject(2, id);                        // bind as PG uuid
            int updated = ps.executeUpdate();

            if (updated == 1) {
                resp.setStatus(HttpServletResponse.SC_OK);
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            }

        } catch (SQLException e) {
            e.printStackTrace();                        // <- shows exact DB error
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}
