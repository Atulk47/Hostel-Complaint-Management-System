<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.hostel.model.Complaint" %>
<%@ page import="com.hostel.model.ComplaintTimeline" %>
<jsp:include page="../includes/header.jsp" />
<title>Complaint Timeline - Student Portal</title>
<style>
    .timeline {
        position: relative;
        padding-left: 3rem;
        margin-top: 2rem;
    }
    .timeline::before {
        content: "";
        position: absolute;
        left: 0.75rem;
        top: 0;
        bottom: 0;
        width: 2px;
        background: #dee2e6;
    }
    .timeline-item {
        position: relative;
        margin-bottom: 2rem;
    }
    .timeline-item::before {
        content: "";
        position: absolute;
        left: -2.25rem;
        top: 0.25rem;
        width: 1rem;
        height: 1rem;
        border-radius: 50%;
        background: #667eea;
        border: 2px solid #fff;
        box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
    }
    .timeline-date {
        font-size: 0.8rem;
        color: #6c757d;
        font-weight: 600;
        margin-bottom: 0.25rem;
    }
    .timeline-title {
        font-weight: 700;
        color: #343a40;
        margin-bottom: 0.5rem;
    }
    .timeline-body {
        font-size: 0.9rem;
        color: #495057;
        background: #f8f9fa;
        padding: 1rem;
        border-radius: 0.5rem;
    }
</style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-stream me-2"></i>Track Progress</a>
            <div class="ms-auto">
                <a class="btn btn-light btn-sm" href="<%= request.getContextPath() %>/student/dashboard"><i class="fas fa-arrow-left me-1"></i> Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <%
            Complaint complaint = (Complaint) request.getAttribute("complaint");
            if (complaint != null) {
        %>
        
        <div class="row">
            <div class="col-md-4 mb-4">
                <div class="card shadow-sm sticky-top" style="top: 20px;">
                    <div class="card-header bg-white py-3">
                        <h6 class="mb-0 fw-bold text-dark">Complaint Info</h6>
                    </div>
                    <div class="card-body">
                        <div class="mb-3">
                            <label class="small text-muted fw-bold d-block">ID</label>
                            <span class="fw-bold">#<%= complaint.getComplaintId() %></span>
                        </div>
                        <div class="mb-3">
                            <label class="small text-muted fw-bold d-block">Category</label>
                            <span class="badge bg-secondary-subtle text-secondary border px-2"><%= complaint.getCategory() %></span>
                        </div>
                        <div class="mb-3">
                            <label class="small text-muted fw-bold d-block">Room</label>
                            <span><%= complaint.getRoomNumber() %></span>
                        </div>
                        <div class="mb-3">
                            <label class="small text-muted fw-bold d-block">Current Status</label>
                            <span class="status-badge status-<%= complaint.getStatus().toLowerCase().replace("_", "-") %>">
                                <%= complaint.getStatus() %>
                            </span>
                        </div>
                        <hr>
                        <div>
                            <label class="small text-muted fw-bold d-block mb-1">Original Description</label>
                            <p class="small text-muted bg-light p-2 rounded mb-0"><%= complaint.getDescription() %></p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4 p-md-5">
                        <h4 class="fw-bold mb-4">Activity Timeline</h4>
                        
                        <%
                            List<ComplaintTimeline> timeline = (List<ComplaintTimeline>) request.getAttribute("timeline");
                            if (timeline != null && !timeline.isEmpty()) {
                        %>
                        <div class="timeline">
                            <% for (ComplaintTimeline entry : timeline) { %>
                            <div class="timeline-item">
                                <div class="timeline-date"><%= entry.getTimestamp() %></div>
                                <div class="timeline-title text-primary"><%= entry.getAction() %></div>
                                <% if (entry.getRemarks() != null && !entry.getRemarks().isEmpty()) { %>
                                <div class="timeline-body shadow-sm">
                                    <i class="fas fa-comment-dots me-2 text-muted"></i><%= entry.getRemarks() %>
                                </div>
                                <% } %>
                            </div>
                            <% } %>
                        </div>
                        <% } else { %>
                        <div class="text-center py-5">
                            <i class="fas fa-clock fa-3x text-light mb-3"></i>
                            <p class="text-muted">No activity recorded yet.</p>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>
        </div>

        <% } else { %>
        <div class="alert alert-danger text-center shadow-sm">
            <i class="fas fa-search fa-2x mb-3"></i>
            <p class="mb-0">Complaint record not found.</p>
        </div>
        <% } %>
    </div>
<jsp:include page="../includes/footer.jsp" />
