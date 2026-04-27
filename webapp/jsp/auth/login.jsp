<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Secure File Sharing</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #28a745;
            --danger-color: #dc3545;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .login-card {
            max-width: 450px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .login-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .login-body {
            padding: 30px;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 12px 15px;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }
        
        .input-group {
            position: relative;
            display: flex;
            align-items: center;
        }
        
        .password-input {
            border-right: none;
            border-radius: 10px 0 0 10px !important;
        }
        
        .toggle-password {
            background: white;
            border: 2px solid #e9ecef;
            border-left: none;
            border-radius: 0 10px 10px 0;
            padding: 12px 15px;
            cursor: pointer;
            color: #6c757d;
            transition: all 0.3s;
        }
        
        .toggle-password:hover {
            color: var(--primary-color);
            background: #f8f9fa;
        }
        
        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s;
            position: relative;
        }
        
        .btn-login:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }
        
        .btn-login:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }
        
        .alert {
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
            margin-right: 8px;
            vertical-align: middle;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.9);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            backdrop-filter: blur(3px);
        }
        
        .loading-spinner {
            text-align: center;
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
        }
        
        .loading-spinner i {
            font-size: 48px;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .loading-spinner p {
            color: #6c757d;
            margin-bottom: 0;
            font-size: 16px;
        }
    </style>
</head>
<body>
    <div id="loadingOverlay" class="loading-overlay">
        <div class="loading-spinner">
            <i class="fas fa-circle-notch fa-spin"></i>
            <h5 class="mt-3">Sending OTP...</h5>
            <p class="text-muted">Please wait while we send a verification code to your email</p>
        </div>
    </div>
    
    <div class="login-card">
        <div class="login-header">
            <i class="fas fa-shield-alt fa-4x mb-3"></i>
            <h2 class="mb-2">Welcome Back!</h2>
            <p class="mb-0">Secure File Sharing System</p>
        </div>
        
        <div class="login-body">
            <div id="alertContainer">
                <c:if test="${param.logout == 'success'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        You have been successfully logged out!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error == 'invalid'}">
                    <div class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-circle me-2"></i>
                        Invalid username or password!
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.error == 'logout_failed'}">
                    <div class="alert alert-warning alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Logout encountered an issue, but you have been signed out.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                
                <c:if test="${param.registered == 'success'}">
                    <div class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle me-2"></i>
                        Registration successful! Please login.
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="fas fa-check-circle me-2"></i>
                    ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <form id="loginForm" action="<%= request.getContextPath() %>/auth" method="post">
                <input type="hidden" name="action" value="login">
                
                <div class="mb-3">
                    <label class="form-label fw-bold">Username</label>
                    <input type="text" class="form-control" name="username" id="username" 
                           placeholder="Enter your username" value="${param.username}" required>
                </div>
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Password</label>
                    <div class="input-group">
                        <input type="password" class="form-control password-input" 
                               name="password" id="password" 
                               placeholder="Enter your password" required>
                        <span class="toggle-password" onclick="togglePassword()">
                            <i class="fas fa-eye" id="toggleIcon"></i>
                        </span>
                    </div>
                </div>
                
                <button type="submit" class="btn-login" id="loginBtn">
                    <i class="fas fa-sign-in-alt me-2"></i>Login
                </button>
            </form>
            
            <div class="text-center mt-4">
                <p class="text-muted mb-0">
                    Don't have an account? 
                    <a href="<%= request.getContextPath() %>/jsp/auth/register.jsp" class="text-decoration-none fw-bold" style="color: var(--primary-color);">
                        Register
                    </a>
                </p>
                <p class="text-muted mt-2 mb-0 small">
                    <a href="<%= request.getContextPath() %>/jsp/auth/forgot-password.jsp" class="text-decoration-none" style="color: #6c757d;">
                        <i class="fas fa-key me-1"></i>Forgot Password?
                    </a>
                </p>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        var contextPath = '<%= request.getContextPath() %>';
        
        function togglePassword() {
            var passwordInput = document.getElementById('password');
            var toggleIcon = document.getElementById('toggleIcon');
            
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }
        
        function showLoading() {
            document.getElementById('loadingOverlay').style.display = 'flex';
        }
        
        function hideLoading() {
            document.getElementById('loadingOverlay').style.display = 'none';
        }
        
        document.getElementById('loginForm').addEventListener('submit', function(e) {
            var username = document.getElementById('username').value.trim();
            var password = document.getElementById('password').value.trim();
            
            if (!username || !password) {
                e.preventDefault();
                showAlert('Please enter both username and password', 'danger');
                return;
            }
            
            showLoading();
            
            var loginBtn = document.getElementById('loginBtn');
            loginBtn.disabled = true;
            loginBtn.innerHTML = '<span class="spinner"></span>Verifying...';
            
            return true;
        });
        
        function showAlert(message, type) {
            var alertContainer = document.getElementById('alertContainer');
            var icon = type === 'success' ? 'check-circle' : 'exclamation-circle';
            
            var alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-' + type + ' alert-dismissible fade show';
            alertDiv.setAttribute('role', 'alert');
            alertDiv.innerHTML = '<i class="fas fa-' + icon + ' me-2"></i>' + message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
            
            alertContainer.insertBefore(alertDiv, alertContainer.firstChild);
            
            setTimeout(function() {
                if (alertDiv) {
                    alertDiv.classList.remove('show');
                    setTimeout(function() { 
                        if (alertDiv.parentNode) alertDiv.remove(); 
                    }, 300);
                }
            }, 5000);
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            hideLoading();
            
            setTimeout(function() {
                var alerts = document.querySelectorAll('.alert');
                for (var i = 0; i < alerts.length; i++) {
                    alerts[i].classList.remove('show');
                    setTimeout(function(alert) {
                        if (alert.parentNode) alert.remove();
                    }, 300, alerts[i]);
                }
            }, 5000);
        });
        
        window.addEventListener('pageshow', function(event) {
            if (event.persisted) {
                hideLoading();
                var loginBtn = document.getElementById('loginBtn');
                loginBtn.disabled = false;
                loginBtn.innerHTML = '<i class="fas fa-sign-in-alt me-2"></i>Login';
            }
        });
    </script>
</body>
</html>