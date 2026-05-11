<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hostel.model.Complaint" %>
<jsp:include page="../includes/header.jsp" />
<title>Update Complaint - Staff</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-edit me-2"></i>Update Complaint</a>
            <div class="ms-auto">
                <a class="btn btn-light btn-sm" href="<%= request.getContextPath() %>/staff/dashboard"><i class="fas fa-arrow-left me-1"></i> Back</a>
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <%
                    Complaint complaint = (Complaint) request.getAttribute("complaint");
                    if (complaint != null) {
                %>
                
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-white py-3">
                        <h5 class="mb-0 fw-bold">Complaint Details #<%= complaint.getComplaintId() %></h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-3">
                            <div class="col-sm-4 fw-bold text-muted small">Category</div>
                            <div class="col-sm-8"><span class="badge bg-secondary px-3"><%= complaint.getCategory() %></span></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-sm-4 fw-bold text-muted small">Room</div>
                            <div class="col-sm-8"><i class="fas fa-door-open me-2 text-primary"></i><%= complaint.getRoomNumber() %></div>
                        </div>
                        <div class="row mb-3">
                            <div class="col-sm-4 fw-bold text-muted small">Current Status</div>
                            <div class="col-sm-8">
                                <span class="status-badge status-<%= complaint.getStatus().toLowerCase().replace("_", "-") %>">
                                    <%= complaint.getStatus() %>
                                </span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-4 fw-bold text-muted small">Description</div>
                            <div class="col-sm-8 text-dark bg-light p-3 rounded small"><%= complaint.getDescription() %></div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0">
                    <div class="card-body p-4">
                        <h5 class="fw-bold mb-4">Update Progress</h5>
                        <form method="POST" action="<%= request.getContextPath() %>/staff/update-complaint">
                            <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">
                            
                            <div class="mb-4">
                                <label for="status" class="form-label small fw-bold text-muted">New Status</label>
                                <select id="status" name="status" class="form-select" required>
                                    <option value="ASSIGNED" <%= "ASSIGNED".equals(complaint.getStatus()) ? "selected" : "" %>>Assigned</option>
                                    <option value="IN_PROGRESS" <%= "IN_PROGRESS".equals(complaint.getStatus()) ? "selected" : "" %>>In Progress</option>
                                    <option value="RESOLVED" <%= "RESOLVED".equals(complaint.getStatus()) ? "selected" : "" %>>Resolved</option>
                                </select>
                            </div>

                            <div class="mb-4">
                                <label for="notes" class="form-label small fw-bold text-muted">Notes / Progress Update</label>
                                <textarea id="notes" name="notes" class="form-control" rows="4" placeholder="Enter your progress notes here..."><%= complaint.getNotes() != null ? complaint.getNotes() : "" %></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary btn-lg w-100 shadow-sm mt-2">
                                <i class="fas fa-save me-2"></i> Update Complaint
                            </button>
                        </form>
                    </div>
                </div>

                <% } else { %>
                <div class="alert alert-danger text-center py-5 shadow-sm">
                    <i class="fas fa-exclamation-triangle fa-3x mb-3"></i>
                    <p class="mb-0">Complaint details not found.</p>
                </div>
                <% } %>
            </div>
        </div>
    </div>
<jsp:include page="../includes/footer.jsp" />
