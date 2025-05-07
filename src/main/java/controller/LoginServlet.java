package controller;

import login.User;                      
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.*;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    // JDBC creds (swap in your actual values)
    private static final String JDBC_URL      = "jdbc:postgresql://localhost:5432/webappdb";
    private static final String JDBC_USER     = "webuser";
    private static final String JDBC_PASS     = "securepass123";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // simply show the login form
        req.getRequestDispatcher("/WEB-INF/views/login.jsp")
           .forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = sanitize(req.getParameter("username"));
        String password = req.getParameter("password");

        if (username == null || password == null) {
            forwardWithError(req, resp, "Please fill in both fields.");
            return;
        }

        // 1. Load driver (optional once on classpath)
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            forwardWithError(req, resp, "Server config error.");
            return;
        }

        // 2. Check credentials
        try (Connection conn = DriverManager.getConnection(JDBC_URL, JDBC_USER, JDBC_PASS)) {
            String sql = "SELECT id, name, email, password, is_verified, role_id "
                       + "FROM users WHERE name = ?";
            try (PreparedStatement ps = conn.prepareStatement(sql)) {
                ps.setString(1, username);
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        forwardWithError(req, resp, "Invalid username or password.");
                        return;
                    }
                    boolean verified = rs.getBoolean("is_verified");
                    String hashed = rs.getString("password");
                    String email  = rs.getString("email");
                    int    roleId = rs.getInt("role_id");

             //       if (!verified) {
                //        forwardWithError(req, resp,
                    //        "You must verify your email before logging in.");
                      //  return;
                   // } uncomment when mail verification is done

                    if (!BCrypt.checkpw(password, hashed)) {
                        forwardWithError(req, resp, "Invalid username or password.");
                        return;
                    }

                    // 3. Success → create session and redirect
                    HttpSession session = req.getSession(true);
                    User user = new User(username, null, email);
                    session.setAttribute("currentUser", user);

                    resp.sendRedirect(req.getContextPath() + "/tickets"); 
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            forwardWithError(req, resp, "Database error, try again later.");
        }
    }

    private void forwardWithError(HttpServletRequest req,
                                  HttpServletResponse resp,
                                  String msg)
            throws ServletException, IOException {
        req.setAttribute("error", msg);
        req.getRequestDispatcher("/WEB-INF/views/login.jsp")
           .forward(req, resp);
    }

    private String sanitize(String s) {
        return s == null ? null : s.trim();
    }
}
