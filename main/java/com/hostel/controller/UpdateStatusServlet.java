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

/**
 * UpdateStatusServlet
 * Handles complaint status updates by staff
 */
@WebServlet("/staff/update-complaint")
public class UpdateStatusServlet extends HttpServlet {
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
            response.sendRedirect(request.getContextPath() + "/staff/dashboard");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdStr);
            Complaint complaint = complaintDAO.getComplaintById(complaintId);

            if (complaint == null) {
                response.sendRedirect(request.getContextPath() + "/staff/dashboard");
                return;
            }

            request.setAttribute("complaint", complaint);
            request.getRequestDispatcher("/views/staff/updateComplaint.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/dashboard");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int staffId = (Integer) session.getAttribute("userId");
        String complaintIdStr = request.getParameter("complaintId");
        String status = request.getParameter("status");
        String notes = request.getParameter("notes");

        if (complaintIdStr == null || status == null || status.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/staff/dashboard");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdStr);

            if (complaintDAO.updateComplaintStatus(complaintId, status)) {
                if (notes != null && !notes.trim().isEmpty()) {
                    complaintDAO.updateComplaintNotes(complaintId, notes);
                }

                // Add timeline entry
                String action = "Status Updated to " + status;
                ComplaintTimeline timeline = new ComplaintTimeline(
                    complaintId,
                    action,
                    staffId,
                    notes
                );
                timelineDAO.addTimelineEntry(timeline);

                request.setAttribute("success", "Complaint updated successfully");
            } else {
                request.setAttribute("error", "Failed to update complaint");
            }

            Complaint complaint = complaintDAO.getComplaintById(complaintId);
            request.setAttribute("complaint", complaint);
            request.getRequestDispatcher("/views/staff/updateComplaint.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/staff/dashboard");
        }
    }
}
