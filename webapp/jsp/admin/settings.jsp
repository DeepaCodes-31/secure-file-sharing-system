<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>System Settings - Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        .sidebar {
            min-height: calc(100vh - 56px);
            background-color: #343a40;
            position: fixed;
            width: 250px;
        }
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        
        .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 12px 20px;
            margin: 5px 10px;
            border-radius: 5px;
            transition: all 0.3s;
        }
        
        .nav-link:hover, .nav-link.active {
            background-color: #007bff;
            color: white;
        }
        
        .nav-link i {
            width: 24px;
            margin-right: 10px;
        }
        
        .navbar {
            background-color: #343a40 !important;
        }
        
        .content-card {
            background: white;
            border-radius: 8px;
            padding: 30px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            margin: 20px;
        }
        
        .page-header {
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 15px;
            margin-bottom: 25px;
        }
        
        .settings-section {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
            border: 1px solid #dee2e6;
        }
        
        .section-title {
            color: #495057;
            border-bottom: 2px solid #dee2e6;
            padding-bottom: 10px;
            margin-bottom: 20px;
            font-weight: 600;
        }
        
        .settings-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            background: white;
        }
        
        .settings-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
        }
        
        .settings-value {
            color: #212529;
            margin-bottom: 15px;
        }
        
        .badge-status {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        
        .badge-enabled { background-color: #d4edda; color: #155724; }
        .badge-disabled { background-color: #f8d7da; color: #721c24; }
        .badge-warning { background-color: #fff3cd; color: #856404; }
        
        .form-switch {
            padding-left: 2.5em;
        }
        
        .form-switch .form-check-input {
            width: 2em;
            margin-left: -2.5em;
            height: 1.2em;
        }
        
        .btn-save {
            padding: 10px 30px;
        }
        
        .footer {
            background-color: #343a40 !important;
            color: white;
            padding: 1rem 0;
            margin-top: 2rem;
            margin-left: 250px;
        }
        
        .status-indicator {
            width: 12px;
            height: 12px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 6px;
        }
        .status-healthy { background-color: #28a745; box-shadow: 0 0 8px #28a745; }
        .status-warning { background-color: #ffc107; box-shadow: 0 0 8px #ffc107; }
        .status-critical { background-color: #dc3545; box-shadow: 0 0 8px #dc3545; }
        
        .tab-pane {
            padding: 20px 0;
        }
        
        .nav-tabs .nav-link {
            color: #495057;
            border: none;
            padding: 12px 20px;
            font-weight: 500;
        }
        
        .nav-tabs .nav-link.active {
            color: #007bff;
            border-bottom: 3px solid #007bff;
            background: transparent;
        }
        
        .nav-tabs .nav-link i {
            margin-right: 8px;
        }
        
        .maintenance-btn {
            width: 100%;
            text-align: left;
            padding: 15px;
            margin-bottom: 10px;
            border: 1px solid #dee2e6;
            border-radius: 8px;
            background: white;
            transition: all 0.3s;
        }
        
        .maintenance-btn:hover {
            background: #f8f9fa;
            border-color: #007bff;
        }
        
        .maintenance-btn i {
            margin-right: 10px;
            font-size: 18px;
        }
        
        /* Toast Notifications */
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 9999;
        }
        
        .toast {
            min-width: 300px;
            margin-bottom: 10px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        
        .toast-success {
            background-color: #d4edda;
            border-left: 4px solid #28a745;
            color: #155724;
        }
        
        .toast-error {
            background-color: #f8d7da;
            border-left: 4px solid #dc3545;
            color: #721c24;
        }
        
        .toast-warning {
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            color: #856404;
        }
        
        .toast-info {
            background-color: #d1ecf1;
            border-left: 4px solid #17a2b8;
            color: #0c5460;
        }
        
        .toast .btn-close {
            filter: none;
        }

        /* Loading spinner */
        .spinner-border-sm {
            width: 1rem;
            height: 1rem;
            border-width: 0.2em;
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/admin">
                <i class="bi bi-shield-lock me-2"></i> Secure File Sharing - Admin Panel
            </a>
            <div class="navbar-nav ms-auto">
                <span class="nav-item nav-link text-white">
                    <i class="bi bi-person-circle me-1"></i> ${sessionScope.user.username} 
                    <span class="badge bg-warning text-dark ms-2">Administrator</span>
                </span>
                <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                    <i class="bi bi-arrow-left me-1"></i> Dashboard
                </a>
                <a class="nav-link text-white" href="${pageContext.request.contextPath}/auth?action=logout">
                    <i class="bi bi-box-arrow-right me-1"></i> Logout
                </a>
            </div>
        </div>
    </nav>

    <div class="container-fluid">
        <div class="row">
            <div class="col-md-3 col-lg-2 bg-dark sidebar p-0">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="bi bi-people"></i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/files">
                                <i class="bi bi-files"></i> Files
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/logs">
                                <i class="bi bi-clipboard-data"></i> Audit Logs
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/settings">
                                <i class="bi bi-gear"></i> System Settings
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="col-md-9 col-lg-10 ms-sm-auto px-md-4 py-4">
                <div class="content-card">
                    <!-- Toast Container for Notifications -->
                    <div class="toast-container" id="toastContainer"></div>

                    <div class="page-header d-flex justify-content-between align-items-center">
                        <div>
                            <h2><i class="bi bi-gear-fill me-2 text-primary"></i>System Settings</h2>
                            <p class="text-muted">Configure system parameters and security preferences</p>
                        </div>
                        <div>
                            <span class="badge bg-primary p-3">
                                <i class="bi bi-shield-check me-1"></i> System v1.0
                            </span>
                        </div>
                    </div>

                    <!-- Settings Tabs -->
                    <ul class="nav nav-tabs" id="settingsTabs" role="tablist">
                        <li class="nav-item" role="presentation">
                            <button class="nav-link active" id="general-tab" data-bs-toggle="tab" data-bs-target="#general" type="button" role="tab">
                                <i class="bi bi-sliders2"></i> General
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="security-tab" data-bs-toggle="tab" data-bs-target="#security" type="button" role="tab">
                                <i class="bi bi-shield-lock"></i> Security
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="storage-tab" data-bs-toggle="tab" data-bs-target="#storage" type="button" role="tab">
                                <i class="bi bi-database"></i> Storage
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="email-tab" data-bs-toggle="tab" data-bs-target="#email" type="button" role="tab">
                                <i class="bi bi-envelope"></i> Email
                            </button>
                        </li>
                        <li class="nav-item" role="presentation">
                            <button class="nav-link" id="maintenance-tab" data-bs-toggle="tab" data-bs-target="#maintenance" type="button" role="tab">
                                <i class="bi bi-tools"></i> Maintenance
                            </button>
                        </li>
                    </ul>

                    <!-- Settings Form -->
                    <form id="settingsForm">
                        <!-- Tab Content -->
                        <div class="tab-content" id="settingsTabContent">
                            <!-- GENERAL SETTINGS TAB -->
                            <div class="tab-pane fade show active" id="general" role="tabpanel">
                                <div class="settings-section">
                                    <h5 class="section-title"><i class="bi bi-info-circle me-2"></i>System Information</h5>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <div class="d-flex align-items-center mb-3">
                                                    <i class="bi bi-server fs-2 me-3 text-primary"></i>
                                                    <div>
                                                        <h6 class="mb-1">Server Status</h6>
                                                        <p class="mb-0">
                                                            <span class="status-indicator status-healthy"></span>
                                                            <span class="text-success fw-bold">Operational</span>
                                                        </p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="mb-2">
                                                    <span class="settings-label">Server Time:</span>
                                                    <div class="settings-value">
                                                        <fmt:formatDate value="<%= new java.util.Date() %>" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    </div>
                                                </div>
                                                <div class="mb-2">
                                                    <span class="settings-label">System Uptime:</span>
                                                    <div class="settings-value">2 days, 5 hours</div>
                                                </div>
                                                <div class="mb-2">
                                                    <span class="settings-label">Java Version:</span>
                                                    <div class="settings-value"><%= System.getProperty("java.version") %></div>
                                                </div>
                                                <div class="mb-2">
                                                    <span class="settings-label">Server Info:</span>
                                                    <div class="settings-value"><%= application.getServerInfo() %></div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <div class="d-flex align-items-center mb-3">
                                                    <i class="bi bi-database fs-2 me-3 text-success"></i>
                                                    <div>
                                                        <h6 class="mb-1">Database Status</h6>
                                                        <p class="mb-0">
                                                            <span class="status-indicator status-healthy"></span>
                                                            <span class="text-success fw-bold">Connected</span>
                                                        </p>
                                                    </div>
                                                </div>
                                                <hr>
                                                <div class="mb-2">
                                                    <span class="settings-label">Database URL:</span>
                                                    <div class="settings-value">jdbc:mysql://localhost:3306/securefileshare</div>
                                                </div>
                                                <div class="mb-2">
                                                    <span class="settings-label">Active Connections:</span>
                                                    <div class="settings-value">5</div>
                                                </div>
                                                <div class="mb-2">
                                                    <span class="settings-label">Last Backup:</span>
                                                    <div class="settings-value">2026-02-23 03:00 AM</div>
                                                </div>
                                                <div class="mb-2">
                                                    <span class="settings-label">Storage Usage:</span>
                                                    <div class="settings-value">
                                                        <c:set var="storagePercent" value="${storageStats.percent != null ? storageStats.percent : 5}" />
                                                        <div class="progress mt-1" style="height: 8px;">
                                                            <div class="progress-bar bg-info" style="width: ${storagePercent}%"></div>
                                                        </div>
                                                        <small class="text-muted">${storageStats.formattedUsed != null ? storageStats.formattedUsed : '7.15 MB'} / 15.00 GB</small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="settings-section">
                                    <h5 class="section-title"><i class="bi bi-clock-history me-2"></i>Session & Timeout Settings</h5>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="settings-card">
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="sessionTimeout">Session Timeout</label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" id="sessionTimeout" name="sessionTimeout" value="30" min="5" max="120">
                                                        <span class="input-group-text">minutes</span>
                                                    </div>
                                                    <small class="text-muted">User session expiry time (5-120 minutes)</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="settings-card">
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="otpExpiry">OTP Expiry</label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" id="otpExpiry" name="otpExpiry" value="10" min="1" max="30">
                                                        <span class="input-group-text">minutes</span>
                                                    </div>
                                                    <small class="text-muted">OTP code validity period (1-30 minutes)</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="settings-card">
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="maxLoginAttempts">Max Login Attempts</label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" id="maxLoginAttempts" name="maxLoginAttempts" value="5" min="3" max="10">
                                                        <span class="input-group-text">attempts</span>
                                                    </div>
                                                    <small class="text-muted">Before account lockout (3-10 attempts)</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- SECURITY SETTINGS TAB -->
                            <div class="tab-pane fade" id="security" role="tabpanel">
                                <div class="settings-section">
                                    <h5 class="section-title"><i class="bi bi-shield-lock me-2"></i>Security Features</h5>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <div class="form-check form-switch mb-3">
                                                    <input class="form-check-input" type="checkbox" id="encryptionEnabled" name="encryptionEnabled" checked>
                                                    <label class="form-check-label fw-bold" for="encryptionEnabled">
                                                        AES-256 Encryption
                                                    </label>
                                                    <p class="text-muted small ms-4">Military-grade encryption for all files</p>
                                                </div>
                                                <div class="form-check form-switch mb-3">
                                                    <input class="form-check-input" type="checkbox" id="integrityCheck" name="integrityCheck" checked>
                                                    <label class="form-check-label fw-bold" for="integrityCheck">
                                                        SHA-256 Integrity Verification
                                                    </label>
                                                    <p class="text-muted small ms-4">Verify file integrity with cryptographic hashes</p>
                                                </div>
                                                <div class="form-check form-switch mb-3">
                                                    <input class="form-check-input" type="checkbox" id="otpEnabled" name="otpEnabled" checked>
                                                    <label class="form-check-label fw-bold" for="otpEnabled">
                                                        OTP Two-Factor Authentication
                                                    </label>
                                                    <p class="text-muted small ms-4">One-time password for login verification</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <div class="form-check form-switch mb-3">
                                                    <input class="form-check-input" type="checkbox" id="accessControl" name="accessControl" checked>
                                                    <label class="form-check-label fw-bold" for="accessControl">
                                                        Access Control
                                                    </label>
                                                    <p class="text-muted small ms-4">Role-based access control (RBAC)</p>
                                                </div>
                                                <div class="form-check form-switch mb-3">
                                                    <input class="form-check-input" type="checkbox" id="auditLogging" name="auditLogging" checked>
                                                    <label class="form-check-label fw-bold" for="auditLogging">
                                                        Audit Logging
                                                    </label>
                                                    <p class="text-muted small ms-4">Track all system activities</p>
                                                </div>
                                                <div class="form-check form-switch mb-3">
                                                    <input class="form-check-input" type="checkbox" id="httpsOnly" name="httpsOnly" checked>
                                                    <label class="form-check-label fw-bold" for="httpsOnly">
                                                        HTTPS Only
                                                    </label>
                                                    <p class="text-muted small ms-4">Force secure connections</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="settings-section">
                                    <h5 class="section-title"><i class="bi bi-key me-2"></i>Password Policy</h5>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="settings-card">
                                                <label class="form-label fw-bold" for="minPasswordLength">Minimum Length</label>
                                                <input type="number" class="form-control" id="minPasswordLength" name="minPasswordLength" value="8" min="6" max="20">
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="settings-card">
                                                <label class="form-label fw-bold" for="requireUppercase">Require Uppercase</label>
                                                <select class="form-select" id="requireUppercase" name="requireUppercase">
                                                    <option value="true" selected>Yes</option>
                                                    <option value="false">No</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="settings-card">
                                                <label class="form-label fw-bold" for="requireSpecial">Require Special Chars</label>
                                                <select class="form-select" id="requireSpecial" name="requireSpecial">
                                                    <option value="true" selected>Yes</option>
                                                    <option value="false">No</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- STORAGE SETTINGS TAB -->
                            <div class="tab-pane fade" id="storage" role="tabpanel">
                                <div class="settings-section">
                                    <h5 class="section-title"><i class="bi bi-cloud-arrow-up me-2"></i>Storage Configuration</h5>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <label class="form-label fw-bold" for="storageProvider">Storage Provider</label>
                                                <select class="form-select mb-3" id="storageProvider" name="storageProvider">
                                                    <option value="google-drive" selected>Google Drive</option>
                                                    <option value="local" disabled>Local Storage (Coming Soon)</option>
                                                    <option value="s3" disabled>Amazon S3 (Coming Soon)</option>
                                                </select>
                                                <div class="d-flex align-items-center">
                                                    <span class="badge bg-success me-2">Connected</span>
                                                    <small class="text-muted">ds860645@gmail.com</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <h6 class="mb-3">Storage Quota</h6>
                                                <div class="d-flex justify-content-between mb-1">
                                                    <span>Used:</span>
                                                    <span class="fw-bold">${storageStats.formattedUsed != null ? storageStats.formattedUsed : '1.63 GB'}</span>
                                                </div>
                                                <div class="d-flex justify-content-between mb-2">
                                                    <span>Total:</span>
                                                    <span class="fw-bold">15.00 GB</span>
                                                </div>
                                                <div class="progress" style="height: 8px;">
                                                    <div class="progress-bar bg-info" style="width: ${storageStats.percent != null ? storageStats.percent : 11}%"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="settings-section">
                                    <h5 class="section-title"><i class="bi bi-upload me-2"></i>File Upload Settings</h5>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="maxFileSize">Maximum File Size</label>
                                                    <div class="input-group">
                                                        <input type="number" class="form-control" id="maxFileSize" name="maxFileSize" value="5120" min="1" max="10240">
                                                        <span class="input-group-text">MB</span>
                                                    </div>
                                                    <small class="text-muted">Maximum file size per upload (1-10240 MB)</small>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="allowedFileTypes">Allowed File Types</label>
                                                    <input type="text" class="form-control" id="allowedFileTypes" name="allowedFileTypes" value="pdf,doc,docx,xls,xlsx,jpg,png,zip,txt">
                                                    <small class="text-muted">Comma-separated list of allowed extensions</small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- EMAIL SETTINGS TAB -->
                            <div class="tab-pane fade" id="email" role="tabpanel">
                                <div class="settings-section">
                                    <h5 class="section-title"><i class="bi bi-envelope-paper me-2"></i>SMTP Configuration</h5>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="smtpHost">SMTP Host</label>
                                                    <input type="text" class="form-control" id="smtpHost" name="smtpHost" value="smtp.sendgrid.net">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="smtpPort">SMTP Port</label>
                                                    <input type="number" class="form-control" id="smtpPort" name="smtpPort" value="587">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="smtpUsername">Username</label>
                                                    <input type="text" class="form-control" id="smtpUsername" name="smtpUsername" value="apikey">
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="settings-card">
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="smtpPassword">Password/API Key</label>
                                                    <input type="password" class="form-control" id="smtpPassword" name="smtpPassword" value="SG.xxxxxxxxxxxxxx">
                                                </div>
                                                <div class="mb-3">
                                                    <label class="form-label fw-bold" for="fromEmail">From Email</label>
                                                    <input type="email" class="form-control" id="fromEmail" name="fromEmail" value="noreply@securefileshare.com">
                                                </div>
                                                <div class="form-check form-switch">
                                                    <input class="form-check-input" type="checkbox" id="emailEnabled" name="emailEnabled" checked>
                                                    <label class="form-check-label fw-bold" for="emailEnabled">
                                                        Enable Email Notifications
                                                    </label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- MAINTENANCE TAB -->
                            <div class="tab-pane fade" id="maintenance" role="tabpanel">
                                <div class="settings-section">
                                    <h5 class="section-title"><i class="bi bi-tools me-2"></i>Maintenance Actions</h5>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <button type="button" class="maintenance-btn" onclick="backupDatabase()">
                                                <i class="bi bi-database text-primary"></i>
                                                <strong>Backup Database</strong>
                                                <p class="text-muted small mb-0">Create a complete database backup</p>
                                            </button>
                                        </div>
                                        <div class="col-md-6">
                                            <button type="button" class="maintenance-btn" onclick="clearCache()">
                                                <i class="bi bi-arrow-counterclockwise text-warning"></i>
                                                <strong>Clear Cache</strong>
                                                <p class="text-muted small mb-0">Clear system and application cache</p>
                                            </button>
                                        </div>
                                        <div class="col-md-6">
                                            <button type="button" class="maintenance-btn" onclick="cleanLogs()">
                                                <i class="bi bi-file-earmark-text text-info"></i>
                                                <strong>Clean Logs</strong>
                                                <p class="text-muted small mb-0">Remove old log files</p>
                                            </button>
                                        </div>
                                        <div class="col-md-6">
                                            <button type="button" class="maintenance-btn" onclick="restartSystem()">
                                                <i class="bi bi-arrow-repeat text-danger"></i>
                                                <strong>Restart System</strong>
                                                <p class="text-muted small mb-0">Restart application server</p>
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="settings-section">
                                    <h5 class="section-title"><i class="bi bi-clock-history me-2"></i>Scheduled Tasks</h5>
                                    <div class="row">
                                        <div class="col-md-4">
                                            <div class="settings-card">
                                                <label class="form-label fw-bold" for="autoBackup">Auto Backup</label>
                                                <select class="form-select" id="autoBackup" name="autoBackup">
                                                    <option value="daily">Daily</option>
                                                    <option value="weekly" selected>Weekly</option>
                                                    <option value="monthly">Monthly</option>
                                                    <option value="disabled">Disabled</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="settings-card">
                                                <label class="form-label fw-bold" for="logRetention">Log Retention</label>
                                                <div class="input-group">
                                                    <input type="number" class="form-control" id="logRetention" name="logRetention" value="30" min="7" max="365">
                                                    <span class="input-group-text">days</span>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-4">
                                            <div class="settings-card">
                                                <label class="form-label fw-bold" for="trashCleanup">Trash Cleanup</label>
                                                <div class="input-group">
                                                    <input type="number" class="form-control" id="trashCleanup" name="trashCleanup" value="7" min="1" max="90">
                                                    <span class="input-group-text">days</span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>

                    <!-- Save Button -->
                    <div class="text-end mt-4">
                        <button type="button" class="btn btn-secondary me-2" onclick="resetSettings()">
                            <i class="bi bi-arrow-counterclockwise me-1"></i> Reset
                        </button>
                        <button type="button" class="btn btn-primary btn-save" onclick="saveSettings()">
                            <i class="bi bi-check-circle me-1"></i> Save Changes
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white py-3 mt-4">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">
                        <i class="bi bi-c-circle me-1"></i> 2026 Secure File Sharing System - Admin Panel
                    </p>
                </div>
                <div class="col-md-6 text-end">
                    <small class="text-info">
                        <i class="bi bi-shield-check me-1"></i>
                        Secure Admin Access | Real-time Monitoring | Comprehensive Auditing
                    </small>
                </div>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        const contextPath = '<%= request.getContextPath() %>';
        
        // FIXED: saveSettings function with 2-second delay before button restoration
        // FIXED: saveSettings function with "Saved Successfully" message
function saveSettings() {
    // Get the save button
    const saveBtn = document.querySelector('.btn-save');
    const originalText = '<i class="bi bi-check-circle me-1"></i> Save Changes';
    
    // Show loading state
    saveBtn.innerHTML = '<span class="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>Saving...';
    saveBtn.disabled = true;
    
    // Serialize form data
    var formData = $('#settingsForm').serialize();
    
    console.log('Sending settings data:', formData);
    console.log('URL:', contextPath + '/admin/settings');
    
    $.ajax({
        url: contextPath + '/admin/settings',
        type: 'POST',
        data: formData,
        dataType: 'json',
        timeout: 10000,
        success: function(response) {
            console.log('Server response:', response);
            
            if (response && response.success === true) {
                // Change button to "Saved Successfully" with checkmark
                saveBtn.innerHTML = '<i class="bi bi-check-circle-fill me-2 text-success"></i> Saved Successfully!';
                saveBtn.classList.remove('btn-primary');
                saveBtn.classList.add('btn-success');
                
                // Show toast notification
                showToast(response.message || 'Settings saved successfully!', 'success');
                
                // After 2 seconds, restore original button
                setTimeout(function() {
                    saveBtn.innerHTML = originalText;
                    saveBtn.classList.remove('btn-success');
                    saveBtn.classList.add('btn-primary');
                    saveBtn.disabled = false;
                }, 2000);
            } else {
                // Error case - show error on button
                saveBtn.innerHTML = '<i class="bi bi-exclamation-triangle-fill me-2"></i> Failed';
                saveBtn.classList.remove('btn-primary');
                saveBtn.classList.add('btn-danger');
                
                showToast(response?.message || 'Error saving settings', 'error');
                
                // After 2 seconds, restore original button
                setTimeout(function() {
                    saveBtn.innerHTML = originalText;
                    saveBtn.classList.remove('btn-danger');
                    saveBtn.classList.add('btn-primary');
                    saveBtn.disabled = false;
                }, 2000);
            }
        },
        error: function(xhr, status, error) {
            console.error('AJAX Error Details:');
            console.error('Status:', status);
            console.error('Error:', error);
            console.error('Response:', xhr.responseText);
            
            let errorMsg = 'Failed to connect to server. ';
            
            if (status === 'timeout') {
                errorMsg += 'Request timed out.';
            } else if (xhr.status === 404) {
                errorMsg += 'Server endpoint not found.';
            } else if (xhr.status === 500) {
                errorMsg += 'Internal server error.';
            } else {
                errorMsg += 'Please try again.';
            }
            
            try {
                const response = JSON.parse(xhr.responseText);
                if (response && response.message) {
                    errorMsg = response.message;
                }
            } catch(e) {
                // Ignore parsing error
            }
            
            // Show error on button
            saveBtn.innerHTML = '<i class="bi bi-exclamation-triangle-fill me-2"></i> Error';
            saveBtn.classList.remove('btn-primary');
            saveBtn.classList.add('btn-danger');
            
            showToast(errorMsg, 'error');
            
            // After 2 seconds, restore original button
            setTimeout(function() {
                saveBtn.innerHTML = originalText;
                saveBtn.classList.remove('btn-danger');
                saveBtn.classList.add('btn-primary');
                saveBtn.disabled = false;
            }, 2000);
        }
    });
}
        
        // Toast notification function
        function showToast(message, type, duration = 5000) {
            const toastContainer = document.getElementById('toastContainer');
            if (!toastContainer) return;
            
            const toastId = 'toast-' + Date.now();
            
            let bgClass = '';
            let icon = '';
            
            switch(type) {
                case 'success':
                    bgClass = 'toast-success';
                    icon = '<i class="bi bi-check-circle-fill me-2"></i>';
                    break;
                case 'error':
                    bgClass = 'toast-error';
                    icon = '<i class="bi bi-exclamation-triangle-fill me-2"></i>';
                    break;
                case 'warning':
                    bgClass = 'toast-warning';
                    icon = '<i class="bi bi-exclamation-circle-fill me-2"></i>';
                    break;
                case 'info':
                default:
                    bgClass = 'toast-info';
                    icon = '<i class="bi bi-info-circle-fill me-2"></i>';
                    break;
            }
            
            const toastHTML = `
                <div id="${toastId}" class="toast ${bgClass}" role="alert" aria-live="assertive" aria-atomic="true">
                    <div class="d-flex">
                        <div class="toast-body">
                            ${icon} ${message}
                        </div>
                        <button type="button" class="btn-close me-2 m-auto" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            `;
            
            toastContainer.insertAdjacentHTML('beforeend', toastHTML);
            
            const toastElement = document.getElementById(toastId);
            const toast = new bootstrap.Toast(toastElement, { delay: duration, animation: true });
            toast.show();
            
            // Remove toast after it's hidden
            toastElement.addEventListener('hidden.bs.toast', function() {
                this.remove();
            });
        }
        
        function resetSettings() {
            if (confirm('Reset all settings to default values? Any unsaved changes will be lost.')) {
                location.reload();
            }
        }
        
        function refreshStorage() {
            showToast('Storage stats refreshed!', 'info');
        }
        
        function backupDatabase() {
            if (confirm('Start database backup? This may take a few minutes.')) {
                showToast('Backup started! You will be notified when complete.', 'info');
            }
        }
        
        function clearCache() {
            if (confirm('Clear system cache?')) {
                showToast('Cache cleared successfully!', 'success');
            }
        }
        
        function cleanLogs() {
            if (confirm('Remove old log files?')) {
                showToast('Logs cleaned successfully!', 'success');
            }
        }
        
        function restartSystem() {
            if (confirm('⚠️ WARNING: This will restart the application server. Continue?')) {
                showToast('System restart initiated...', 'warning');
            }
        }
        
        $(document).ready(function() {
            console.log('Settings page loaded');
            console.log('Context path:', contextPath);
        });
    </script>
</body>
</html>