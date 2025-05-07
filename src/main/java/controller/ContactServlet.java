package controller;

import util.DbUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.UUID;

/**
 * One servlet for GET (display form) and POST (save message).
 */
@WebServlet("/contact")
public class ContactServlet extends HttpServlet {

    /* ---------- GET : show the form ---------- */
    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        // forward to JSP (lives under WEB‑INF so it is not directly reachable)
        req.getRequestDispatcher("/WEB-INF/views/contact.jsp")
           .forward(req, resp);
    }

    /* ---------- POST : save the message ---------- */
    @Override
    protected void doPost(HttpServletRequest req,
                          HttpServletResponse resp)
            throws ServletException, IOException {

        req.setCharacterEncoding("UTF-8");

        String name    = trim(req.getParameter("name"));
        String email   = trim(req.getParameter("email"));
        String subject = trim(req.getParameter("subject"));
        String message = trim(req.getParameter("message"));

        // Very basic validation
        if (name == null || email == null || subject == null || message == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "All fields are required.");
            return;
        }

        String sql = """
            INSERT INTO contact_messages
                   (id, name, email, subject, message, created_at)
            VALUES (?,  ?,    ?,     ?,       ?,       CURRENT_TIMESTAMP)
        """;

        try (Connection c = DbUtil.getConn();
             PreparedStatement ps = c.prepareStatement(sql)) {

            ps.setObject(1, UUID.randomUUID());
            ps.setString(2, name);
            ps.setString(3, email);
            ps.setString(4, subject);
            ps.setString(5, message);
            ps.executeUpdate();

            // success → redirect to GET /contact with ?ok=1 flag so the JSP shows banner
            resp.sendRedirect(req.getContextPath() + "/contact?ok=1");

        } catch (SQLException e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                           "Unable to save message at the moment.");
        }
    }

    private String trim(String s) { return s == null ? null : s.trim(); }
}
