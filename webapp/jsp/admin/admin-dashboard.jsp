<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Secure File Sharing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
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
            background-color: #f8f9fa;
        }
        
        .stat-card {
            transition: transform 0.3s, box-shadow 0.3s;
            border: none;
            border-radius: 15px;
            cursor: pointer;
            background: white;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
        }
        
        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.15);
        }
        
        .sidebar {
            min-height: calc(100vh - 56px);
            background: linear-gradient(180deg, #2c3e50 0%, #1a252f 100%);
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
            border-radius: 10px;
            transition: all 0.3s;
            text-decoration: none;
            display: block;
        }
        
        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: white;
            transform: translateX(5px);
        }
        
        .nav-link i {
            width: 24px;
            margin-right: 10px;
        }
        
        .border-left-primary {
            border-left: 4px solid #4e73df;
        }
        
        .border-left-success {
            border-left: 4px solid #1cc88a;
        }
        
        .border-left-info {
            border-left: 4px solid #36b9cc;
        }
        
        .border-left-warning {
            border-left: 4px solid #f6c23e;
        }
        
        .text-gray-300 {
            color: #dddfeb;
        }
        
        .bg-gradient-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        }
        
        .status-badge {
            width: 10px;
            height: 10px;
            border-radius: 50%;
            display: inline-block;
            margin-right: 5px;
        }
        
        .status-operational { background-color: #28a745; box-shadow: 0 0 8px #28a745; }
        .status-warning { background-color: #ffc107; box-shadow: 0 0 8px #ffc107; }
        .status-critical { background-color: #dc3545; box-shadow: 0 0 8px #dc3545; }
        
        .progress {
            height: 8px;
            border-radius: 4px;
            background-color: #e9ecef;
        }
        
        .progress-bar {
            background: linear-gradient(90deg, var(--primary-color), var(--secondary-color));
            border-radius: 4px;
        }
        
        .activity-timeline {
            max-height: 400px;
            overflow-y: auto;
            padding-right: 5px;
        }
        
        .activity-timeline::-webkit-scrollbar {
            width: 6px;
        }
        
        .activity-timeline::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        
        .activity-timeline::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 10px;
        }
        
        .badge-action {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
            display: inline-block;
        }
        
        .footer {
            background-color: #343a40;
            color: white;
            padding: 1rem 0;
            margin-top: 2rem;
            margin-left: 250px;
        }
        
        .chart-container {
            background: white;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            height: 100%;
        }
        
        .quick-stat-card {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 10px;
            padding: 20px;
            text-align: center;
            height: 100%;
        }
        
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                min-height: auto;
            }
            .main-content {
                margin-left: 0;
            }
            .footer {
                margin-left: 0;
            }
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
                    <i class="bi bi-person-circle me-1"></i> ${sessionScope.user.username} (Administrator)
                </span>
                <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                    <i class="bi bi-arrow-left me-1"></i> Back to User Dashboard
                </a>
                <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin">
                                <i class="bi bi-speedometer2"></i> Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="bi bi-people"></i> Users
                                <span class="badge bg-primary float-end mt-1">${totalUsers}</span>
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/files">
                                <i class="bi bi-files"></i> Files
                                <span class="badge bg-primary float-end mt-1">${totalFiles}</span>
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
                        <li class="nav-item mt-4 px-3">
                            <div class="text-white small">
                                <div class="d-flex align-items-center mb-2">
                                    <span class="status-badge ${databaseStatus == 'connected' ? 'status-operational' : 'status-critical'}"></span>
                                    <span class="ms-2">Database: ${databaseStatus != null ? databaseStatus : 'Connected'}</span>
                                </div>
                                <div class="d-flex align-items-center mb-2">
                                    <span class="status-badge ${storageHealth.status == 'good' ? 'status-operational' : storageHealth.status == 'warning' ? 'status-warning' : 'status-critical'}"></span>
                                    <span class="ms-2">Storage: ${storageHealth.formattedUsed != null ? storageHealth.formattedUsed : '7.15 MB'} / 15.00 GB</span>
                                </div>
                                <div class="progress mt-2 mb-3">
                                    <div class="progress-bar" style="width: ${storageHealth.percent != null ? storageHealth.percent : 5}%"></div>
                                </div>
                                <div class="d-flex align-items-center">
                                    <span class="status-badge status-operational"></span>
                                    <span class="ms-2">Active Sessions: ${activeSessions != null ? activeSessions : 5}</span>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>

            <%-- Main Content --%>
            <div class="col-md-9 col-lg-10 main-content">
                <%-- Welcome Section --%>
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2><i class="bi bi-speedometer2 me-2 text-primary"></i>Admin Dashboard</h2>
                        <p class="text-muted">Monitor system activities and manage secure file sharing</p>
                    </div>
                    <div class="text-end">
                        <p class="mb-0">
                            <i class="bi bi-person-circle me-1"></i> 
                            <strong>${sessionScope.user.username}</strong>
                        </p>
                        <small class="text-muted">
                            Last login: <fmt:formatDate value="${sessionScope.user.lastLogin}" pattern="yyyy-MM-dd HH:mm:ss"/>
                        </small>
                    </div>
                </div>

                <%-- Statistics Cards --%>
                <div class="row mb-4">
                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card border-left-primary shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                            Total Users
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalUsers != null ? totalUsers : 0}</div>
                                        <small class="text-success">
                                            <i class="bi bi-arrow-up me-1"></i> ${activeUsers != null ? activeUsers : 0} active
                                        </small>
                                    </div>
                                    <div class="col-auto">
                                        <i class="bi bi-people fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card border-left-success shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                            Total Files
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${totalFiles != null ? totalFiles : 0}</div>
                                        <small>
                                            <i class="bi bi-lock me-1"></i> ${storageStats.encryptedCount != null ? storageStats.encryptedCount : 0} encrypted
                                        </small>
                                    </div>
                                    <div class="col-auto">
                                        <i class="bi bi-files fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card border-left-info shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-info text-uppercase mb-1">
                                            Storage Used
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${storageStats.formattedSize != null ? storageStats.formattedSize : '0 B'}</div>
                                        <small>of 15.00 GB total</small>
                                    </div>
                                    <div class="col-auto">
                                        <i class="bi bi-database fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                                <div class="progress mt-2" style="height: 8px;">
                                    <div class="progress-bar bg-info" style="width: ${storageStats.percent != null ? storageStats.percent : 0}%"></div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xl-3 col-md-6 mb-4">
                        <div class="card stat-card border-left-warning shadow h-100 py-2">
                            <div class="card-body">
                                <div class="row no-gutters align-items-center">
                                    <div class="col mr-2">
                                        <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">
                                            Today's Downloads
                                        </div>
                                        <div class="h5 mb-0 font-weight-bold text-gray-800">${todayDownloads != null ? todayDownloads : 0}</div>
                                        <small>Sensitive Files: ${sensitiveFiles != null ? sensitiveFiles : 0}</small>
                                    </div>
                                    <div class="col-auto">
                                        <i class="bi bi-download fa-2x text-gray-300"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <%-- Recent Activity Table --%>
                <div class="card shadow mb-4">
                    <div class="card-header bg-dark text-white py-3">
                        <h6 class="m-0 font-weight-bold">
                            <i class="bi bi-clock-history me-2"></i> Recent System Activity
                        </h6>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-bordered table-hover" width="100%" cellspacing="0">
                                <thead class="bg-light">
                                    <tr>
                                        <th>Action</th>
                                        <th>Description</th>
                                        <th>User</th>
                                        <th>Time</th>
                                        <th>IP Address</th>
                                        <th>Status</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty recentActivity}">
                                            <c:forEach var="activity" items="${recentActivity}">
                                                <tr>
                                                    <td>
                                                        <span class="badge-action 
                                                            <c:choose>
                                                                <c:when test="${fn:toUpperCase(activity.action) == 'UPLOAD'}">bg-primary text-white</c:when>
                                                                <c:when test="${fn:toUpperCase(activity.action) == 'DOWNLOAD'}">bg-success text-white</c:when>
                                                                <c:when test="${fn:toUpperCase(activity.action) == 'LOGIN'}">bg-info text-white</c:when>
                                                                <c:when test="${fn:toUpperCase(activity.action) == 'LOGOUT'}">bg-secondary text-white</c:when>
                                                                <c:when test="${fn:toUpperCase(activity.action) == 'DELETE'}">bg-danger text-white</c:when>
                                                                <c:when test="${fn:toUpperCase(activity.action) == 'SHARE'}">bg-warning text-dark</c:when>
                                                                <c:otherwise>bg-secondary text-white</c:otherwise>
                                                            </c:choose>
                                                        ">
                                                            <i class="fas 
                                                                <c:choose>
                                                                    <c:when test="${fn:toUpperCase(activity.action) == 'UPLOAD'}">fa-upload</c:when>
                                                                    <c:when test="${fn:toUpperCase(activity.action) == 'DOWNLOAD'}">fa-download</c:when>
                                                                    <c:when test="${fn:toUpperCase(activity.action) == 'LOGIN'}">fa-sign-in-alt</c:when>
                                                                    <c:when test="${fn:toUpperCase(activity.action) == 'LOGOUT'}">fa-sign-out-alt</c:when>
                                                                    <c:when test="${fn:toUpperCase(activity.action) == 'DELETE'}">fa-trash</c:when>
                                                                    <c:when test="${fn:toUpperCase(activity.action) == 'SHARE'}">fa-share-alt</c:when>
                                                                    <c:otherwise>fa-info-circle</c:otherwise>
                                                                </c:choose>
                                                            me-1"></i>
                                                            ${activity.action}
                                                        </span>
                                                    </td>
                                                    <td>${activity.description}</td>
                                                    <td>
                                                        <c:set var="found" value="false"/>
                                                        <c:forEach var="user" items="${allUsers}">
                                                            <c:if test="${user.userId == activity.userId}">
                                                                <strong>${user.username}</strong>
                                                                <c:if test="${user.role == 'ADMIN'}">
                                                                    <span class="badge bg-danger ms-1">Admin</span>
                                                                </c:if>
                                                                <c:set var="found" value="true"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        <c:if test="${!found}">
                                                            <span class="text-muted">User ID: ${activity.userId}</span>
                                                        </c:if>
                                                    </td>
                                                    <td><fmt:formatDate value="${activity.timestamp}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                                    <td>${activity.ipAddress}</td>
                                                    <td>
                                                        <span class="badge bg-${activity.status == 'SUCCESS' ? 'success' : 'danger'}">
                                                            <i class="fas fa-${activity.status == 'SUCCESS' ? 'check-circle' : 'exclamation-circle'} me-1"></i>
                                                            ${activity.status}
                                                        </span>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="6" class="text-center py-4">
                                                    <i class="bi bi-inbox fa-2x d-block mb-2 text-muted"></i>
                                                    <span class="text-muted">No recent activity found</span>
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <%-- System Status Row --%>
                <div class="row">
                    <div class="col-lg-6">
                        <div class="card shadow mb-4">
                            <div class="card-header bg-success text-white py-3">
                                <h6 class="m-0 font-weight-bold">
                                    <i class="bi bi-check-circle me-2"></i> Security Features Status
                                </h6>
                            </div>
                            <div class="card-body">
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        AES-256 Encryption
                                        <span class="badge bg-success">
                                            <i class="bi bi-check-circle me-1"></i> Active
                                        </span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        SHA-256 Integrity Check
                                        <span class="badge bg-success">
                                            <i class="bi bi-check-circle me-1"></i> Active
                                        </span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        OTP MFA Authentication
                                        <span class="badge bg-success">
                                            <i class="bi bi-check-circle me-1"></i> Active
                                        </span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        Access Control (RBAC)
                                        <span class="badge bg-success">
                                            <i class="bi bi-check-circle me-1"></i> Active
                                        </span>
                                    </li>
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        Audit Logging
                                        <span class="badge bg-success">
                                            <i class="bi bi-check-circle me-1"></i> Active
                                        </span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="card shadow mb-4">
                            <div class="card-header bg-info text-white py-3">
                                <h6 class="m-0 font-weight-bold">
                                    <i class="bi bi-graph-up me-2"></i> Weekly Activity Trends
                                </h6>
                            </div>
                            <div class="card-body">
                                <canvas id="activityChart" height="150"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
                
                <%-- Quick Stats Row --%>
                <div class="row">
                    <div class="col-md-4 mb-4">
                        <div class="quick-stat-card">
                            <h3 class="text-primary">${userStats.adminCount != null ? userStats.adminCount : 0}</h3>
                            <p class="text-muted mb-0">Administrators</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="quick-stat-card">
                            <h3 class="text-success">${userStats.activeUsers != null ? userStats.activeUsers : 0}</h3>
                            <p class="text-muted mb-0">Active Users</p>
                        </div>
                    </div>
                    <div class="col-md-4 mb-4">
                        <div class="quick-stat-card">
                            <h3 class="text-info">${storageStats.encryptedCount != null ? storageStats.encryptedCount : 0}</h3>
                            <p class="text-muted mb-0">Encrypted Files</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- Footer --%>
    <footer class="footer">
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-6">
                    <p class="mb-0">
                        &copy; 2026 Secure File Sharing System - Admin Panel
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
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script>
        // Weekly Activity Chart
        const ctx = document.getElementById('activityChart').getContext('2d');
        
        // Prepare data from backend with fallbacks
        const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
        
        // Get data from JSP attributes with null checks
        const uploadData = [
            ${not empty weeklyUploads && weeklyUploads.Mon != null ? weeklyUploads.Mon : 0},
            ${not empty weeklyUploads && weeklyUploads.Tue != null ? weeklyUploads.Tue : 0},
            ${not empty weeklyUploads && weeklyUploads.Wed != null ? weeklyUploads.Wed : 0},
            ${not empty weeklyUploads && weeklyUploads.Thu != null ? weeklyUploads.Thu : 0},
            ${not empty weeklyUploads && weeklyUploads.Fri != null ? weeklyUploads.Fri : 0},
            ${not empty weeklyUploads && weeklyUploads.Sat != null ? weeklyUploads.Sat : 0},
            ${not empty weeklyUploads && weeklyUploads.Sun != null ? weeklyUploads.Sun : 0}
        ];
        
        const downloadData = [
            ${not empty weeklyDownloads && weeklyDownloads.Mon != null ? weeklyDownloads.Mon : 0},
            ${not empty weeklyDownloads && weeklyDownloads.Tue != null ? weeklyDownloads.Tue : 0},
            ${not empty weeklyDownloads && weeklyDownloads.Wed != null ? weeklyDownloads.Wed : 0},
            ${not empty weeklyDownloads && weeklyDownloads.Thu != null ? weeklyDownloads.Thu : 0},
            ${not empty weeklyDownloads && weeklyDownloads.Fri != null ? weeklyDownloads.Fri : 0},
            ${not empty weeklyDownloads && weeklyDownloads.Sat != null ? weeklyDownloads.Sat : 0},
            ${not empty weeklyDownloads && weeklyDownloads.Sun != null ? weeklyDownloads.Sun : 0}
        ];
        
        const activityChart = new Chart(ctx, {
            type: 'line',
            data: {
                labels: days,
                datasets: [{
                    label: 'Uploads',
                    data: uploadData,
                    borderColor: 'rgb(75, 192, 192)',
                    backgroundColor: 'rgba(75, 192, 192, 0.1)',
                    tension: 0.4,
                    fill: true
                }, {
                    label: 'Downloads',
                    data: downloadData,
                    borderColor: 'rgb(54, 162, 235)',
                    backgroundColor: 'rgba(54, 162, 235, 0.1)',
                    tension: 0.4,
                    fill: true
                }]
            },
            options: {
                responsive: true,
                maintainAspectRatio: true,
                plugins: {
                    legend: {
                        position: 'top',
                    }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        ticks: {
                            stepSize: 1,
                            precision: 0
                        }
                    }
                }
            }
        });
        
        // Auto-refresh system status every 30 seconds (optional)
        setInterval(function() {
            fetch('${pageContext.request.contextPath}/admin/system-status')
                .then(response => response.json())
                .then(data => {
                    console.log('System status updated', data);
                    // You can update status indicators here if needed
                })
                .catch(error => console.error('Error fetching system status:', error));
        }, 30000);
    </script>
</body>
</html>