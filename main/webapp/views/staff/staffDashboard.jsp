<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hostel.model.Complaint" %>
<jsp:include page="../includes/header.jsp" />
<title>Staff Dashboard - Hostel Complaint Management</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-tools me-2"></i>Staff Dashboard</a>
            <div class="ms-auto">
                <span class="text-white me-3 small">Welcome, <strong><%= session.getAttribute("userName") %></strong></span>
                <a class="btn btn-outline-light btn-sm" href="<%= request.getContextPath() %>/logout"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <%
            List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
            int total = complaints != null ? complaints.size() : 0;
            int assigned = 0, inProgress = 0, resolved = 0;
            
            if (complaints != null) {
                for (Complaint c : complaints) {
                    if ("ASSIGNED".equals(c.getStatus())) assigned++;
                    else if ("IN_PROGRESS".equals(c.getStatus())) inProgress++;
                    else if ("RESOLVED".equals(c.getStatus())) resolved++;
                }
            }
        %>

        <div class="row mb-4">
            <div class="col-md-4 mb-3">
                <div class="card bg-warning text-dark stat-card h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase mb-1 small fw-bold">Assigned Tasks</h6>
                            <h2 class="mb-0 fw-bold"><%= assigned %></h2>
                        </div>
                        <i class="fas fa-thumbtack fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card bg-info text-white stat-card h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase mb-1 small fw-bold">In Progress</h6>
                            <h2 class="mb-0 fw-bold"><%= inProgress %></h2>
                        </div>
                        <i class="fas fa-clock fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-4 mb-3">
                <div class="card bg-success text-white stat-card h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase mb-1 small fw-bold">Resolved</h6>
                            <h2 class="mb-0 fw-bold"><%= resolved %></h2>
                        </div>
                        <i class="fas fa-check-double fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm overflow-hidden">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 fw-bold text-dark">My Assigned Complaints</h5>
            </div>
            <div class="table-responsive">
                <% if (complaints != null && !complaints.isEmpty()) { %>
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Category</th>
                            <th>Room</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Date</th>
                            <th class="pe-4 text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Complaint complaint : complaints) { %>
                        <tr>
                            <td class="ps-4 fw-bold text-muted">#<%= complaint.getComplaintId() %></td>
                            <td><span class="badge bg-secondary-subtle text-secondary border px-2 py-1"><%= complaint.getCategory() %></span></td>
                            <td><i class="fas fa-door-open me-1 text-muted"></i> <%= complaint.getRoomNumber() %></td>
                            <td class="small text-muted"><%= complaint.getDescription().substring(0, Math.min(50, complaint.getDescription().length())) %>...</td>
                            <td>
                                <span class="status-badge status-<%= complaint.getStatus().toLowerCase().replace("_", "-") %>">
                                    <%= complaint.getStatus() %>
                                </span>
                            </td>
                            <td class="small"><%= complaint.getDateCreated() != null ? complaint.getDateCreated().toString().substring(0, 10) : "N/A" %></td>
                            <td class="pe-4 text-end">
                                <a href="<%= request.getContextPath() %>/staff/update-complaint?complaintId=<%= complaint.getComplaintId() %>" class="btn btn-primary btn-sm shadow-sm px-3">
                                    <i class="fas fa-edit me-1"></i> Update
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="text-center py-5">
                    <i class="fas fa-tasks fa-3x text-light mb-3"></i>
                    <p class="text-muted">No complaints assigned to you at the moment.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
<jsp:include page="../includes/footer.jsp" />
