<%@ page contentType="text/html; charset=UTF-8" %>
<jsp:include page="../includes/header.jsp" />
<title>Submit Complaint - Student</title>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark mb-4">
        <div class="container">
            <a class="navbar-brand fw-bold" href="#"><i class="fas fa-plus-circle me-2"></i>New Request</a>
            <div class="ms-auto">
                <a class="btn btn-light btn-sm" href="<%= request.getContextPath() %>/student/dashboard"><i class="fas fa-arrow-left me-1"></i> Dashboard</a>
            </div>
        </div>
    </nav>

    <div class="container pb-5">
        <div class="row justify-content-center">
            <div class="col-md-7">
                <div class="card shadow-sm border-0">
                    <div class="card-body p-4 p-md-5">
                        <div class="text-center mb-4">
                            <h2 class="fw-bold">Submit Complaint</h2>
                            <p class="text-muted">Please provide details about the issue you're facing.</p>
                        </div>

                        <%
                            String error = (String) request.getAttribute("error");
                            String success = (String) request.getAttribute("success");
                        %>

                        <% if (error != null) { %>
                            <div class="alert alert-danger d-flex align-items-center" role="alert">
                                <i class="fas fa-exclamation-circle me-2"></i>
                                <div><%= error %></div>
                            </div>
                        <% } %>

                        <% if (success != null) { %>
                            <div class="alert alert-success d-flex align-items-center" role="alert">
                                <i class="fas fa-check-circle me-2"></i>
                                <div><%= success %></div>
                            </div>
                        <% } %>

                        <form method="POST" action="<%= request.getContextPath() %>/student/submit-complaint">
                            <div class="mb-4">
                                <label for="category" class="form-label fw-bold small text-muted">Category</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-muted"><i class="fas fa-tag"></i></span>
                                    <select class="form-select" id="category" name="category" required>
                                        <option value="">-- Select Category --</option>
                                        <option value="ELECTRICAL">Electrical</option>
                                        <option value="PLUMBING">Plumbing</option>
                                        <option value="INTERNET">Internet</option>
                                        <option value="CLEANLINESS">Cleanliness</option>
                                        <option value="SECURITY">Security</option>
                                        <option value="FURNITURE">Furniture</option>
                                    </select>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="roomNumber" class="form-label fw-bold small text-muted">Room Number</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-light text-muted"><i class="fas fa-door-open"></i></span>
                                    <input type="text" class="form-control" id="roomNumber" name="roomNumber" placeholder="e.g. A-101" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label for="description" class="form-label fw-bold small text-muted">Description</label>
                                <textarea class="form-control" id="description" name="description" rows="5" placeholder="Describe the problem in detail..." required></textarea>
                            </div>

                            <button type="submit" class="btn btn-primary btn-lg w-100 shadow-sm mt-2">
                                <i class="fas fa-paper-plane me-2"></i> Submit Complaint
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<jsp:include page="../includes/footer.jsp" />
