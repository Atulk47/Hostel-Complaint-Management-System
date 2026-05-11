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
 * StaffDashboardServlet
 * Handles staff dashboard
 */
@WebServlet("/staff/dashboard")
public class StaffDashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComplaintDAO complaintDAO = new ComplaintDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int staffId = (Integer) session.getAttribute("userId");

        // Get complaints assigned to staff
        List<Complaint> complaints = complaintDAO.getComplaintsByStaff(staffId);

        request.setAttribute("complaints", complaints);
        request.getRequestDispatcher("/views/staff/staffDashboard.jsp").forward(request, response);
    }
}
