<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Hostel Complaint Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', sans-serif;
        }
        .login-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
            background: white;
        }
        .login-header {
            background: #fff;
            padding: 30px 30px 10px;
            text-align: center;
        }
        .login-header h1 {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }
        .login-body {
            padding: 20px 30px 30px;
        }
        .form-control {
            border-radius: 8px;
            padding: 12px;
            border: 1px solid #dee2e6;
        }
        .form-control:focus {
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
            border-color: #667eea;
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            color: white;
            transition: all 0.3s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            color: white;
        }
        .login-footer {
            padding: 20px;
            text-align: center;
            background: #f8f9fa;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="login-header">
            <i class="fas fa-hotel fa-3x mb-3" style="color: #667eea !important;"></i>
            <h1>Welcome Back</h1>
            <p class="text-muted small">Hostel Complaint Management System</p>
        </div>

        <div class="login-body">
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

            <form method="POST" action="<%= request.getContextPath() %>/login">
                <div class="mb-3">
                    <label for="email" class="form-label small fw-bold">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control" id="email" name="email" placeholder="name@hostel.com" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label for="password" class="form-label small fw-bold">Password</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="fas fa-lock"></i></span>
                        <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-login w-100">Login <i class="fas fa-sign-in-alt ms-2"></i></button>
            </form>
        </div>

        <div class="login-footer">
            <p class="mb-0 small text-muted">Don't have an account? <a href="<%= request.getContextPath() %>/register" class="text-primary fw-bold text-decoration-none">Register here</a></p>
        </div>
    </div>
</body>
</html>
