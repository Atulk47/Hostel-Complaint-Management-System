<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<jsp:include page="../includes/header.jsp" />
<title>Complaint Reports - Admin</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-chart-pie me-2"></i>Analytics & Reports</a>
            <div class="ms-auto">
                <a class="btn btn-light btn-sm" href="<%= request.getContextPath() %>/admin/dashboard"><i class="fas fa-arrow-left me-1"></i> Back to Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <%
            Integer totalComplaints = (Integer) request.getAttribute("totalComplaints");
            Integer closedComplaints = (Integer) request.getAttribute("closedComplaints");
            Integer pendingComplaints = (Integer) request.getAttribute("pendingComplaints");
            String avgResolutionTime = (String) request.getAttribute("avgResolutionTime");
            Map<String, Integer> statusMap = (Map<String, Integer>) request.getAttribute("statusMap");
            Map<String, Integer> categoryMap = (Map<String, Integer>) request.getAttribute("categoryMap");
            Map<Integer, Integer> staffPerformance = (Map<Integer, Integer>) request.getAttribute("staffPerformance");
        %>

        <div class="row mb-4">
            <div class="col-md-3 mb-3">
                <div class="card shadow-sm h-100 border-start border-primary border-4">
                    <div class="card-body">
                        <h6 class="text-muted small text-uppercase fw-bold">Total Complaints</h6>
                        <h3 class="fw-bold mb-0"><%= totalComplaints != null ? totalComplaints : 0 %></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card shadow-sm h-100 border-start border-success border-4">
                    <div class="card-body">
                        <h6 class="text-muted small text-uppercase fw-bold">Closed</h6>
                        <h3 class="fw-bold mb-0 text-success"><%= closedComplaints != null ? closedComplaints : 0 %></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card shadow-sm h-100 border-start border-warning border-4">
                    <div class="card-body">
                        <h6 class="text-muted small text-uppercase fw-bold">Pending</h6>
                        <h3 class="fw-bold mb-0 text-warning"><%= pendingComplaints != null ? pendingComplaints : 0 %></h3>
                    </div>
                </div>
            </div>
            <div class="col-md-3 mb-3">
                <div class="card shadow-sm h-100 border-start border-info border-4">
                    <div class="card-body">
                        <h6 class="text-muted small text-uppercase fw-bold">Avg Resolution</h6>
                        <h3 class="fw-bold mb-0"><%= avgResolutionTime != null ? avgResolutionTime : "0" %> <span class="small fw-normal text-muted">hrs</span></h3>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-white py-3">
                        <h6 class="mb-0 fw-bold"><i class="fas fa-tasks me-2 text-primary"></i>Complaints by Status</h6>
                    </div>
                    <div class="card-body">
                        <%
                            if (statusMap != null && !statusMap.isEmpty()) {
                                int maxStatus = 1;
                                for (Integer value : statusMap.values()) {
                                    if (value > maxStatus) maxStatus = value;
                                }
                                for (Map.Entry<String, Integer> entry : statusMap.entrySet()) {
                                    int barPercent = (int) ((entry.getValue() * 100) / maxStatus);
                        %>
                            <div class="mb-3">
                                <div class="d-flex justify-content-between mb-1">
                                    <span class="small fw-bold text-muted"><%= entry.getKey() %></span>
                                    <span class="small fw-bold"><%= entry.getValue() %></span>
                                </div>
                                <div class="progress" style="height: 10px;">
                                    <div class="progress-bar bg-primary-gradient" role="progressbar" style="width: <%= barPercent %>%;"></div>
                                </div>
                            </div>
                        <%
                                }
                            } else {
                        %>
                            <p class="text-center text-muted py-4">No data available</p>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="col-md-6 mb-4">
                <div class="card shadow-sm h-100">
                    <div class="card-header bg-white py-3">
                        <h6 class="mb-0 fw-bold"><i class="fas fa-tags me-2 text-primary"></i>Complaints by Category</h6>
                    </div>
                    <div class="card-body p-0">
                        <table class="table table-hover mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-4 small">Category</th>
                                    <th class="pe-4 text-end small">Count</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (categoryMap != null && !categoryMap.isEmpty()) {
                                        for (Map.Entry<String, Integer> entry : categoryMap.entrySet()) {
                                %>
                                <tr>
                                    <td class="ps-4"><%= entry.getKey() %></td>
                                    <td class="pe-4 text-end fw-bold text-primary"><%= entry.getValue() %></td>
                                </tr>
                                <%
                                        }
                                    } else {
                                %>
                                <tr>
                                    <td colspan="2" class="text-center text-muted py-4">No data available</td>
                                </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="card shadow-sm">
            <div class="card-header bg-white py-3">
                <h6 class="mb-0 fw-bold"><i class="fas fa-users-cog me-2 text-primary"></i>Staff Performance (Handled Complaints)</h6>
            </div>
            <div class="card-body p-0">
                <div class="table-responsive">
                    <table class="table table-hover mb-0">
                        <thead class="table-light">
                            <tr>
                                <th class="ps-4 small">Staff ID</th>
                                <th class="pe-4 text-end small">Complaints Resolved/Assigned</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (staffPerformance != null && !staffPerformance.isEmpty()) {
                                    for (Map.Entry<Integer, Integer> entry : staffPerformance.entrySet()) {
                            %>
                            <tr>
                                <td class="ps-4"><i class="fas fa-user me-2 text-muted"></i> Staff #<%= entry.getKey() %></td>
                                <td class="pe-4 text-end fw-bold text-success"><%= entry.getValue() %></td>
                            </tr>
                            <%
                                    }
                                } else {
                            %>
                            <tr>
                                <td colspan="2" class="text-center text-muted py-4">No staff performance data available</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="../includes/footer.jsp" />
