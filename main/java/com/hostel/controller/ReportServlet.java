package com.hostel.controller;

import com.hostel.dao.ReportDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

/**
 * ReportServlet
 * Handles report generation
 */
@WebServlet("/admin/reports")
public class ReportServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ReportDAO reportDAO = new ReportDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get report statistics
        int totalComplaints = reportDAO.getTotalComplaintsCount();
        int closedComplaints = reportDAO.getClosedComplaintsCount();
        int pendingComplaints = reportDAO.getPendingComplaintsCount();
        double avgResolutionTime = reportDAO.getAverageResolutionTime();

        Map<String, Integer> statusMap = reportDAO.getComplaintCountByStatus();
        Map<String, Integer> categoryMap = reportDAO.getComplaintCountByCategory();
        Map<Integer, Integer> staffPerformance = reportDAO.getStaffPerformance();

        request.setAttribute("totalComplaints", totalComplaints);
        request.setAttribute("closedComplaints", closedComplaints);
        request.setAttribute("pendingComplaints", pendingComplaints);
        request.setAttribute("avgResolutionTime", String.format("%.2f", avgResolutionTime));
        request.setAttribute("statusMap", statusMap);
        request.setAttribute("categoryMap", categoryMap);
        request.setAttribute("staffPerformance", staffPerformance);

        request.getRequestDispatcher("/views/admin/reports.jsp").forward(request, response);
    }
}
