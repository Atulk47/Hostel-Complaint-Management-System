<%@ page isErrorPage="false" %>
<!DOCTYPE html>
<html>
<head>
    <title>404 - Not Found</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body { background-color: #f8f9fa; height: 100vh; display: flex; align-items: center; justify-content: center; text-align: center; }
        .error-container { max-width: 500px; padding: 40px; background: white; border-radius: 15px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); }
        .error-code { font-size: 80px; font-weight: 800; color: #667eea; margin-bottom: 20px; }
    </style>
</head>
<body>
    <div class="error-container">
        <div class="error-code">404</div>
        <h2 class="fw-bold mb-3">Page Not Found</h2>
        <p class="text-muted mb-4">Oops! The page you're looking for doesn't exist or has been moved.</p>
        <a href="<%= request.getContextPath() %>/login.jsp" class="btn btn-primary px-4 py-2">
            <i class="fas fa-home me-2"></i>Back to Safety
        </a>
    </div>
</body>
</html>
