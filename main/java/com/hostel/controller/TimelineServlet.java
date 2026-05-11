package com.hostel.controller;

import com.hostel.dao.ComplaintDAO;
import com.hostel.dao.TimelineDAO;
import com.hostel.model.Complaint;
import com.hostel.model.ComplaintTimeline;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

/**
 * TimelineServlet
 * Handles complaint timeline display
 */
@WebServlet("/student/timeline")
public class TimelineServlet extends HttpServlet {
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
            response.sendRedirect(request.getContextPath() + "/student/dashboard");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdStr);
            Complaint complaint = complaintDAO.getComplaintById(complaintId);

            if (complaint == null) {
                response.sendRedirect(request.getContextPath() + "/student/dashboard");
                return;
            }

            List<ComplaintTimeline> timeline = timelineDAO.getTimelineByComplaintId(complaintId);

            request.setAttribute("complaint", complaint);
            request.setAttribute("timeline", timeline);
            request.getRequestDispatcher("/views/student/complaintTimeline.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/student/dashboard");
        }
    }
}
