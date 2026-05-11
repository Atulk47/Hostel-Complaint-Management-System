<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hostel.model.Complaint" %>
<jsp:include page="../includes/header.jsp" />
<title>Student Dashboard - Hostel Complaint Management</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-graduation-cap me-2"></i>Student Portal</a>
            <div class="ms-auto">
                <span class="text-white me-3 small">Welcome, <strong><%= session.getAttribute("userName") %></strong></span>
                <a class="btn btn-outline-light btn-sm" href="<%= request.getContextPath() %>/logout"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <div class="row mb-4">
            <div class="col-md-8">
                <h2 class="fw-bold text-dark">My Dashboard</h2>
                <p class="text-muted">Manage and track your hostel maintenance requests.</p>
            </div>
            <div class="col-md-4 text-md-end d-flex align-items-center justify-content-md-end">
                <a href="<%= request.getContextPath() %>/student/submit-complaint" class="btn btn-primary btn-lg shadow-sm">
                    <i class="fas fa-plus-circle me-2"></i> Submit New Complaint
                </a>
            </div>
        </div>

        <%
            List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
            int total = complaints != null ? complaints.size() : 0;
            int pending = 0, resolved = 0;
            
            if (complaints != null) {
                for (Complaint c : complaints) {
                    if ("RESOLVED".equals(c.getStatus()) || "CLOSED".equals(c.getStatus())) resolved++;
                    else pending++;
                }
            }
        %>

        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <div class="card shadow-sm h-100 border-0">
                    <div class="card-body text-center">
                        <div class="feature-icon bg-primary bg-gradient text-white mb-3 mx-auto d-flex align-items-center justify-content-center rounded-circle" style="width: 60px; height: 60px;">
                            <i class="fas fa-clipboard-list fa-lg"></i>
                        </div>
                        <h3 class="fw-bold mb-1"><%= total %></h3>
                        <p class="text-muted mb-0">Total Requests</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card shadow-sm h-100 border-0">
                    <div class="card-body text-center">
                        <div class="feature-icon bg-warning bg-gradient text-white mb-3 mx-auto d-flex align-items-center justify-content-center rounded-circle" style="width: 60px; height: 60px;">
                            <i class="fas fa-hourglass-half fa-lg"></i>
                        </div>
                        <h3 class="fw-bold mb-1"><%= pending %></h3>
                        <p class="text-muted mb-0">Pending / In Progress</p>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card shadow-sm h-100 border-0">
                    <div class="card-body text-center">
                        <div class="feature-icon bg-success bg-gradient text-white mb-3 mx-auto d-flex align-items-center justify-content-center rounded-circle" style="width: 60px; height: 60px;">
                            <i class="fas fa-check-circle fa-lg"></i>
                        </div>
                        <h3 class="fw-bold mb-1"><%= resolved %></h3>
                        <p class="text-muted mb-0">Resolved / Closed</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm border-0 overflow-hidden">
            <div class="card-header bg-white py-3 d-flex justify-content-between align-items-center">
                <h5 class="mb-0 fw-bold">Recent Complaints</h5>
                <a href="<%= request.getContextPath() %>/student/complaint-history" class="btn btn-link btn-sm text-decoration-none">View All History</a>
            </div>
            <div class="table-responsive">
                <% if (complaints != null && !complaints.isEmpty()) { %>
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Date Submitted</th>
                            <th class="pe-4 text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            int count = 0;
                            for (Complaint complaint : complaints) { 
                                if (count++ >= 5) break; // Only show last 5
                        %>
                        <tr>
                            <td class="ps-4 fw-bold text-muted">#<%= complaint.getComplaintId() %></td>
                            <td><span class="badge bg-secondary-subtle text-secondary border px-2 py-1"><%= complaint.getCategory() %></span></td>
                            <td class="small text-muted"><%= complaint.getDescription().substring(0, Math.min(50, complaint.getDescription().length())) %>...</td>
                            <td>
                                <span class="status-badge status-<%= complaint.getStatus().toLowerCase().replace("_", "-") %>">
                                    <%= complaint.getStatus() %>
                                </span>
                            </td>
                            <td class="small text-muted"><%= complaint.getDateCreated() != null ? complaint.getDateCreated().toString().substring(0, 16) : "N/A" %></td>
                            <td class="pe-4 text-end">
                                <a href="<%= request.getContextPath() %>/student/timeline?complaintId=<%= complaint.getComplaintId() %>" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                    <i class="fas fa-eye me-1"></i> Track
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="text-center py-5">
                    <div class="mb-3 text-light">
                        <i class="fas fa-inbox fa-4x"></i>
                    </div>
                    <h5 class="text-muted">No complaints yet</h5>
                    <p class="text-muted small">When you submit a complaint, it will appear here.</p>
                    <a href="<%= request.getContextPath() %>/student/submit-complaint" class="btn btn-primary mt-2">Submit Your First Complaint</a>
                </div>
                <% } %>
            </div>
        </div>
    </div>
<jsp:include page="../includes/footer.jsp" />
