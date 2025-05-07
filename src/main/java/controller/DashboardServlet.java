package controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        // forward to the JSP sitting at webapp/dashboard.jsp
        req.getRequestDispatcher("/WEB-INF/views/dashboard.jsp")
           .forward(req, resp);
    }
}
