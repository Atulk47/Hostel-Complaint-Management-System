<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hostel.model.Complaint" %>
<jsp:include page="../includes/header.jsp" />
<title>Admin Dashboard - Hostel Complaint Management</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-hotel me-2"></i>Admin Dashboard</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto align-items-center">
                    <li class="nav-item">
                        <span class="nav-link text-white me-3">Welcome, <strong><%= session.getAttribute("userName") %></strong></span>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-light btn-sm me-2" href="<%= request.getContextPath() %>/admin/reports"><i class="fas fa-chart-bar me-1"></i> Reports</a>
                    </li>
                    <li class="nav-item">
                        <a class="btn btn-outline-light btn-sm" href="<%= request.getContextPath() %>/logout"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <div class="row mb-4">
            <div class="col-md-12">
                <h2 class="fw-bold text-dark mb-4">Complaint Overview</h2>
            </div>
            
            <%
                List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
                int total = complaints != null ? complaints.size() : 0;
                int submitted = 0, assigned = 0, inProgress = 0, closed = 0;
                
                if (complaints != null) {
                    for (Complaint c : complaints) {
                        if ("SUBMITTED".equals(c.getStatus())) submitted++;
                        else if ("ASSIGNED".equals(c.getStatus())) assigned++;
                        else if ("IN_PROGRESS".equals(c.getStatus())) inProgress++;
                        else if ("CLOSED".equals(c.getStatus())) closed++;
                    }
                }
            %>
            
            <div class="col-md-3 mb-3">
                <div class="card bg-primary text-white stat-card h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase mb-1 small">Total Complaints</h6>
                            <h2 class="mb-0 fw-bold"><%= total %></h2>
                        </div>
                        <i class="fas fa-list-ul fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card bg-warning text-dark stat-card h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase mb-1 small">Submitted</h6>
                            <h2 class="mb-0 fw-bold"><%= submitted %></h2>
                        </div>
                        <i class="fas fa-paper-plane fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card bg-info text-white stat-card h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase mb-1 small">In Progress</h6>
                            <h2 class="mb-0 fw-bold"><%= inProgress %></h2>
                        </div>
                        <i class="fas fa-spinner fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card bg-success text-white stat-card h-100">
                    <div class="card-body d-flex justify-content-between align-items-center">
                        <div>
                            <h6 class="text-uppercase mb-1 small">Closed</h6>
                            <h2 class="mb-0 fw-bold"><%= closed %></h2>
                        </div>
                        <i class="fas fa-check-circle fa-2x opacity-50"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mb-4 shadow-sm">
            <div class="card-body bg-light">
                <form method="POST" action="<%= request.getContextPath() %>/admin/filter-complaints" class="row g-3 align-items-end">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Category</label>
                        <select name="category" class="form-select">
                            <option value="">All Categories</option>
                            <option value="ELECTRICAL">Electrical</option>
                            <option value="PLUMBING">Plumbing</option>
                            <option value="INTERNET">Internet</option>
                            <option value="CLEANLINESS">Cleanliness</option>
                            <option value="SECURITY">Security</option>
                            <option value="FURNITURE">Furniture</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold">Status</label>
                        <select name="status" class="form-select">
                            <option value="">All Status</option>
                            <option value="SUBMITTED">Submitted</option>
                            <option value="ASSIGNED">Assigned</option>
                            <option value="IN_PROGRESS">In Progress</option>
                            <option value="RESOLVED">Resolved</option>
                            <option value="CLOSED">Closed</option>
                        </select>
                    </div>
                    <div class="col-md-4">
                        <button type="submit" class="btn btn-primary w-100"><i class="fas fa-filter me-2"></i>Filter Complaints</button>
                    </div>
                </form>
            </div>
        </div>

        <div class="card shadow-sm overflow-hidden">
            <div class="card-header bg-white py-3">
                <h5 class="mb-0 fw-bold text-dark">Recent Complaints</h5>
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
                            <th>Assigned Staff</th>
                            <th>Date</th>
                            <th class="pe-4 text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Complaint complaint : complaints) { %>
                        <tr>
                            <td class="ps-4 fw-bold text-muted">#<%= complaint.getComplaintId() %></td>
                            <td><span class="badge bg-secondary-subtle text-secondary border border-secondary-subtle px-2 py-1"><%= complaint.getCategory() %></span></td>
                            <td><i class="fas fa-door-open me-1 text-muted"></i> <%= complaint.getRoomNumber() %></td>
                            <td class="small text-muted"><%= complaint.getDescription().substring(0, Math.min(40, complaint.getDescription().length())) %>...</td>
                            <td>
                                <span class="status-badge status-<%= complaint.getStatus().toLowerCase().replace("_", "-") %>">
                                    <%= complaint.getStatus() %>
                                </span>
                            </td>
                            <td>
                                <% if (complaint.getAssignedStaff() != null) { %>
                                    <div class="d-flex align-items-center">
                                        <i class="fas fa-user-cog me-2 text-primary"></i>
                                        <span>Staff ID: <%= complaint.getAssignedStaff() %></span>
                                    </div>
                                <% } else { %>
                                    <span class="text-muted italic small">Not Assigned</span>
                                <% } %>
                            </td>
                            <td class="small"><%= complaint.getDateCreated() != null ? complaint.getDateCreated().toString().substring(0, 10) : "N/A" %></td>
                            <td class="pe-4 text-end">
                                <div class="btn-group btn-group-sm">
                                    <% if (!"CLOSED".equals(complaint.getStatus())) { %>
                                    <a href="<%= request.getContextPath() %>/admin/assign-complaint?complaintId=<%= complaint.getComplaintId() %>" class="btn btn-outline-primary" title="Assign Staff"><i class="fas fa-user-plus"></i></a>
                                    <% } %>
                                    <a href="<%= request.getContextPath() %>/admin/close-complaint?complaintId=<%= complaint.getComplaintId() %>" class="btn btn-outline-danger" title="Close Complaint"><i class="fas fa-times-circle"></i></a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="text-center py-5">
                    <i class="fas fa-clipboard-list fa-3x text-light mb-3"></i>
                    <p class="text-muted">No complaints found matching your criteria.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
<jsp:include page="../includes/footer.jsp" />
