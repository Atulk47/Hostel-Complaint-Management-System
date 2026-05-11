<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - Hostel Complaint Management System</title>
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
            padding: 40px 20px;
        }
        .register-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
            overflow: hidden;
            width: 100%;
            max-width: 500px;
            background: white;
        }
        .register-header {
            background: #fff;
            padding: 30px 30px 10px;
            text-align: center;
        }
        .register-header h1 {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }
        .register-body {
            padding: 20px 30px 30px;
        }
        .form-control, .form-select {
            border-radius: 8px;
            padding: 12px;
            border: 1px solid #dee2e6;
        }
        .form-control:focus, .form-select:focus {
            box-shadow: 0 0 0 0.25rem rgba(102, 126, 234, 0.25);
            border-color: #667eea;
        }
        .btn-register {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
            border-radius: 8px;
            padding: 12px;
            font-weight: 600;
            color: white;
            transition: all 0.3s;
        }
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            color: white;
        }
        .register-footer {
            padding: 20px;
            text-align: center;
            background: #f8f9fa;
            border-top: 1px solid #eee;
        }
    </style>
</head>
<body>
    <div class="register-card">
        <div class="register-header">
            <i class="fas fa-user-plus fa-3x mb-3" style="color: #667eea !important;"></i>
            <h1>Create Account</h1>
            <p class="text-muted small">Join Hostel Complaint Management System</p>
        </div>

        <div class="register-body">
            <%
                String error = (String) request.getAttribute("error");
            %>

            <% if (error != null) { %>
                <div class="alert alert-danger d-flex align-items-center" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <div><%= error %></div>
                </div>
            <% } %>

            <form method="POST" action="<%= request.getContextPath() %>/register">
                <div class="mb-3">
                    <label for="name" class="form-label small fw-bold">Full Name</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="fas fa-user"></i></span>
                        <input type="text" class="form-control" id="name" name="name" placeholder="John Doe" required>
                    </div>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label small fw-bold">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="fas fa-envelope"></i></span>
                        <input type="email" class="form-control" id="email" name="email" placeholder="john@example.com" required>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-3">
                        <label for="password" class="form-label small fw-bold">Password</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="fas fa-lock"></i></span>
                            <input type="password" class="form-control" id="password" name="password" placeholder="••••••••" required>
                        </div>
                    </div>
                    <div class="col-md-6 mb-3">
                        <label for="role" class="form-label small fw-bold">Role</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light text-muted"><i class="fas fa-user-tag"></i></span>
                            <select class="form-select" id="role" name="role" required onchange="toggleRoom(this.value)">
                                <option value="STUDENT">Student</option>
                                <option value="STAFF">Maintenance Staff</option>
                                <option value="ADMIN">Administrator</option>
                            </select>
                        </div>
                    </div>
                </div>

                <div class="mb-4" id="roomGroup">
                    <label for="roomNumber" class="form-label small fw-bold">Room Number</label>
                    <div class="input-group">
                        <span class="input-group-text bg-light text-muted"><i class="fas fa-door-closed"></i></span>
                        <input type="text" class="form-control" id="roomNumber" name="roomNumber" placeholder="e.g. A-101">
                    </div>
                </div>

                <button type="submit" class="btn btn-register w-100">Register <i class="fas fa-user-check ms-2"></i></button>
            </form>
        </div>

        <div class="register-footer">
            <p class="mb-0 small text-muted">Already have an account? <a href="<%= request.getContextPath() %>/login.jsp" class="text-primary fw-bold text-decoration-none">Login here</a></p>
        </div>
    </div>

    <script>
        function toggleRoom(role) {
            const roomGroup = document.getElementById('roomGroup');
            const roomInput = document.getElementById('roomNumber');
            if (role === 'STUDENT') {
                roomGroup.style.display = 'block';
                roomInput.required = true;
            } else {
                roomGroup.style.display = 'none';
                roomInput.required = false;
                roomInput.value = '';
            }
        }
        
        // Run on load
        window.onload = function() {
            toggleRoom(document.getElementById('role').value);
        };
    </script>
</body>
</html>
