package com.hostel.controller;

import com.hostel.dao.ComplaintDAO;
import com.hostel.dao.TimelineDAO;
import com.hostel.dao.UserDAO;
import com.hostel.model.Complaint;
import com.hostel.model.ComplaintTimeline;
import com.hostel.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AssignComplaintServlet
 * Handles complaint assignment to staff by admin
 */
@WebServlet("/admin/assign-complaint")
public class AssignComplaintServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ComplaintDAO complaintDAO = new ComplaintDAO();
    private UserDAO userDAO = new UserDAO();
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
            Complaint complaint = complaintDAO.getComplaintById(complaintId);

            if (complaint == null) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                return;
            }

            User[] staffList = userDAO.getAllStaff();

            request.setAttribute("complaint", complaint);
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("/views/admin/assignComplaint.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
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

        int adminId = (Integer) session.getAttribute("userId");
        String complaintIdStr = request.getParameter("complaintId");
        String staffIdStr = request.getParameter("staffId");

        if (complaintIdStr == null || staffIdStr == null) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            return;
        }

        try {
            int complaintId = Integer.parseInt(complaintIdStr);
            int staffId = Integer.parseInt(staffIdStr);

            if (complaintDAO.assignComplaintToStaff(complaintId, staffId)) {
                // Add timeline entry
                User staff = userDAO.getUserById(staffId);
                String action = "Assigned to Staff: " + (staff != null ? staff.getName() : "Staff ID: " + staffId);
                ComplaintTimeline timeline = new ComplaintTimeline(
                    complaintId,
                    action,
                    adminId,
                    "Complaint assigned by admin"
                );
                timelineDAO.addTimelineEntry(timeline);

                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                request.setAttribute("error", "Failed to assign complaint");
                Complaint complaint = complaintDAO.getComplaintById(complaintId);
                User[] staffList = userDAO.getAllStaff();
                request.setAttribute("complaint", complaint);
                request.setAttribute("staffList", staffList);
                request.getRequestDispatcher("/views/admin/assignComplaint.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }
}
