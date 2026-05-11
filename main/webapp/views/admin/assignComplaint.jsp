<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hostel.model.Complaint" %>
<%@ page import="com.hostel.model.User" %>
<jsp:include page="../includes/header.jsp" />
<title>Assign Complaint - Admin</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-user-tag me-2"></i>Assign Task</a>
            <div class="ms-auto">
                <a class="btn btn-light btn-sm" href="<%= request.getContextPath() %>/admin/dashboard"><i class="fas fa-arrow-left me-1"></i> Back</a>
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
                            <div class="col-sm-4 fw-bold text-muted small">Room Number</div>
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
                        <h5 class="fw-bold mb-4 text-center">Assign Maintenance Staff</h5>
                        <form method="POST" action="<%= request.getContextPath() %>/admin/assign-complaint">
                            <input type="hidden" name="complaintId" value="<%= complaint.getComplaintId() %>">
                            
                            <div class="mb-4">
                                <label for="staffId" class="form-label small fw-bold text-muted">Select Staff Member</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-muted"><i class="fas fa-user-cog"></i></span>
                                    <select id="staffId" name="staffId" class="form-select form-select-lg" required style="font-size: 1rem;">
                                        <option value="">-- Choose a Staff Member --</option>
                                        <%
                                            User[] staffList = (User[]) request.getAttribute("staffList");
                                            if (staffList != null) {
                                                for (User staff : staffList) {
                                        %>
                                        <option value="<%= staff.getUserId() %>"><%= staff.getName() %> (ID: <%= staff.getUserId() %>)</option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                                <div class="form-text small mt-2">The selected staff member will be notified of this assignment.</div>
                            </div>

                            <button type="submit" class="btn btn-primary btn-lg w-100 shadow-sm mt-2">
                                <i class="fas fa-check-circle me-2"></i> Confirm Assignment
                            </button>
                        </form>
                    </div>
                </div>

                <% } else { %>
                <div class="alert alert-danger text-center">
                    <i class="fas fa-exclamation-triangle fa-2x mb-3"></i>
                    <p>Complaint not found or has been deleted.</p>
                    <a href="<%= request.getContextPath() %>/admin/dashboard" class="btn btn-outline-danger mt-2">Return to Dashboard</a>
                </div>
                <% } %>
            </div>
        </div>
    </div>
<jsp:include page="../includes/footer.jsp" />
