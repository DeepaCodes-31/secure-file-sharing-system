
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile Settings - Secure File Sharing</title>
    
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
            --warning-color: #ffc107;
            --info-color: #17a2b8;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        
        .profile-container {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .profile-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
            position: relative;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            background: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 20px;
            border: 4px solid rgba(255,255,255,0.3);
            font-size: 48px;
            color: var(--primary-color);
            position: relative;
        }
        
        .avatar-upload {
            position: absolute;
            bottom: 0;
            right: 0;
            background: var(--success-color);
            color: white;
            width: 36px;
            height: 36px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid white;
            transition: all 0.3s;
        }
        
        .avatar-upload:hover {
            transform: scale(1.1);
            background: #218838;
        }
        
        .profile-body {
            padding: 30px;
        }
        
        .nav-tabs {
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 25px;
        }
        
        .nav-tabs .nav-link {
            border: none;
            color: #6c757d;
            padding: 12px 20px;
            font-weight: 600;
            margin-right: 10px;
            border-radius: 10px 10px 0 0;
            transition: all 0.3s;
        }
        
        .nav-tabs .nav-link:hover {
            background: #f8f9fa;
            color: var(--primary-color);
        }
        
        .nav-tabs .nav-link.active {
            color: var(--primary-color);
            background: transparent;
            border-bottom: 3px solid var(--primary-color);
        }
        
        .form-label {
            font-weight: 600;
            color: #495057;
            font-size: 14px;
            margin-bottom: 5px;
        }
        
        .form-control, .form-select {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 10px 15px;
            transition: all 0.3s;
        }
        
        .form-control:focus, .form-select:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }
        
        .btn-save {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-save:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }
        
        .btn-cancel {
            background: white;
            border: 2px solid #dee2e6;
            color: #6c757d;
            padding: 12px 30px;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-cancel:hover {
            background: #f8f9fa;
            border-color: #adb5bd;
        }
        
        .password-strength {
            margin-top: 10px;
            height: 5px;
            border-radius: 3px;
            background: #e9ecef;
            overflow: hidden;
        }
        
        .strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s, background-color 0.3s;
        }
        
        .info-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 20px;
            border-left: 4px solid var(--info-color);
        }
        
        .activity-item {
            padding: 12px 0;
            border-bottom: 1px solid #e9ecef;
        }
        
        .activity-item:last-child {
            border-bottom: none;
        }
        
        .back-link {
            color: white;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .back-link:hover {
            color: rgba(255,255,255,0.8);
            text-decoration: underline;
        }
        
        .alert {
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 20px;
        }
    </style>
</head>
<body>
    <div class="profile-container">
        <div class="profile-card">
            <div class="profile-header">
                <div class="profile-avatar">
                    <i class="fas fa-user-shield"></i>
                    <div class="avatar-upload" onclick="document.getElementById('avatarInput').click()">
                        <i class="fas fa-camera"></i>
                    </div>
                    <input type="file" id="avatarInput" accept="image/*" style="display: none;" onchange="uploadAvatar()">
                </div>
                <h2 class="mb-1">${profileUser.fullName != null ? profileUser.fullName : profileUser.username}</h2>
                <p class="mb-0 opacity-75">
                    <i class="fas fa-envelope me-2"></i>${profileUser.email}
                </p>
                <p class="mb-0 mt-2">
                    <span class="badge bg-success">
                        <i class="fas fa-shield-alt me-1"></i>${profileUser.role}
                    </span>
                    <span class="badge bg-info ms-2">
                        <i class="fas fa-calendar me-1"></i>Member since <fmt:formatDate value="${profileUser.createdAt}" pattern="MMM yyyy"/>
                    </span>
                </p>
            </div>
            
            <div class="profile-body">
                <!-- Alert Container -->
                <div id="alertContainer"></div>
                
                <!-- Tabs -->
                <ul class="nav nav-tabs" id="profileTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="profile-tab" data-bs-toggle="tab" data-bs-target="#profile" type="button" role="tab">
                            <i class="fas fa-user me-2"></i>Profile Information
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="security-tab" data-bs-toggle="tab" data-bs-target="#security" type="button" role="tab">
                            <i class="fas fa-lock me-2"></i>Security
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="settings-tab" data-bs-toggle="tab" data-bs-target="#settings" type="button" role="tab">
                            <i class="fas fa-cog me-2"></i>Preferences
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="activity-tab" data-bs-toggle="tab" data-bs-target="#activity" type="button" role="tab">
                            <i class="fas fa-history me-2"></i>Activity Log
                        </button>
                    </li>
                </ul>
                
                <!-- Tab Content -->
                <div class="tab-content">
                    <!-- Profile Information Tab -->
                    <div class="tab-pane fade show active" id="profile" role="tabpanel">
                        <form id="profileForm">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Username</label>
                                    <input type="text" class="form-control" value="${profileUser.username}" readonly disabled>
                                    <small class="text-muted">Username cannot be changed</small>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" class="form-control" id="fullName" name="fullName" 
                                           value="${profileUser.fullName}" placeholder="Enter your full name">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Email Address</label>
                                    <input type="email" class="form-control" id="email" name="email" 
                                           value="${profileUser.email}" placeholder="Enter your email">
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           value="${profileUser.phone}" placeholder="Enter your phone number">
                                </div>
                            </div>
                            <div class="text-end mt-3">
                                <button type="button" class="btn btn-cancel me-2" onclick="resetProfileForm()">
                                    <i class="fas fa-undo me-2"></i>Reset
                                </button>
                                <button type="submit" class="btn btn-save">
                                    <i class="fas fa-save me-2"></i>Save Changes
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Security Tab -->
                    <div class="tab-pane fade" id="security" role="tabpanel">
                        <form id="passwordForm">
                            <h6 class="mb-3 fw-bold">Change Password</h6>
                            <div class="mb-3">
                                <label class="form-label">Current Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('currentPassword', this)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label class="form-label">New Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('newPassword', this)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                                <!-- Password Strength Meter -->
                                <div id="passwordStrengthSection" style="display: none;">
                                    <div class="password-strength mt-2">
                                        <div id="strengthBar" class="strength-bar"></div>
                                    </div>
                                    <small id="strengthText" class="mt-1 d-block"></small>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="form-label">Confirm New Password</label>
                                <div class="input-group">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                    <button class="btn btn-outline-secondary" type="button" onclick="togglePassword('confirmPassword', this)">
                                        <i class="fas fa-eye"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <h6 class="mb-3 fw-bold mt-4">Two-Factor Authentication</h6>
                            <div class="info-card">
                                <div class="d-flex align-items-center">
                                    <i class="fas fa-shield-alt fa-2x text-info me-3"></i>
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">Two-Factor Authentication (2FA)</h6>
                                        <p class="text-muted small mb-0">
                                            Add an extra layer of security to your account. 
                                            This feature will be available soon.
                                        </p>
                                    </div>
                                    <span class="badge bg-secondary">Coming Soon</span>
                                </div>
                            </div>
                            
                            <div class="text-end mt-3">
                                <button type="submit" class="btn btn-save">
                                    <i class="fas fa-key me-2"></i>Update Password
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Preferences Tab -->
                    <div class="tab-pane fade" id="settings" role="tabpanel">
                        <form id="settingsForm">
                            <h6 class="mb-3 fw-bold">Notification Settings</h6>
                            <div class="mb-3">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="emailNotifications" 
                                           ${profileUser.emailNotifications ? 'checked' : ''}>
                                    <label class="form-check-label" for="emailNotifications">
                                        <strong>Email Notifications</strong>
                                        <p class="text-muted small mb-0">Receive email alerts for file uploads and downloads</p>
                                    </label>
                                </div>
                            </div>
                            
                            <h6 class="mb-3 fw-bold mt-4">Security Preferences</h6>
                            <div class="mb-3">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="autoEncrypt" 
                                           ${profileUser.autoEncrypt ? 'checked' : ''}>
                                    <label class="form-check-label" for="autoEncrypt">
                                        <strong>Auto-encrypt all files</strong>
                                        <p class="text-muted small mb-0">Automatically encrypt all uploaded files with AES-256</p>
                                    </label>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <div class="form-check form-switch">
                                    <input class="form-check-input" type="checkbox" id="twoFactorAuth" disabled>
                                    <label class="form-check-label" for="twoFactorAuth">
                                        <strong>Two-Factor Authentication</strong>
                                        <span class="badge bg-secondary ms-2">Coming Soon</span>
                                        <p class="text-muted small mb-0">Enable 2FA for enhanced account security</p>
                                    </label>
                                </div>
                            </div>
                            
                            <h6 class="mb-3 fw-bold mt-4">Display Preferences</h6>
                            <div class="mb-3">
                                <label class="form-label">Items per page</label>
                                <select class="form-select" id="itemsPerPage">
                                    <option value="10" ${profileUser.itemsPerPage == 10 ? 'selected' : ''}>10</option>
                                    <option value="25" ${profileUser.itemsPerPage == 25 ? 'selected' : ''}>25</option>
                                    <option value="50" ${profileUser.itemsPerPage == 50 ? 'selected' : ''}>50</option>
                                    <option value="100" ${profileUser.itemsPerPage == 100 ? 'selected' : ''}>100</option>
                                </select>
                            </div>
                            
                            <div class="text-end mt-3">
                                <button type="submit" class="btn btn-save">
                                    <i class="fas fa-save me-2"></i>Save Preferences
                                </button>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Activity Log Tab -->
                    <div class="tab-pane fade" id="activity" role="tabpanel">
                        <div class="info-card">
                            <div class="d-flex align-items-center">
                                <i class="fas fa-history fa-2x text-info me-3"></i>
                                <div>
                                    <h6 class="mb-1">Recent Account Activity</h6>
                                    <p class="text-muted small mb-0">
                                        Your recent login and security events. 
                                        <a href="${pageContext.request.contextPath}/recent" class="text-info">View full activity log</a>
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mt-3">
                            <!-- Placeholder for recent activity -->
                            <div class="activity-item d-flex align-items-center">
                                <div class="bg-success bg-opacity-10 p-2 rounded-circle me-3">
                                    <i class="fas fa-sign-in-alt text-success"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <p class="mb-0 fw-bold">Login successful</p>
                                    <small class="text-muted">
                                        <fmt:formatDate value="<%= new java.util.Date() %>" pattern="MMM dd, yyyy HH:mm:ss"/>
                                    </small>
                                </div>
                                <span class="badge bg-light text-dark">Current Session</span>
                            </div>
                            
                            <div class="text-center mt-4">
                                <a href="${pageContext.request.contextPath}/recent" class="btn btn-outline-primary">
                                    <i class="fas fa-history me-2"></i>View All Activity
                                </a>
                            </div>
                        </div>
                        
                        <!-- Account Actions -->
                        <h6 class="mb-3 fw-bold mt-4">Account Actions</h6>
                        <div class="d-grid gap-2">
                            <button class="btn btn-outline-danger text-start" onclick="deactivateAccount()">
                                <i class="fas fa-ban me-2"></i>
                                <strong>Deactivate Account</strong>
                                <p class="small mb-0 text-muted">Temporarily disable your account</p>
                            </button>
                            <button class="btn btn-outline-danger text-start" onclick="deleteAccount()">
                                <i class="fas fa-trash-alt me-2"></i>
                                <strong>Delete Account</strong>
                                <p class="small mb-0 text-muted">Permanently delete your account and all data</p>
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="mt-4 text-center">
            <a href="${pageContext.request.contextPath}/dashboard" class="back-link">
                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
            </a>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        const contextPath = '${pageContext.request.contextPath}';
        
        $(document).ready(function() {
            // Profile Form Submit
            $('#profileForm').on('submit', function(e) {
                e.preventDefault();
                updateProfile();
            });
            
            // Password Form Submit
            $('#passwordForm').on('submit', function(e) {
                e.preventDefault();
                changePassword();
            });
            
            // Settings Form Submit
            $('#settingsForm').on('submit', function(e) {
                e.preventDefault();
                updateSettings();
            });
            
            // Password Strength Checker
            $('#newPassword').on('input', function() {
                checkPasswordStrength($(this).val());
            });
        });
        
        function updateProfile() {
            $.ajax({
                url: contextPath + '/profile',
                type: 'POST',
                data: {
                    action: 'updateProfile',
                    fullName: $('#fullName').val(),
                    email: $('#email').val(),
                    phone: $('#phone').val()
                },
                success: function(response) {
                    if (response.success) {
                        showAlert('success', response.message);
                    } else {
                        showAlert('danger', response.message);
                    }
                },
                error: function(xhr) {
                    showAlert('danger', 'Failed to update profile');
                }
            });
        }
        
        function changePassword() {
            var newPassword = $('#newPassword').val();
            var confirmPassword = $('#confirmPassword').val();
            
            if (newPassword !== confirmPassword) {
                showAlert('danger', 'New passwords do not match');
                return;
            }
            
            $.ajax({
                url: contextPath + '/profile',
                type: 'POST',
                data: {
                    action: 'changePassword',
                    currentPassword: $('#currentPassword').val(),
                    newPassword: newPassword,
                    confirmPassword: confirmPassword
                },
                success: function(response) {
                    if (response.success) {
                        showAlert('success', response.message);
                        $('#passwordForm')[0].reset();
                        $('#passwordStrengthSection').hide();
                    } else {
                        showAlert('danger', response.message);
                    }
                },
                error: function(xhr) {
                    showAlert('danger', 'Failed to change password');
                }
            });
        }
        
        function updateSettings() {
            $.ajax({
                url: contextPath + '/profile',
                type: 'POST',
                data: {
                    action: 'updateSettings',
                    emailNotifications: $('#emailNotifications').is(':checked'),
                    autoEncrypt: $('#autoEncrypt').is(':checked'),
                    twoFactorAuth: $('#twoFactorAuth').is(':checked'),
                    itemsPerPage: $('#itemsPerPage').val()
                },
                success: function(response) {
                    if (response.success) {
                        showAlert('success', response.message);
                    } else {
                        showAlert('danger', response.message);
                    }
                },
                error: function(xhr) {
                    showAlert('danger', 'Failed to update settings');
                }
            });
        }
        
        function checkPasswordStrength(password) {
            if (password.length > 0) {
                $('#passwordStrengthSection').show();
            } else {
                $('#passwordStrengthSection').hide();
                return;
            }
            
            let strength = 0;
            
            // Length check
            if (password.length >= 8) strength += 25;
            if (password.length >= 12) strength += 25;
            
            // Complexity checks
            if (/[a-z]/.test(password)) strength += 12.5;
            if (/[A-Z]/.test(password)) strength += 12.5;
            if (/[0-9]/.test(password)) strength += 12.5;
            if (/[^a-zA-Z0-9]/.test(password)) strength += 12.5;
            
            strength = Math.min(strength, 100);
            
            $('#strengthBar').css('width', strength + '%');
            
            if (strength < 25) {
                $('#strengthBar').css('background-color', '#dc3545');
                $('#strengthText').text('Very Weak').css('color', '#dc3545');
            } else if (strength < 50) {
                $('#strengthBar').css('background-color', '#ffc107');
                $('#strengthText').text('Weak').css('color', '#ffc107');
            } else if (strength < 75) {
                $('#strengthBar').css('background-color', '#17a2b8');
                $('#strengthText').text('Good').css('color', '#17a2b8');
            } else {
                $('#strengthBar').css('background-color', '#28a745');
                $('#strengthText').text('Strong').css('color', '#28a745');
            }
        }
        
        function togglePassword(inputId, button) {
            var input = $('#' + inputId);
            var icon = $(button).find('i');
            
            if (input.attr('type') === 'password') {
                input.attr('type', 'text');
                icon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                input.attr('type', 'password');
                icon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        }
        
        function resetProfileForm() {
            $('#fullName').val('${profileUser.fullName}');
            $('#email').val('${profileUser.email}');
            $('#phone').val('${profileUser.phone}');
            showAlert('info', 'Form reset to original values');
        }
        
        function uploadAvatar() {
            var file = $('#avatarInput')[0].files[0];
            if (file) {
                // TODO: Implement avatar upload
                showAlert('info', 'Avatar upload coming soon!');
            }
        }
        
        function deactivateAccount() {
            if (confirm('Are you sure you want to deactivate your account? You can reactivate it later by logging in.')) {
                showAlert('info', 'Account deactivation coming soon!');
            }
        }
        
        function deleteAccount() {
            if (confirm('WARNING: This will permanently delete your account and all files. This action cannot be undone. Are you absolutely sure?')) {
                showAlert('info', 'Account deletion coming soon!');
            }
        }
        
        function showAlert(type, message) {
            var alertClass = 'alert-' + type;
            var icon = type === 'success' ? 'fa-check-circle' : 
                      (type === 'danger' ? 'fa-exclamation-circle' : 'fa-info-circle');
            
            var alertHtml = '<div class="alert ' + alertClass + ' alert-dismissible fade show" role="alert">' +
                '<i class="fas ' + icon + ' me-2"></i>' + message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
                '</div>';
            
            $('#alertContainer').html(alertHtml);
            
            setTimeout(function() {
                $('.alert').alert('close');
            }, 5000);
        }
    </script>
</body>
</html>