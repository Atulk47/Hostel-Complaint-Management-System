<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hostel.model.Complaint" %>
<jsp:include page="../includes/header.jsp" />
<title>Complaint History - Student Portal</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-history me-2"></i>History</a>
            <div class="ms-auto">
                <a class="btn btn-light btn-sm" href="<%= request.getContextPath() %>/student/dashboard"><i class="fas fa-arrow-left me-1"></i> Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <h2 class="fw-bold mb-4">Your Complaint History</h2>

        <div class="card shadow-sm border-0 overflow-hidden">
            <div class="table-responsive">
                <%
                    List<Complaint> complaints = (List<Complaint>) request.getAttribute("complaints");
                    if (complaints != null && !complaints.isEmpty()) {
                %>
                <table class="table table-hover align-middle mb-0">
                    <thead class="table-light">
                        <tr>
                            <th class="ps-4">ID</th>
                            <th>Category</th>
                            <th>Description</th>
                            <th>Room</th>
                            <th>Status</th>
                            <th>Submitted Date</th>
                            <th class="pe-4 text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Complaint complaint : complaints) { %>
                        <tr>
                            <td class="ps-4 fw-bold text-muted">#<%= complaint.getComplaintId() %></td>
                            <td><span class="badge bg-secondary-subtle text-secondary border px-2 py-1"><%= complaint.getCategory() %></span></td>
                            <td class="small text-muted text-wrap" style="max-width: 250px;"><%= complaint.getDescription() %></td>
                            <td><%= complaint.getRoomNumber() %></td>
                            <td>
                                <span class="status-badge status-<%= complaint.getStatus().toLowerCase().replace("_", "-") %>">
                                    <%= complaint.getStatus() %>
                                </span>
                            </td>
                            <td class="small text-muted"><%= complaint.getDateCreated() %></td>
                            <td class="pe-4 text-end">
                                <a href="<%= request.getContextPath() %>/student/timeline?complaintId=<%= complaint.getComplaintId() %>" class="btn btn-outline-primary btn-sm rounded-pill px-3">
                                    <i class="fas fa-search me-1"></i> Details
                                </a>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
                <% } else { %>
                <div class="text-center py-5">
                    <div class="mb-3 text-light">
                        <i class="fas fa-folder-open fa-4x"></i>
                    </div>
                    <h5 class="text-muted">History is empty</h5>
                    <p class="text-muted small">You haven't submitted any complaints yet.</p>
                    <a href="<%= request.getContextPath() %>/student/submit-complaint" class="btn btn-primary mt-2">Submit a Complaint</a>
                </div>
                <% } %>
            </div>
        </div>
    </div>
<jsp:include page="../includes/footer.jsp" />
