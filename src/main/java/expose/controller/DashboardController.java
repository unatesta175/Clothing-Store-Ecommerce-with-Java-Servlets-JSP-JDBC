// ===================== DashboardController.java =====================
package expose.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;

import expose.dao.CustomerDAO;


public class DashboardController extends HttpServlet {

    private CustomerDAO customerDAO;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        customerDAO = new CustomerDAO();
        gson = new Gson();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String xRequestedWith = request.getHeader("X-Requested-With");
        if (!"XMLHttpRequest".equals(xRequestedWith)) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Only AJAX requests allowed");
            return;
        }

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        try (PrintWriter out = response.getWriter()) {
            List<Map<String, Object>> data = customerDAO.getLocationCounts();
            String jsonResponse = gson.toJson(data);
            out.print(jsonResponse);
            out.flush();
        } catch (SQLException e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().print("{\"error\":\"Database error: " + e.getMessage() + "\"}");
        }
    }
}
