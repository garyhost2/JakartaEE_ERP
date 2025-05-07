package controller;

import login.User;
import util.ValidationUtils;
import org.mindrot.jbcrypt.BCrypt;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Set;

@WebServlet("/register")
public class UserRegistration extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Gather and sanitize form data
        String new_username = sanitizeInput(request.getParameter("username"));
        String new_password = request.getParameter("password");
        String email = sanitizeInput(request.getParameter("email"));

        // 2. Create User object
        User user = new User(new_username, new_password, email);

     // 3. Validate User input
	     Set<ConstraintViolation<User>> violations = ValidationUtils.validate(user);
	     if (!violations.isEmpty()) {
	         request.setAttribute("validationErrors", violations);
	         request.getRequestDispatcher("/WEB-INF/views/register.jsp").forward(request, response);
	         return;
	     }

        // 4. Load the PostgreSQL Driver
        try {
            Class.forName("org.postgresql.Driver"); // Load JDBC Driver
        } catch (ClassNotFoundException e) {
            System.err.println("PostgreSQL JDBC Driver not found!");
            e.printStackTrace();
            return;
        }

        // 4. Get Database Connection Parameters
        String url = System.getenv("DB_URL");
        String username = System.getenv("DB_USER");
        String password = System.getenv("DB_PASSWORD");

        // 5. Fallback to default values if environment variables are not set
        if (url == null) {
            url = "jdbc:postgresql://localhost:5432/webappdb";
        }
        if (username == null) {
            username = "webuser";
        }
        if (password == null) {
            password = "securepass123";
        }

        System.out.println("DB_URL: " + url);
        System.out.println("DB_USER: " + username);
        System.out.println("DB_PASSWORD: " + password);

        // 6. Try to establish a database connection
        try (Connection conn = DriverManager.getConnection(url, username, password)) {
            System.out.println("Database connection successful!");

            // 7. Hash password before storage
            String hashedPassword = BCrypt.hashpw(new_password, BCrypt.gensalt());

            // 8. Save to database
            saveUserToDatabase(conn, user.getUsername(), hashedPassword, user.getEmail());
            System.out.println("User Saved to the DB");

            // 9. Redirect to success page
            request.setAttribute("user", user);
            request.getRequestDispatcher("/WEB-INF/views/success.jsp").forward(request, response);

        } catch (SQLException e) {
            handleDatabaseError(request, response, e);
        } catch (Exception e) {
            handleGenericError(request, response, e);
        }
    }

    private void saveUserToDatabase(Connection conn, String name, String hashedPassword, String email)
            throws SQLException {
        String sql = "INSERT INTO users (name, password, email) VALUES (?, ?, ?)";

        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, name);
            pstmt.setString(2, hashedPassword);
            pstmt.setString(3, email);
            pstmt.executeUpdate();
        }
    }

    private void handleDatabaseError(HttpServletRequest request, HttpServletResponse response,
                                     SQLException e) throws ServletException, IOException {
        if (e.getSQLState().equals("23505")) { // Unique constraint violation
            request.setAttribute("errorMessage",
                    "Username or email already exists. Please choose different credentials.");
        } else {
            request.setAttribute("errorMessage",
                    "Database error. Please try again later.");
        }
        request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
    }

    private void handleGenericError(HttpServletRequest request, HttpServletResponse response,
                                    Exception e) throws ServletException, IOException {
        request.setAttribute("errorMessage",
                "An unexpected error occurred. Please try again.");
        request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
    }

    private String sanitizeInput(String input) {
        return input != null ? input.trim() : null;
    }
}
