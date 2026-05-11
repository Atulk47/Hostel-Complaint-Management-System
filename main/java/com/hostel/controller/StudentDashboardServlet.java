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
 * StudentDashboardServlet
 * Handles student dashboard
 */
@WebServlet("/student/dashboard")
public class StudentDashboardServlet extends HttpServlet {
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

        int studentId = (Integer) session.getAttribute("userId");

        // Get student's complaints
        List<Complaint> complaints = complaintDAO.getComplaintsByStudent(studentId);

        request.setAttribute("complaints", complaints);
        request.getRequestDispatcher("/views/student/studentDashboard.jsp").forward(request, response);
    }
}
