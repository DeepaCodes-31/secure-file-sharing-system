<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Details - Admin Panel</title>
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
        
        .main-content {
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
        
        .detail-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            background-color: #f8f9fa;
        }
        
        .detail-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
            font-size: 12px;
            text-transform: uppercase;
        }
        
        .detail-value {
            color: #212529;
            margin-bottom: 15px;
            font-size: 16px;
        }
        
        .user-avatar-large {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background: linear-gradient(135deg, #007bff, #00c6ff);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 40px;
            font-weight: bold;
            margin-bottom: 15px;
            box-shadow: 0 4px 10px rgba(0,123,255,0.3);
        }
        
        .status-badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-active { background-color: #d4edda; color: #155724; }
        .badge-inactive { background-color: #f8d7da; color: #721c24; }
        .badge-admin { background-color: #cce5ff; color: #004085; }
        .badge-user { background-color: #e2e3e5; color: #383d41; }
        
        .activity-timeline {
            max-height: 300px;
            overflow-y: auto;
            padding-right: 10px;
        }
        
        .activity-item {
            padding: 10px;
            border-left: 3px solid #007bff;
            margin-bottom: 10px;
            background-color: #f8f9fa;
            border-radius: 0 5px 5px 0;
        }
        
        .activity-time {
            font-size: 11px;
            color: #6c757d;
        }
        
        .activity-action {
            font-weight: 600;
            font-size: 13px;
        }
        
        .file-item {
            padding: 8px;
            border: 1px solid #dee2e6;
            border-radius: 5px;
            margin-bottom: 8px;
            background-color: white;
        }
        
        .action-btn {
            padding: 5px 10px;
            margin: 0 3px;
            border-radius: 4px;
            transition: all 0.2s;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
        }
        
        .footer {
            background-color: #343a40 !important;
            color: white;
            padding: 1rem 0;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <%-- Navigation Bar --%>
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
            <%-- Sidebar --%>
            <div class="col-md-3 col-lg-2 bg-dark sidebar p-0">
                <div class="position-sticky pt-3">
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/users">
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/settings">
                                <i class="bi bi-gear"></i> System Settings
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <%-- Main Content --%>
            <div class="col-md-9 col-lg-10 ms-sm-auto px-md-4 py-4">
                <div class="main-content">
                    <c:choose>
                        <c:when test="${not empty targetUser}">
                            <%-- Page Header with Back Button --%>
                            <div class="page-header d-flex justify-content-between align-items-center">
                                <div>
                                    <h2><i class="bi bi-person-badge me-2 text-primary"></i>User Details</h2>
                                    <p class="text-muted">Detailed information about user: ${targetUser.username}</p>
                                </div>
                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-outline-secondary">
                                    <i class="bi bi-arrow-left me-1"></i> Back to Users
                                </a>
                            </div>

                            <%-- User Profile Card --%>
                            <div class="row mb-4">
                                <div class="col-md-4">
                                    <div class="detail-card text-center">
                                        <div class="user-avatar-large mx-auto">
                                            ${fn:substring(targetUser.username, 0, 1)}
                                        </div>
                                        <h4 class="mb-1">${targetUser.username}</h4>
                                        <p class="text-muted mb-2">${targetUser.email}</p>
                                        <div class="mb-2">
                                            <c:choose>
                                                <c:when test="${targetUser.role == 'ADMIN'}">
                                                    <span class="status-badge badge-admin me-1">
                                                        <i class="bi bi-crown-fill me-1"></i> ADMIN
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge badge-user me-1">
                                                        <i class="bi bi-person-fill me-1"></i> USER
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <c:choose>
                                                <c:when test="${targetUser.active}">
                                                    <span class="status-badge badge-active">
                                                        <i class="bi bi-check-circle-fill me-1"></i> ACTIVE
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge badge-inactive">
                                                        <i class="bi bi-x-circle-fill me-1"></i> INACTIVE
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        
                                        <div class="mt-3">
                                            <c:if test="${targetUser.userId != sessionScope.user.userId}">
                                                <c:choose>
                                                    <c:when test="${targetUser.role == 'ADMIN'}">
                                                        <button class="btn btn-sm btn-warning" 
                                                                onclick="toggleAdmin(${targetUser.userId}, '${targetUser.username}', 'USER')">
                                                            <i class="bi bi-crown-slash me-1"></i> Remove Admin
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-sm btn-success" 
                                                                onclick="toggleAdmin(${targetUser.userId}, '${targetUser.username}', 'ADMIN')">
                                                            <i class="bi bi-crown-fill me-1"></i> Make Admin
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                                <c:choose>
                                                    <c:when test="${targetUser.active}">
                                                        <button class="btn btn-sm btn-danger" 
                                                                onclick="toggleStatus(${targetUser.userId}, '${targetUser.username}', false)">
                                                            <i class="bi bi-ban me-1"></i> Deactivate
                                                        </button>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="btn btn-sm btn-success" 
                                                                onclick="toggleStatus(${targetUser.userId}, '${targetUser.username}', true)">
                                                            <i class="bi bi-check-circle me-1"></i> Activate
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                                <button class="btn btn-sm btn-danger" 
                                                        onclick="deleteUser(${targetUser.userId}, '${targetUser.username}')">
                                                    <i class="bi bi-trash me-1"></i> Delete
                                                </button>
                                            </c:if>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-8">
                                    <div class="detail-card">
                                        <h5 class="mb-3"><i class="bi bi-info-circle me-2"></i>Personal Information</h5>
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="detail-label">Full Name</div>
                                                <div class="detail-value">
                                                    <c:choose>
                                                        <c:when test="${not empty targetUser.firstName or not empty targetUser.lastName}">
                                                            ${targetUser.firstName} ${targetUser.lastName}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Not provided</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                                
                                                <div class="detail-label">Email Address</div>
                                                <div class="detail-value">${targetUser.email}</div>
                                                
                                                <div class="detail-label">User ID</div>
                                                <div class="detail-value">#${targetUser.userId}</div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="detail-label">Account Created</div>
                                                <div class="detail-value">
                                                    <c:if test="${not empty targetUser.createdAt}">
                                                        <fmt:formatDate value="${targetUser.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    </c:if>
                                                </div>
                                                
                                                <div class="detail-label">Last Login</div>
                                                <div class="detail-value">
                                                    <c:if test="${not empty targetUser.lastLogin}">
                                                        <fmt:formatDate value="${targetUser.lastLogin}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                    </c:if>
                                                    <c:if test="${empty targetUser.lastLogin}">
                                                        <span class="text-muted">Never logged in</span>
                                                    </c:if>
                                                </div>
                                                
                                                <div class="detail-label">Total Files</div>
                                                <div class="detail-value">
                                                    <span class="badge bg-info text-white">${fileCount}</span> files
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- User Files Section --%>
                            <div class="detail-card">
                                <h5 class="mb-3"><i class="bi bi-files me-2"></i>User Files (${fileCount})</h5>
                                <c:choose>
                                    <c:when test="${not empty userFiles}">
                                        <div class="table-responsive">
                                            <table class="table table-sm table-hover">
                                                <thead>
                                                    <tr>
                                                        <th>ID</th>
                                                        <th>Filename</th>
                                                        <th>Size</th>
                                                        <th>Type</th>
                                                        <th>Uploaded</th>
                                                        <th>Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <c:forEach var="file" items="${userFiles}" end="4">
                                                        <tr>
                                                            <td>#${file.fileId}</td>
                                                            <td>${file.originalFilename}</td>
                                                            <td>
                                                                <c:choose>
                                                                    <c:when test="${file.fileSize < 1024}">${file.fileSize} B</c:when>
                                                                    <c:when test="${file.fileSize < 1048576}"><fmt:formatNumber value="${file.fileSize / 1024}" pattern="#,##0.00"/> KB</c:when>
                                                                    <c:otherwise><fmt:formatNumber value="${file.fileSize / 1048576}" pattern="#,##0.00"/> MB</c:otherwise>
                                                                </c:choose>
                                                            </td>
                                                            <td><span class="badge bg-secondary">${file.fileType}</span></td>
                                                            <td><fmt:formatDate value="${file.uploadDate}" pattern="yyyy-MM-dd"/></td>
                                                            <td>
                                                                <a href="${pageContext.request.contextPath}/admin/files/${file.fileId}" 
                                                                   class="btn btn-sm btn-outline-info action-btn">
                                                                    <i class="bi bi-eye"></i>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </c:forEach>
                                                </tbody>
                                            </table>
                                        </div>
                                        <c:if test="${fileCount > 5}">
                                            <div class="text-center mt-2">
                                                <small class="text-muted">Showing 5 of ${fileCount} files</small>
                                            </div>
                                        </c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted text-center py-3">No files uploaded by this user</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>

                            <%-- Recent Activity Section --%>
                            <div class="detail-card">
                                <h5 class="mb-3"><i class="bi bi-clock-history me-2"></i>Recent Activity</h5>
                                <c:choose>
                                    <c:when test="${not empty userActivity}">
                                        <div class="activity-timeline">
                                            <c:forEach var="activity" items="${userActivity}">
                                                <div class="activity-item">
                                                    <div class="d-flex justify-content-between">
                                                        <span class="activity-action">${activity.action}</span>
                                                        <span class="activity-time">
                                                            <fmt:formatDate value="${activity.timestamp}" pattern="yyyy-MM-dd HH:mm"/>
                                                        </span>
                                                    </div>
                                                    <div class="small text-muted">${activity.description}</div>
                                                    <div class="small">
                                                        <span class="badge bg-${activity.status == 'SUCCESS' ? 'success' : 'danger'}">${activity.status}</span>
                                                    </div>
                                                </div>
                                            </c:forEach>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="text-muted text-center py-3">No recent activity</p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state text-center py-5">
                                <i class="bi bi-exclamation-triangle fa-3x text-warning mb-3"></i>
                                <h4 class="text-muted">User Not Found</h4>
                                <p class="text-muted">The requested user could not be found.</p>
                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary mt-3">
                                    <i class="bi bi-arrow-left me-1"></i> Back to Users
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <%-- Footer --%>
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
        
        function toggleAdmin(userId, username, newRole) {
            const action = newRole === 'ADMIN' ? 'make' : 'remove';
            if (confirm('Are you sure you want to ' + action + ' ' + username + ' an admin?')) {
                $.ajax({
                    url: contextPath + '/admin/users',
                    type: 'POST',
                    data: {
                        action: 'toggle-admin',
                        userId: userId,
                        role: newRole
                    },
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            location.reload();
                        } else {
                            alert('Failed to update user role');
                        }
                    },
                    error: function() {
                        alert('Error updating user role');
                    }
                });
            }
        }
        
        function toggleStatus(userId, username, activate) {
            const action = activate ? 'activate' : 'deactivate';
            if (confirm('Are you sure you want to ' + action + ' ' + username + '?')) {
                $.ajax({
                    url: contextPath + '/admin/users',
                    type: 'POST',
                    data: {
                        action: 'toggle-user',
                        userId: userId,
                        activate: activate
                    },
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            location.reload();
                        } else {
                            alert('Failed to update user status');
                        }
                    },
                    error: function() {
                        alert('Error updating user status');
                    }
                });
            }
        }
        
        function deleteUser(userId, username) {
            if (confirm('⚠️ WARNING: Are you sure you want to permanently delete ' + username + '? This action cannot be undone.')) {
                if (confirm('FINAL WARNING: Delete ' + username + ' permanently?')) {
                    $.ajax({
                        url: contextPath + '/admin/users',
                        type: 'POST',
                        data: {
                            action: 'delete-user',
                            userId: userId
                        },
                        success: function(response) {
                            if (response.success) {
                                alert('User deleted successfully');
                                window.location.href = contextPath + '/admin/users';
                            } else {
                                alert('Failed to delete user');
                            }
                        },
                        error: function() {
                            alert('Error deleting user');
                        }
                    });
                }
            }
        }
    </script>
</body>
</html>