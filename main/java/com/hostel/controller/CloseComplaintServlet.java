package com.hostel.controller;

import com.hostel.dao.ComplaintDAO;
import com.hostel.dao.TimelineDAO;
import com.hostel.model.ComplaintTimeline;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * CloseComplaintServlet
 * Handles closing complaints by admin
 */
@WebServlet("/admin/close-complaint")
public class CloseComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComplaintDAO complaintDAO = new ComplaintDAO();
    private TimelineDAO timelineDAO = new TimelineDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String complaintIdStr = request.getParameter("complaintId");
        if (complaintIdStr == null || complaintIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdStr);
            int adminId = (Integer) session.getAttribute("userId");

            // Close the complaint
            if (complaintDAO.closeComplaint(complaintId)) {
                // Add timeline entry
                ComplaintTimeline timeline = new ComplaintTimeline(
                    complaintId,
                    "Complaint Closed",
                    adminId,
                    "Complaint closed by admin"
                );
                timelineDAO.addTimelineEntry(timeline);
            }

            response.sendRedirect(request.getContextPath() + "/admin/dashboard");

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }
}
