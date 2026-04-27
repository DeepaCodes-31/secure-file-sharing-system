<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - Secure File Sharing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #28a745;
            --danger-color: #dc3545;
            --warning-color: #ffc107;
            --admin-color: #dc3545;
            --user-color: #28a745;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding: 40px 20px;
        }
        
        .register-container {
            max-width: 650px;
            margin: 0 auto;
        }
        
        .register-card {
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
        
        .register-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .register-body {
            padding: 30px;
        }
        
        .form-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
        }
        
        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 12px 15px;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
            outline: none;
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
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .toggle-password:hover {
            color: var(--primary-color);
            background: #f8f9fa;
        }
        
        .btn-register {
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
        
        .btn-register:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }
        
        .btn-register:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }
        
        .role-section {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin: 20px 0;
            border: 2px solid #e9ecef;
        }
        
        .role-title {
            font-weight: 600;
            color: #495057;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
        }
        
        .role-title i {
            font-size: 20px;
            margin-right: 10px;
            color: var(--primary-color);
        }
        
        .role-option {
            background: white;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 15px;
            cursor: pointer;
            transition: all 0.3s;
            height: 100%;
        }
        
        .role-option:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .role-option.selected {
            border-color: var(--primary-color);
            background: #f0f5ff;
        }
        
        .role-option.admin.selected {
            border-color: var(--admin-color);
            background: #fff5f5;
        }
        
        .role-option.user.selected {
            border-color: var(--user-color);
            background: #f0fff4;
        }
        
        .role-icon {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 10px;
            font-size: 24px;
        }
        
        .role-icon.admin {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }
        
        .role-icon.user {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }
        
        .role-name {
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .role-name.admin {
            color: var(--admin-color);
        }
        
        .role-name.user {
            color: var(--user-color);
        }
        
        .role-desc {
            font-size: 12px;
            color: #6c757d;
        }
        
        .admin-warning {
            background: #fff3cd;
            border-left: 4px solid #ffc107;
            border-radius: 8px;
            padding: 15px;
            margin-top: 15px;
            font-size: 13px;
        }
        
        .admin-warning i {
            color: #856404;
        }
        
        .alert {
            border-radius: 10px;
            margin-bottom: 20px;
        }
        
        .password-strength {
            margin-top: 8px;
            height: 6px;
            border-radius: 3px;
            background: #e9ecef;
            overflow: hidden;
        }
        
        .strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s, background-color 0.3s;
        }
        
        .strength-text {
            font-size: 12px;
            margin-top: 5px;
            display: block;
            font-weight: 600;
        }
        
        .password-match-indicator {
            font-size: 12px;
            margin-top: 5px;
            display: flex;
            align-items: center;
        }
        
        .match-success {
            color: var(--success-color);
        }
        
        .match-error {
            color: var(--danger-color);
        }
        
        .login-link {
            margin-top: 20px;
            text-align: center;
        }
        
        .login-link a {
            color: var(--primary-color);
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .login-link a:hover {
            color: var(--secondary-color);
            text-decoration: underline;
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
        
        .requirement-list {
            list-style: none;
            padding-left: 0;
            margin-top: 10px;
            font-size: 12px;
        }
        
        .requirement-item {
            color: #6c757d;
            margin-bottom: 5px;
        }
        
        .requirement-item i {
            width: 16px;
            margin-right: 8px;
        }
        
        .requirement-met {
            color: var(--success-color);
        }
    </style>
</head>
<body>
    <div id="loadingOverlay" class="loading-overlay">
        <div class="loading-spinner">
            <i class="fas fa-circle-notch fa-spin"></i>
            <h5 class="mt-3">Creating Account...</h5>
            <p class="text-muted">Please wait while we process your registration</p>
        </div>
    </div>
    
    <div class="register-container">
        <div class="register-card">
            <div class="register-header">
                <i class="fas fa-user-plus fa-4x mb-3"></i>
                <h2 class="mb-2">Create Account</h2>
                <p class="mb-0">Join Secure File Sharing System</p>
            </div>
            
            <div class="register-body">
                <div id="alertContainer">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-circle me-2"></i> ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    
                    <c:if test="${not empty success}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i> ${success}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                </div>
                
                <form id="registerForm" action="<%= request.getContextPath() %>/auth" method="post">
                    <input type="hidden" name="action" value="register">
                    <input type="hidden" name="role" id="selectedRole" value="USER">

                    <div class="mb-3">
                        <label class="form-label">Username *</label>
                        <input type="text" class="form-control" name="username" id="username" 
                               placeholder="Choose a username (3-20 characters)" 
                               value="${param.username}" required>
                        <small class="text-muted">3-20 characters, letters and numbers only</small>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Email *</label>
                        <input type="email" class="form-control" name="email" id="email" 
                               placeholder="Enter your email address" 
                               value="${param.email}" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Password *</label>
                        <div class="input-group">
                            <input type="password" class="form-control password-input" 
                                   name="password" id="password" 
                                   placeholder="Create a strong password (min. 8 characters)" required>
                            <span class="toggle-password" onclick="togglePassword('password', 'toggleIcon1')">
                                <i class="fas fa-eye" id="toggleIcon1"></i>
                            </span>
                        </div>
                        <div id="passwordStrengthSection" style="display: none;">
                            <div class="password-strength">
                                <div id="strengthBar" class="strength-bar"></div>
                            </div>
                            <span id="strengthText" class="strength-text"></span>
                        </div>
                        
                        <div class="requirement-list">
                            <div id="reqLength" class="requirement-item">
                                <i class="fas fa-circle"></i> At least 8 characters
                            </div>
                            <div id="reqUppercase" class="requirement-item">
                                <i class="fas fa-circle"></i> At least 1 uppercase letter
                            </div>
                            <div id="reqLowercase" class="requirement-item">
                                <i class="fas fa-circle"></i> At least 1 lowercase letter
                            </div>
                            <div id="reqNumber" class="requirement-item">
                                <i class="fas fa-circle"></i> At least 1 number
                            </div>
                            <div id="reqSpecial" class="requirement-item">
                                <i class="fas fa-circle"></i> At least 1 special character
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Confirm Password *</label>
                        <div class="input-group">
                            <input type="password" class="form-control password-input" 
                                   name="confirmPassword" id="confirmPassword" 
                                   placeholder="Re-enter your password" required>
                            <span class="toggle-password" onclick="togglePassword('confirmPassword', 'toggleIcon2')">
                                <i class="fas fa-eye" id="toggleIcon2"></i>
                            </span>
                        </div>
                        <div id="passwordMatchIndicator" class="password-match-indicator"></div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">First Name</label>
                        <input type="text" class="form-control" name="firstName" id="firstName" 
                               placeholder="Your first name" value="${param.firstName}">
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Last Name</label>
                        <input type="text" class="form-control" name="lastName" id="lastName" 
                               placeholder="Your last name" value="${param.lastName}">
                    </div>

                    <div class="role-section">
                        <div class="role-title">
                            <i class="fas fa-user-tag"></i>
                            <span>Select Account Type</span>
                        </div>
                        
                        <div class="row g-3">
                            <div class="col-md-6">
                                <div class="role-option user" id="userRole" onclick="selectRole('USER')">
                                    <div class="role-icon user">
                                        <i class="fas fa-user"></i>
                                    </div>
                                    <div class="role-name user">USER</div>
                                    <div class="role-desc">Regular user with standard access</div>
                                    <ul class="list-unstyled mt-2 small text-start ps-3">
                                        <li><i class="fas fa-check-circle text-success me-1"></i> Upload files</li>
                                        <li><i class="fas fa-check-circle text-success me-1"></i> Share with others</li>
                                        <li><i class="fas fa-check-circle text-success me-1"></i> Access shared files</li>
                                    </ul>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="role-option admin" id="adminRole" onclick="selectRole('ADMIN')">
                                    <div class="role-icon admin">
                                        <i class="fas fa-crown"></i>
                                    </div>
                                    <div class="role-name admin">ADMIN</div>
                                    <div class="role-desc">Administrator with full system access</div>
                                    <ul class="list-unstyled mt-2 small text-start ps-3">
                                        <li><i class="fas fa-check-circle text-success me-1"></i> All user features</li>
                                        <li><i class="fas fa-check-circle text-success me-1"></i> Manage users</li>
                                        <li><i class="fas fa-check-circle text-success me-1"></i> System monitoring</li>
                                        <li><i class="fas fa-check-circle text-success me-1"></i> View audit logs</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        
                        <div id="adminWarning" class="admin-warning" style="display: none;">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <strong>Warning:</strong> Admin accounts have full system access including user management and file monitoring. Only select this if you need administrative privileges.
                        </div>
                    </div>

                    <div class="form-check mb-3">
                        <input class="form-check-input" type="checkbox" name="terms" id="terms" required>
                        <label class="form-check-label" for="terms">
                            I agree to <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">Terms & Conditions</a>
                        </label>
                    </div>

                    <button type="submit" class="btn-register" id="registerBtn">
                        <i class="fas fa-user-plus me-2"></i>Create Account
                    </button>
                </form>

                <div class="login-link">
                    <p class="text-muted mb-0">
                        Already have an account? 
                        <a href="<%= request.getContextPath() %>/jsp/auth/login.jsp">Login here</a>
                    </p>
                </div>
            </div>
        </div>
    </div>
    
    <div class="modal fade" id="termsModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Terms & Conditions</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <h6 class="fw-bold">Secure File Sharing System - Terms of Service</h6>
                    <p class="text-muted small">Last updated: February 2026</p>
                    
                    <h6 class="mt-4">1. Acceptance of Terms</h6>
                    <p class="small">By registering, you agree to be bound by these Terms & Conditions.</p>
                    
                    <h6 class="mt-3">2. User Responsibilities</h6>
                    <ul class="small">
                        <li>Use the service only for legal purposes</li>
                        <li>Keep your login credentials secure</li>
                        <li>Not share copyrighted material without permission</li>
                        <li>Not upload malicious files or content</li>
                    </ul>
                    
                    <h6 class="mt-3">3. Privacy Policy</h6>
                    <p class="small">We respect your privacy. Your files are encrypted and stored securely. We do not share your personal information with third parties without your consent.</p>
                    
                    <h6 class="mt-3">4. Account Termination</h6>
                    <p class="small">We reserve the right to suspend or terminate accounts that violate these terms or engage in illegal activities.</p>
                    
                    <hr>
                    <p class="small text-muted mb-0">By clicking "Create Account", you acknowledge that you have read and understood these terms.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal" onclick="document.getElementById('terms').checked = true;">
                        <i class="fas fa-check me-1"></i>Accept
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        var contextPath = '<%= request.getContextPath() %>';
        
        function selectRole(role) {
            document.getElementById('selectedRole').value = role;
            
            var userRole = document.getElementById('userRole');
            var adminRole = document.getElementById('adminRole');
            var adminWarning = document.getElementById('adminWarning');
            
            if (role === 'USER') {
                userRole.classList.add('selected');
                adminRole.classList.remove('selected');
                adminWarning.style.display = 'none';
            } else {
                adminRole.classList.add('selected');
                userRole.classList.remove('selected');
                adminWarning.style.display = 'block';
            }
        }
        
        selectRole('USER');
        
        function togglePassword(inputId, iconId) {
            var passwordInput = document.getElementById(inputId);
            var toggleIcon = document.getElementById(iconId);
            
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
        
        function checkPasswordStrength(password) {
            var strengthSection = document.getElementById('passwordStrengthSection');
            
            if (password.length > 0) {
                strengthSection.style.display = 'block';
            } else {
                strengthSection.style.display = 'none';
                return;
            }
            
            var hasLength = password.length >= 8;
            var hasUppercase = /[A-Z]/.test(password);
            var hasLowercase = /[a-z]/.test(password);
            var hasNumber = /[0-9]/.test(password);
            var hasSpecial = /[^a-zA-Z0-9]/.test(password);
            
            updateRequirement('reqLength', hasLength);
            updateRequirement('reqUppercase', hasUppercase);
            updateRequirement('reqLowercase', hasLowercase);
            updateRequirement('reqNumber', hasNumber);
            updateRequirement('reqSpecial', hasSpecial);
            
            var strength = 0;
            if (hasLength) strength += 20;
            if (hasUppercase) strength += 20;
            if (hasLowercase) strength += 20;
            if (hasNumber) strength += 20;
            if (hasSpecial) strength += 20;
            
            if (password.length >= 12) strength += 10;
            if (password.length >= 16) strength += 10;
            
            strength = Math.min(strength, 100);
            
            var strengthBar = document.getElementById('strengthBar');
            var strengthText = document.getElementById('strengthText');
            
            strengthBar.style.width = strength + '%';
            
            if (strength < 20) {
                strengthBar.style.backgroundColor = '#dc3545';
                strengthText.textContent = 'Very Weak';
                strengthText.style.color = '#dc3545';
            } else if (strength < 40) {
                strengthBar.style.backgroundColor = '#ffc107';
                strengthText.textContent = 'Weak';
                strengthText.style.color = '#ffc107';
            } else if (strength < 60) {
                strengthBar.style.backgroundColor = '#17a2b8';
                strengthText.textContent = 'Fair';
                strengthText.style.color = '#17a2b8';
            } else if (strength < 80) {
                strengthBar.style.backgroundColor = '#28a745';
                strengthText.textContent = 'Good';
                strengthText.style.color = '#28a745';
            } else {
                strengthBar.style.backgroundColor = '#28a745';
                strengthText.textContent = 'Strong';
                strengthText.style.color = '#28a745';
            }
        }
        
        function updateRequirement(elementId, isMet) {
            var element = document.getElementById(elementId);
            if (element) {
                var icon = element.querySelector('i');
                if (isMet) {
                    icon.className = 'fas fa-check-circle';
                    element.classList.add('requirement-met');
                } else {
                    icon.className = 'fas fa-circle';
                    element.classList.remove('requirement-met');
                }
            }
        }
        
        function checkPasswordMatch() {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            var indicator = document.getElementById('passwordMatchIndicator');
            
            if (confirmPassword.length > 0) {
                if (password === confirmPassword) {
                    indicator.innerHTML = '<i class="fas fa-check-circle me-1"></i>Passwords match';
                    indicator.className = 'password-match-indicator match-success';
                } else {
                    indicator.innerHTML = '<i class="fas fa-exclamation-circle me-1"></i>Passwords do not match';
                    indicator.className = 'password-match-indicator match-error';
                }
            } else {
                indicator.innerHTML = '';
            }
        }
        
        function showAlert(message, type) {
            var alertContainer = document.getElementById('alertContainer');
            var icon = type === 'success' ? 'check-circle' : 'exclamation-circle';
            
            var alertDiv = document.createElement('div');
            alertDiv.className = 'alert alert-' + type + ' alert-dismissible fade show';
            alertDiv.setAttribute('role', 'alert');
            alertDiv.innerHTML = '<i class="fas fa-' + icon + ' me-2"></i>' + message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>';
            
            alertContainer.appendChild(alertDiv);
            
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
            
            var passwordInput = document.getElementById('password');
            if (passwordInput) {
                passwordInput.addEventListener('input', function() {
                    checkPasswordStrength(this.value);
                    checkPasswordMatch();
                });
            }
            
            var confirmInput = document.getElementById('confirmPassword');
            if (confirmInput) {
                confirmInput.addEventListener('input', checkPasswordMatch);
            }
            
            var usernameInput = document.getElementById('username');
            if (usernameInput) {
                usernameInput.addEventListener('input', function() {
                    var username = this.value;
                    var pattern = /^[a-zA-Z0-9]{3,20}$/;
                    if (username.length > 0) {
                        if (pattern.test(username)) {
                            this.style.borderColor = '#28a745';
                        } else {
                            this.style.borderColor = '#dc3545';
                        }
                    } else {
                        this.style.borderColor = '';
                    }
                });
            }
            
            var emailInput = document.getElementById('email');
            if (emailInput) {
                emailInput.addEventListener('input', function() {
                    var email = this.value;
                    var pattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (email.length > 0) {
                        if (pattern.test(email)) {
                            this.style.borderColor = '#28a745';
                        } else {
                            this.style.borderColor = '#dc3545';
                        }
                    } else {
                        this.style.borderColor = '';
                    }
                });
            }
        });
        
        document.getElementById('registerForm').addEventListener('submit', function(e) {
            var password = document.getElementById('password').value;
            var confirmPassword = document.getElementById('confirmPassword').value;
            var username = document.getElementById('username').value;
            var email = document.getElementById('email').value;
            var terms = document.getElementById('terms').checked;
            var role = document.getElementById('selectedRole').value;
            
            var submitBtn = document.getElementById('registerBtn');
            
            var usernamePattern = /^[a-zA-Z0-9]{3,20}$/;
            if (!usernamePattern.test(username)) {
                e.preventDefault();
                showAlert('Username must be 3-20 characters and contain only letters and numbers', 'danger');
                return false;
            }
            
            var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailPattern.test(email)) {
                e.preventDefault();
                showAlert('Please enter a valid email address', 'danger');
                return false;
            }
            
            if (password.length < 8) {
                e.preventDefault();
                showAlert('Password must be at least 8 characters long!', 'danger');
                return false;
            }
            
            if (password !== confirmPassword) {
                e.preventDefault();
                showAlert('Passwords do not match!', 'danger');
                return false;
            }
            
            var hasUppercase = /[A-Z]/.test(password);
            var hasLowercase = /[a-z]/.test(password);
            var hasNumber = /[0-9]/.test(password);
            var hasSpecial = /[^a-zA-Z0-9]/.test(password);
            
            if (!hasUppercase || !hasLowercase || !hasNumber || !hasSpecial) {
                e.preventDefault();
                showAlert('Password must contain at least one uppercase letter, one lowercase letter, one number, and one special character', 'danger');
                return false;
            }
            
            if (!terms) {
                e.preventDefault();
                showAlert('You must accept the Terms & Conditions!', 'danger');
                return false;
            }
            
            if (role === 'ADMIN') {
                if (!confirm('⚠️ ADMIN ACCOUNT WARNING ⚠️\n\nYou are creating an administrator account with full system access. This account can manage users, view all files, and access audit logs.\n\nAre you sure you want to create an admin account?')) {
                    e.preventDefault();
                    return false;
                }
            }
            
            showLoading();
            
            submitBtn.disabled = true;
            submitBtn.innerHTML = '<span class="spinner"></span>Creating Account...';
            
            return true;
        });
        
        window.addEventListener('pageshow', function(event) {
            if (event.persisted) {
                hideLoading();
                var registerBtn = document.getElementById('registerBtn');
                if (registerBtn) {
                    registerBtn.disabled = false;
                    registerBtn.innerHTML = '<i class="fas fa-user-plus me-2"></i>Create Account';
                }
            }
        });
    </script>
</body>
</html>