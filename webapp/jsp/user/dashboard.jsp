<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    // Debug information
    System.out.println("DEBUG: dashboard.jsp loaded");
    System.out.println("DEBUG: Session ID: " + session.getId());
    System.out.println("DEBUG: User in session: " + session.getAttribute("user"));
    System.out.println("DEBUG: File count: " + session.getAttribute("fileCount"));
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - Secure File Sharing System</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #4cc9f0;
            --danger-color: #f72585;
            --warning-color: #ff9e00;
            --dark-color: #212529;
            --light-color: #f8f9fa;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fb;
            color: #333;
            height: 100%;
            margin: 0;
            padding: 0;
        }
        
        html {
            height: 100%;
        }
        
        .sidebar {
            background: linear-gradient(180deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            height: 100vh;
            position: fixed;
            width: 250px;
            padding-top: 20px;
            box-shadow: 3px 0 10px rgba(0,0,0,0.1);
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }

        .sidebar-content {
            flex: 1;
            overflow-y: auto;
            padding-bottom: 20px;
        }

        .sidebar-footer {
            padding: 15px 0;
            border-top: 1px solid rgba(255,255,255,0.1);
            margin-top: auto;
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
            min-height: 100vh;
        }
        
        .user-profile {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .user-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 30px;
            color: var(--primary-color);
        }
        
        .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 12px 20px;
            margin: 5px 10px;
            border-radius: 8px;
            transition: all 0.3s;
            text-decoration: none;
            display: block;
        }
        
        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: white;
            text-decoration: none;
        }
        
        .nav-link i {
            width: 24px;
            margin-right: 10px;
        }
        
        .stats-card {
            background: white;
            border-radius: 12px;
            padding: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            margin-bottom: 20px;
            border-left: 4px solid var(--primary-color);
            transition: transform 0.3s;
        }
        
        .stats-card:hover {
            transform: translateY(-5px);
        }
        
        .stats-icon {
            width: 50px;
            height: 50px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            margin-bottom: 15px;
        }
        
        .icon-upload { background: #e3f2fd; color: #2196f3; }
        .icon-download { background: #e8f5e9; color: #4caf50; }
        .icon-storage { background: #fff3e0; color: #ff9800; }
        .icon-security { background: #fce4ec; color: #e91e63; }
        
        .file-card {
            background: white;
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
            border: 1px solid #eef2f7;
        }
        
        .file-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
            margin-right: 15px;
        }
        
        .file-pdf { background: #ffebee; color: #f44336; }
        .file-doc { background: #e3f2fd; color: #2196f3; }
        .file-img { background: #f3e5f5; color: #9c27b0; }
        .file-zip { background: #fff3e0; color: #ff9800; }
        
        .notification-badge {
            position: absolute;
            top: -5px;
            right: -5px;
            background: var(--danger-color);
            color: white;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        
        .quick-action-btn {
            background: white;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            transition: all 0.3s;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }
        
        .quick-action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
            border-color: var(--primary-color);
            text-decoration: none;
            color: inherit;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                height: auto;
                min-height: auto;
            }
            .main-content {
                margin-left: 0;
            }
        }
        
        /* Empty state styling */
        .empty-state {
            text-align: center;
            padding: 40px 20px;
        }
        
        .empty-state-icon {
            font-size: 48px;
            color: #ccc;
            margin-bottom: 20px;
        }
        
        /* Scrollbar styling */
        .sidebar-content::-webkit-scrollbar {
            width: 5px;
        }
        
        .sidebar-content::-webkit-scrollbar-track {
            background: rgba(255,255,255,0.1);
        }
        
        .sidebar-content::-webkit-scrollbar-thumb {
            background: rgba(255,255,255,0.3);
            border-radius: 5px;
        }
        
        .sidebar-content::-webkit-scrollbar-thumb:hover {
            background: rgba(255,255,255,0.5);
        }
        
        /* Progress bar for storage */
        .progress-bar-custom {
            height: 6px;
            background: #e9ecef;
            border-radius: 3px;
            overflow: hidden;
        }
        
        .progress-fill {
            height: 100%;
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 3px;
            width: 0%;
        }
        
        /* FIXED: 350px height for both sections */
        .fixed-height-card {
            height: 350px;
            overflow-y: auto;
        }
        
        .fixed-height-card::-webkit-scrollbar {
            width: 6px;
        }
        
        .fixed-height-card::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        
        .fixed-height-card::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 10px;
        }
        
        .fixed-height-card::-webkit-scrollbar-thumb:hover {
            background: var(--secondary-color);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar - Fixed with footer -->
            <div class="col-md-3 col-lg-2 sidebar d-md-block">
                <div class="sidebar-content">
                    <div class="user-profile">
                        <div class="user-avatar">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <!-- FIXED: Added null check for user -->
                        <c:choose>
                            <c:when test="${not empty user}">
                                <h5><c:out value="${user.username}" /></h5>
                                <p class="text-white-50"><c:out value="${user.email}" /></p>
                                <div class="badge bg-success"><c:out value="${user.role}" /></div>
                            </c:when>
                            <c:otherwise>
                                <h5>Guest User</h5>
                                <p class="text-white-50">No user data</p>
                                <div class="badge bg-warning">GUEST</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <nav class="nav flex-column mt-4">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/dashboard">
                            <i class="fas fa-tachometer-alt"></i> Dashboard
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/jsp/user/upload.jsp">
                            <i class="fas fa-cloud-upload-alt"></i> Upload Files
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/myfiles">
                            <i class="fas fa-folder"></i> My Files
                            <c:if test="${not empty fileCount and fileCount > 0}">
                                <span class="badge bg-light text-dark float-end">${fileCount}</span>
                            </c:if>
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/shared">
                            <i class="fas fa-share-alt"></i> Shared Files
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/drive">
                            <i class="fab fa-google-drive"></i> Google Drive
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/recent">
                            <i class="fas fa-history"></i> Recent Activity
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/security">
                            <i class="fas fa-shield-alt"></i> Security
                        </a>
                        <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                            <i class="fas fa-user-cog"></i> Profile Settings
                        </a>
                    </nav>
                </div>
                
                <!-- Sidebar Footer - Always visible at bottom -->
                <div class="sidebar-footer">
                    <nav class="nav flex-column">
                        <a class="nav-link text-warning" href="${pageContext.request.contextPath}/help">
                            <i class="fas fa-question-circle"></i> Help & Support
                        </a>
                        <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </nav>
                </div>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Alert Container -->
                <div id="alertContainer"></div>
                
                <!-- Success/Error Messages Display -->
                <c:if test="${not empty message}">
                    <div class="alert alert-${messageType == 'success' ? 'success' : messageType == 'danger' ? 'danger' : 'info'} 
                                alert-dismissible fade show mb-4" role="alert">
                        <div class="d-flex align-items-center">
                            <c:choose>
                                <c:when test="${messageType == 'success'}">
                                    <i class="fas fa-check-circle fa-lg me-3"></i>
                                </c:when>
                                <c:when test="${messageType == 'danger'}">
                                    <i class="fas fa-exclamation-triangle fa-lg me-3"></i>
                                </c:when>
                                <c:otherwise>
                                    <i class="fas fa-info-circle fa-lg me-3"></i>
                                </c:otherwise>
                            </c:choose>
                            <div class="flex-grow-1">
                                <h6 class="mb-1">
                                    <c:choose>
                                        <c:when test="${messageType == 'success'}">Success!</c:when>
                                        <c:when test="${messageType == 'danger'}">Error!</c:when>
                                        <c:otherwise>Notice</c:otherwise>
                                    </c:choose>
                                </h6>
                                <p class="mb-0">${message}</p>
                                
                                <!-- ENCRYPTION PASSWORD DISPLAY -->
                                <c:if test="${not empty encryptionPassword}">
                                    <div class="mt-3">
                                        <div class="alert alert-warning p-3">
                                            <div class="d-flex align-items-start">
                                                <i class="fas fa-key fa-lg me-3 mt-1"></i>
                                                <div>
                                                    <h6 class="mb-2">
                                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                                        IMPORTANT: Save Your Encryption Password
                                                    </h6>
                                                    <p class="mb-2">
                                                        You selected encryption for this file. 
                                                        <strong>Save this password securely</strong> - you will need it to decrypt the file later.
                                                    </p>
                                                    <div class="bg-light p-3 rounded mb-2">
                                                        <div class="d-flex justify-content-between align-items-center">
                                                            <div>
                                                                <code class="fs-5 fw-bold">${encryptionPassword}</code>
                                                            </div>
                                                            <div>
                                                               <button class="btn btn-sm btn-outline-primary" onclick="copyPassword('${encryptionPassword}', this)">
                                                                    <i class="fas fa-copy me-1"></i>Copy
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <small class="text-muted">
                                                        <i class="fas fa-lightbulb me-1"></i>
                                                        <strong>Tip:</strong> Save this password in a password manager or write it down securely.
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </div>
                </c:if>
                
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <c:choose>
                            <c:when test="${not empty user}">
                                <h2 class="mb-1">Welcome back, <c:out value="${user.username}" />!</h2>
                            </c:when>
                            <c:otherwise>
                                <h2 class="mb-1">Welcome to Secure File Sharing</h2>
                            </c:otherwise>
                        </c:choose>
                        <p class="text-muted">Secure File Sharing with Google Drive</p>
                    </div>
                    <div class="d-flex align-items-center">
                        <div class="position-relative me-3">
                            <i class="fas fa-bell fa-lg text-muted"></i>
                            <c:if test="${not empty notifications and notifications > 0}">
                                <span class="notification-badge">${notifications}</span>
                            </c:if>
                        </div>
                        <a href="${pageContext.request.contextPath}/jsp/user/upload.jsp" class="btn btn-primary">
                            <i class="fas fa-plus me-2"></i> Upload File
                        </a>
                    </div>
                </div>
                
                <!-- Stats Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stats-icon icon-upload">
                                <i class="fas fa-upload"></i>
                            </div>
                            <h4><c:out value="${not empty uploadCount ? uploadCount : 0}" /></h4>
                            <p class="text-muted mb-0">Files Uploaded</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stats-icon icon-download">
                                <i class="fas fa-download"></i>
                            </div>
                            <h4>${not empty downloadCount ? downloadCount : 0}</h4>
                            <p class="text-muted mb-0">Files Downloaded</p>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stats-icon icon-storage">
                                <i class="fab fa-google-drive"></i>
                            </div>
                            <h4><c:out value="${not empty storageUsed ? storageUsed : '0.00'}" /> GB</h4>
                            <p class="text-muted mb-0">Google Drive Storage</p>
                            <div class="progress-bar-custom mt-2">
                                <div class="progress-fill" style="width: ${not empty storagePercent ? storagePercent : 0}%"></div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="stats-card">
                            <div class="stats-icon icon-security">
                                <i class="fas fa-shield-alt"></i>
                            </div>
                            <h4><c:out value="${not empty securityScore ? securityScore : 100}" />%</h4>
                            <p class="text-muted mb-0">Security Score</p>
                        </div>
                    </div>
                </div>
                
                <!-- Quick Actions -->
                <div class="row mb-4">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Quick Actions</h5>
                            </div>
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/jsp/user/upload.jsp" class="quick-action-btn">
                                            <i class="fas fa-cloud-upload-alt fa-2x text-primary mb-3"></i>
                                            <h6>Upload File</h6>
                                            <p class="text-muted small">Upload to Google Drive</p>
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/shared" class="quick-action-btn">
                                            <i class="fas fa-share-alt fa-2x text-success mb-3"></i>
                                            <h6>Share Files</h6>
                                            <p class="text-muted small">Share with others</p>
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/jsp/user/upload.jsp?encrypt=true" class="quick-action-btn">
                                            <i class="fas fa-lock fa-2x text-warning mb-3"></i>
                                            <h6>Encrypt Files</h6>
                                            <p class="text-muted small">AES-256 encryption</p>
                                        </a>
                                    </div>
                                    <div class="col-md-3 mb-3">
                                        <a href="${pageContext.request.contextPath}/drive" class="quick-action-btn">
                                            <i class="fab fa-google-drive fa-2x text-info mb-3"></i>
                                            <h6>Google Drive</h6>
                                            <p class="text-muted small">Manage cloud storage</p>
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="row">
                    <!-- Recent Files -->
                    <div class="col-lg-8">
                        <div class="card">
                            <div class="card-header bg-white d-flex justify-content-between align-items-center">
                                <h5 class="mb-0">Recent Files</h5>
                                <!-- FIXED: Changed from 'my-files' to 'myfiles' -->
                                <a href="${pageContext.request.contextPath}/myfiles" class="btn btn-sm btn-outline-primary">View All</a>
                            </div>
                            <!-- FIXED: Added fixed-height-card class with 350px height -->
                            <div class="card-body fixed-height-card">
                                <c:choose>
                                    <c:when test="${not empty recentFiles}">
                                        <c:forEach var="file" items="${recentFiles}" varStatus="loop">
                                            <c:if test="${loop.index < 5}">
                                                <div class="file-card d-flex align-items-center mb-3">
                                                    <div class="file-icon 
                                                        <c:choose>
                                                            <c:when test="${fn:toLowerCase(file.fileType) == 'pdf'}">file-pdf</c:when>
                                                            <c:when test="${fn:toLowerCase(file.fileType) == 'doc' or fn:toLowerCase(file.fileType) == 'docx'}">file-doc</c:when>
                                                            <c:when test="${fn:toLowerCase(file.fileType) == 'jpg' or fn:toLowerCase(file.fileType) == 'png' or fn:toLowerCase(file.fileType) == 'jpeg'}">file-img</c:when>
                                                            <c:when test="${fn:toLowerCase(file.fileType) == 'zip' or fn:toLowerCase(file.fileType) == 'rar'}">file-zip</c:when>
                                                            <c:otherwise>file-pdf</c:otherwise>
                                                        </c:choose>">
                                                        <i class="fas fa-file"></i>
                                                    </div>
                                                    <div class="flex-grow-1 ms-3">
                                                        <h6 class="mb-1">${file.originalFilename}</h6>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${file.uploadDate}" pattern="yyyy-MM-dd" />
                                                            • Size: ${file.fileSize} bytes
                                                            <c:if test="${file.encrypted}">
                                                                <span class="badge bg-warning ms-2">
                                                                    <i class="fas fa-lock me-1"></i>AES-256 Encrypted
                                                                </span>
                                                            </c:if>
                                                            <c:if test="${file.cloudFileId != null}">
                                                                <span class="badge bg-success ms-2">
                                                                    <i class="fab fa-google-drive me-1"></i>Google Drive
                                                                </span>
                                                            </c:if>
                                                        </small>
                                                        <c:if test="${not empty file.description}">
                                                            <p class="mb-0 mt-1 small text-muted">${file.description}</p>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </c:if>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-5">
                                            <i class="fas fa-folder-open fa-3x text-muted mb-3"></i>
                                            <p class="text-muted">No files uploaded yet</p>
                                            <a href="${pageContext.request.contextPath}/jsp/user/upload.jsp" class="btn btn-primary">
                                                <i class="fas fa-plus me-2"></i>Upload Your First File
                                            </a>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    
                    <!-- Recent Activity -->
                    <div class="col-lg-4">
                        <div class="card">
                            <div class="card-header bg-white">
                                <h5 class="mb-0">Recent Activity</h5>
                            </div>
                            <!-- FIXED: Added fixed-height-card class with 350px height -->
                            <div class="card-body fixed-height-card">
                                <c:choose>
                                    <c:when test="${not empty recentActivity}">
                                        <c:forEach var="activity" items="${recentActivity}">
                                            <div class="d-flex mb-3">
                                                <div class="flex-shrink-0">
                                                    <c:choose>
                                                        <c:when test="${fn:contains(fn:toLowerCase(activity.description), 'upload')}">
                                                            <div class="rounded-circle bg-light p-2 text-primary">
                                                                <i class="fas fa-upload"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${fn:contains(fn:toLowerCase(activity.description), 'download')}">
                                                            <div class="rounded-circle bg-light p-2 text-success">
                                                                <i class="fas fa-download"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:when test="${fn:contains(fn:toLowerCase(activity.description), 'google')}">
                                                            <div class="rounded-circle bg-light p-2 text-info">
                                                                <i class="fab fa-google-drive"></i>
                                                            </div>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <div class="rounded-circle bg-light p-2 text-warning">
                                                                <i class="fas fa-user"></i>
                                                            </div>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                <div class="flex-grow-1 ms-3">
                                                    <h6 class="mb-0">${activity.description}</h6>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${activity.timestamp}" pattern="yyyy-MM-dd HH:mm:ss" />
                                                    </small>
                                                </div>
                                            </div>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="text-center py-4">
                                            <i class="fas fa-history fa-2x text-muted mb-3"></i>
                                            <p class="text-muted">No recent activity</p>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Footer -->
                <footer class="mt-5 pt-4 border-top">
                    <div class="row">
                        <div class="col-md-6">
                            <p class="text-muted">Secure File Sharing System v1.0</p>
                            <p class="text-muted small">
                                <i class="fab fa-google-drive text-success me-1"></i>
                                Connected to Google Drive
                            </p>
                        </div>
                        <div class="col-md-6 text-end">
                            <p class="text-muted">
                                <c:choose>
                                    <c:when test="${not empty lastLogin}">
                                        <i class="fas fa-shield-alt text-success me-1"></i>
                                        Last Login: ${lastLogin} from ${not empty lastLoginIP ? lastLoginIP : 'Unknown'}
                                    </c:when>
                                    <c:otherwise>
                                        <i class="fas fa-shield-alt text-warning me-1"></i>
                                        First login detected
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        // Debug information
        console.log("Dashboard JS loaded");
        console.log("Context path: ", "<c:out value='${pageContext.request.contextPath}' />");
        
        // Check for upload redirect from success page
        document.addEventListener('DOMContentLoaded', function() {
            console.log("Dashboard page loaded");
            
            // Check URL parameters for upload data
            const urlParams = new URLSearchParams(window.location.search);
            const uploadDataParam = urlParams.get('uploadData');
            
            if (uploadDataParam) {
                try {
                    const uploadData = JSON.parse(decodeURIComponent(uploadDataParam));
                    if (uploadData.success) {
                        // Store data and remove from URL
                        localStorage.setItem('uploadData', JSON.stringify(uploadData));
                        sessionStorage.setItem('lastUploadData', JSON.stringify(uploadData));
                        
                        // Remove the parameter from URL without reloading
                        const newUrl = window.location.pathname + window.location.search.replace(/[?&]uploadData=[^&]+/, '').replace(/^&/, '?');
                        window.history.replaceState({}, document.title, newUrl);
                        
                        // Show success message
                        showUploadSuccess(uploadData);
                    }
                } catch (e) {
                    console.error('Error parsing upload data from URL:', e);
                }
            }
            
            // Also check localStorage for upload data
            const storedData = localStorage.getItem('uploadData');
            if (storedData) {
                try {
                    const uploadData = JSON.parse(storedData);
                    if (uploadData.success) {
                        showUploadSuccess(uploadData);
                        // Clear localStorage after showing
                        localStorage.removeItem('uploadData');
                    }
                } catch (e) {
                    console.error('Error parsing stored upload data:', e);
                }
            }
        });
        
        // Show upload success message in dashboard
        function showUploadSuccess(response) {
            let message = `
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <div class="d-flex align-items-center">
                        <i class="fas fa-check-circle fa-lg me-3"></i>
                        <div class="flex-grow-1">
                            <h6 class="mb-1">Success! File Uploaded to Google Drive</h6>
                            <p class="mb-2">Your file has been securely uploaded to Google Drive.</p>
            `;
            
            // Add encryption password if encrypted
            if (response.encrypted && response.encryptionPassword) {
                message += `
                    <div class="alert alert-warning mt-2 p-2">
                        <h6><i class="fas fa-exclamation-triangle me-2"></i>IMPORTANT: Save Your Encryption Password</h6>
                        <p class="mb-2">You selected encryption for this file. <strong>Save this password securely</strong>!</p>
                        <div class="bg-light p-2 rounded">
                            <div class="d-flex justify-content-between align-items-center">
                                <div><code class="fs-6 fw-bold">` + response.encryptionPassword + `</code></div>
                                <div><button class="btn btn-sm btn-outline-primary" onclick="copyPassword('` + response.encryptionPassword + `', this)">
                                    <i class="fas fa-copy me-1"></i>Copy</button></div>
                            </div>
                        </div>
                        <small class="text-muted">Tip: Save in a password manager or write it down securely.</small>
                    </div>
                `;
            }
            
            // Add file details
            message += `
                <div class="mt-2 small">
                    <strong>File:</strong> ` + (response.filename || 'Uploaded file') + `<br>
                    <strong>Size:</strong> ` + (response.originalSize ? formatFileSize(response.originalSize) : 'Unknown') + `<br>
            `;
            
            if (response.cloudFileId) {
                message += `<strong>Google Drive ID:</strong> ` + response.cloudFileId.substring(0, 16) + `...<br>`;
            }
            
            if (response.sha256 && response.sha256.original) {
                message += `<strong>SHA-256:</strong> ` + response.sha256.original.substring(0, 32) + `...<br>`;
            }
            
            message += `
                        </div>
                        </div>
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </div>
            `;
            
            const alertContainer = document.getElementById('alertContainer');
            if (alertContainer) {
                alertContainer.innerHTML = message;
            }
        }
        
        // Format file size
        function formatFileSize(bytes) {
            if (!bytes || bytes === 0) return '0 Bytes';
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }
        
        // Copy password to clipboard
        function copyPassword(password, buttonElement) {
            navigator.clipboard.writeText(password).then(function() {
                const copyBtn = buttonElement;
                const originalHTML = copyBtn.innerHTML;
                copyBtn.innerHTML = '<i class="fas fa-check me-1"></i>Copied!';
                copyBtn.classList.remove('btn-outline-primary');
                copyBtn.classList.add('btn-success');
                
                setTimeout(() => {
                    copyBtn.innerHTML = originalHTML;
                    copyBtn.classList.remove('btn-success');
                    copyBtn.classList.add('btn-outline-primary');
                }, 2000);
            });
        }
    </script>
</body>
</html>