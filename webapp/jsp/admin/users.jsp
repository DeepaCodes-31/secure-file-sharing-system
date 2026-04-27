<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Management - Admin Panel</title>
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
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
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
        
        .table thead {
            background-color: #e9ecef;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background-color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: bold;
        }
        
        .badge-role {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        
        .badge-admin {
            background-color: #dc3545;
            color: white;
        }
        
        .badge-user {
            background-color: #28a745;
            color: white;
        }
        
        .status-badge {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }
        .status-active { background-color: #28a745; }
        .status-inactive { background-color: #dc3545; }
        
        .action-btn {
            padding: 5px 10px;
            margin: 0 3px;
            border-radius: 4px;
            transition: all 0.2s;
            font-size: 13px;
            display: inline-flex;
            align-items: center;
            gap: 5px;
            border: 1px solid transparent;
        }
        
        .action-btn i {
            font-size: 14px;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        
        /* Normal button styles matching delete and info */
        .btn-make-admin {
            background-color: #6f42c1;
            color: white;
            border: none;
        }
        
        .btn-remove-admin {
            background-color: #fd7e14;
            color: white;
            border: none;
        }
        
        .btn-deactivate {
            background-color: #dc3545;
            color: white;
            border: none;
        }
        
        .btn-activate {
            background-color: #28a745;
            color: white;
            border: none;
        }
        
        .btn-delete {
            background-color: #dc3545;
            color: white;
            border: none;
        }
        
        .btn-info-custom {
            background-color: #17a2b8;
            color: white;
            border: none;
        }
        
        .btn-outline-warning {
            color: #fd7e14;
            border-color: #fd7e14;
        }
        
        .btn-outline-warning:hover {
            background-color: #fd7e14;
            color: white;
        }
        
        .btn-outline-success {
            color: #28a745;
            border-color: #28a745;
        }
        
        .btn-outline-success:hover {
            background-color: #28a745;
            color: white;
        }
        
        .btn-outline-danger {
            color: #dc3545;
            border-color: #dc3545;
        }
        
        .btn-outline-danger:hover {
            background-color: #dc3545;
            color: white;
        }
        
        .btn-outline-info {
            color: #17a2b8;
            border-color: #17a2b8;
        }
        
        .btn-outline-info:hover {
            background-color: #17a2b8;
            color: white;
        }
        
        .action-group {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }
        
        .footer {
            background-color: #343a40 !important;
            color: white;
            padding: 1rem 0;
            margin-top: 2rem;
        }
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        
        .empty-state-icon {
            font-size: 64px;
            color: #ccc;
            margin-bottom: 20px;
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
                                <span class="badge bg-primary float-end mt-1">${fn:length(users)}</span>
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
                    <%-- Page Header --%>
                    <div class="page-header d-flex justify-content-between align-items-center">
                        <div>
                            <h2><i class="bi bi-people-fill me-2 text-primary"></i>User Management</h2>
                            <p class="text-muted">Manage system users and administrator privileges</p>
                        </div>
                        <div>
                            <span class="badge bg-primary p-3">
                                <i class="bi bi-people me-1"></i> Total Users: ${fn:length(users)}
                            </span>
                        </div>
                    </div>

                    <%-- Users Table --%>
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>User</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th>Joined</th>
                                    <th>Last Login</th>
                                    <th>Files</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${users}">
                                    <tr>
                                        <td><strong>#${user.userId}</strong></td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="user-avatar me-2">
                                                    ${fn:substring(user.username, 0, 1)}
                                                </div>
                                                <div>
                                                    <strong>${user.username}</strong>
                                                    <c:if test="${not empty user.firstName}">
                                                        <br>
                                                        <small class="text-muted">${user.firstName} ${user.lastName}</small>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </td>
                                        <td>${user.email}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.role == 'ADMIN'}">
                                                    <span class="badge-role badge-admin">
                                                        <i class="bi bi-crown-fill me-1"></i> ADMIN
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge-role badge-user">
                                                        <i class="bi bi-person-fill me-1"></i> USER
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${user.active}">
                                                    <span class="status-badge status-active"></span>
                                                    <span class="text-success">Active</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-inactive"></span>
                                                    <span class="text-danger">Inactive</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:if test="${not empty user.createdAt}">
                                                <fmt:formatDate value="${user.createdAt}" pattern="yyyy-MM-dd"/>
                                            </c:if>
                                        </td>
                                        <td>
                                            <c:if test="${not empty user.lastLogin}">
                                                <fmt:formatDate value="${user.lastLogin}" pattern="yyyy-MM-dd HH:mm"/>
                                            </c:if>
                                            <c:if test="${empty user.lastLogin}">
                                                <span class="text-muted">Never</span>
                                            </c:if>
                                        </td>
                                        <td>
                                            <span class="badge bg-info text-white">
                                                ${userFileCounts[user.userId] != null ? userFileCounts[user.userId] : 0}
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-group">
                                                <%-- Make Admin / Remove Admin Button --%>
                                                <c:choose>
                                                    <c:when test="${user.role == 'ADMIN'}">
                                                        <c:if test="${user.userId != sessionScope.user.userId}">
                                                            <button class="action-btn btn-remove-admin" 
                                                                    onclick="toggleAdmin(${user.userId}, '${user.username}', 'USER')"
                                                                    title="Remove Admin">
                                                                <i class="bi bi-shield-slash"></i>
                                                            </button>
                                                        </c:if>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <button class="action-btn btn-make-admin" 
                                                                onclick="toggleAdmin(${user.userId}, '${user.username}', 'ADMIN')"
                                                                title="Make Admin">
                                                            <i class="bi bi-shield-fill"></i>
                                                        </button>
                                                    </c:otherwise>
                                                </c:choose>
                                                
                                                <%-- Activate / Deactivate Button --%>
                                                <c:if test="${user.userId != sessionScope.user.userId}">
                                                    <c:choose>
                                                        <c:when test="${user.active}">
                                                            <button class="action-btn btn-deactivate" 
                                                                    onclick="toggleStatus(${user.userId}, '${user.username}', false)"
                                                                    title="Deactivate">
                                                                <i class="bi bi-exclamation-triangle"></i>
                                                            </button>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <button class="action-btn btn-activate" 
                                                                    onclick="toggleStatus(${user.userId}, '${user.username}', true)"
                                                                    title="Activate">
                                                                <i class="bi bi-check-circle"></i>
                                                            </button>
                                                        </c:otherwise>
                                                    </c:choose>
                                                    
                                                    <%-- Delete Button --%>
                                                    <button class="action-btn btn-delete" 
                                                            onclick="deleteUser(${user.userId}, '${user.username}')"
                                                            title="Delete User">
                                                        <i class="bi bi-trash"></i>
                                                    </button>
                                                </c:if>
                                                
                                                <%-- View Details Button --%>
                                                <a href="${pageContext.request.contextPath}/admin/users/${user.userId}" 
                                                   class="action-btn btn-info-custom"
                                                   title="View Details">
                                                    <i class="bi bi-info-circle"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                                
                                <c:if test="${empty users}">
                                    <tr>
                                        <td colspan="9" class="text-center py-5">
                                            <i class="bi bi-people fa-3x d-block mb-3 text-muted"></i>
                                            <h5 class="text-muted">No users found</h5>
                                        </td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>

                    <%-- Summary Cards --%>
                    <div class="row mt-4">
                        <div class="col-md-4">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <h3 class="text-primary">${fn:length(users)}</h3>
                                    <p class="text-muted mb-0">Total Users</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <c:set var="activeCount" value="0"/>
                                    <c:forEach var="user" items="${users}">
                                        <c:if test="${user.active}">
                                            <c:set var="activeCount" value="${activeCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <h3 class="text-success">${activeCount}</h3>
                                    <p class="text-muted mb-0">Active Users</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <c:set var="adminCount" value="0"/>
                                    <c:forEach var="user" items="${users}">
                                        <c:if test="${user.role == 'ADMIN'}">
                                            <c:set var="adminCount" value="${adminCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <h3 class="text-warning">${adminCount}</h3>
                                    <p class="text-muted mb-0">Administrators</p>
                                </div>
                            </div>
                        </div>
                    </div>
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
                                location.reload();
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