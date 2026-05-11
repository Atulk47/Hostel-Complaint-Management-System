package com.hostel.filter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

/**
 * Authentication Filter
 * Protects URLs based on user roles
 * Ensures only authenticated users can access protected resources
 */
@WebFilter(urlPatterns = {"/student/*", "/staff/*", "/admin/*"})
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization if needed
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        HttpSession session = httpRequest.getSession(false);
        
        // Check if user is logged in
        if (session == null || session.getAttribute("userId") == null) {
            // User is not authenticated, redirect to login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }
        
        // Get user role and requested resource
        String userRole = (String) session.getAttribute("userRole");
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        String path = requestURI.substring(contextPath.length());
        
        // Role-based access control
        boolean isAuthorized = false;
        
        if (path.startsWith("/student/")) {
            // Students can only access /student/* resources
            isAuthorized = "STUDENT".equals(userRole);
        } else if (path.startsWith("/staff/")) {
            // Staff can only access /staff/* resources
            isAuthorized = "STAFF".equals(userRole);
        } else if (path.startsWith("/admin/")) {
            // Admin can only access /admin/* resources
            isAuthorized = "ADMIN".equals(userRole);
        }
        
        if (!isAuthorized) {
            // User doesn't have permission, redirect to login
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.jsp");
            return;
        }
        
        // User is authorized, continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // Cleanup if needed
    }
}
