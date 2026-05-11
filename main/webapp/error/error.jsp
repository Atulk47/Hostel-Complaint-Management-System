<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Application Error</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; height: 100vh; display: flex; align-items: center; justify-content: center; text-align: center; }
        .error-container { max-width: 600px; padding: 40px; background: white; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
    </style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-exclamation-triangle fa-5x text-warning mb-4"></i>
        <h2 class="fw-bold mb-3">Application Error</h2>
        <p class="text-muted mb-4">We encountered an unexpected problem while processing your request.</p>
        <div class="alert alert-light border text-start small mb-4">
            <strong>Message:</strong> <%= exception != null ? exception.getMessage() : "Unknown error occurred" %>
        </div>
        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-primary px-4 py-2">
            <i class="fas fa-home me-2"></i>Return to Safety
        </a>
    </div>
</body>
</html>
