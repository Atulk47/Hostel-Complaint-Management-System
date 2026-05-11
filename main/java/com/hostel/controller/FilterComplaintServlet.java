package com.hostel.controller;

import com.hostel.dao.ComplaintDAO;
import com.hostel.model.Complaint;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * FilterComplaintServlet
 * Handles filtering complaints by category and status
 */
@WebServlet("/admin/filter-complaints")
public class FilterComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String category = request.getParameter("category");
        String status = request.getParameter("status");

        // Get filtered complaints
        List<Complaint> complaints = complaintDAO.getFilteredComplaints(category, status);

        request.setAttribute("complaints", complaints);
        request.setAttribute("selectedCategory", category);
        request.setAttribute("selectedStatus", status);
        request.getRequestDispatcher("/views/admin/adminDashboard.jsp").forward(request, response);
    }
}
