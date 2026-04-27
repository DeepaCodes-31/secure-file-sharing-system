<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Audit Logs - Admin Panel</title>
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
        
        .filter-section {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 25px;
            border: 1px solid #dee2e6;
        }
        
        .table thead {
            background-color: #e9ecef;
        }
        
        .badge-action {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 11px;
            font-weight: 600;
        }
        
        .badge-UPLOAD { background-color: #007bff; color: white; }
        .badge-DOWNLOAD { background-color: #28a745; color: white; }
        .badge-LOGIN { background-color: #17a2b8; color: white; }
        .badge-LOGOUT { background-color: #6c757d; color: white; }
        .badge-DELETE { background-color: #dc3545; color: white; }
        .badge-ADMIN_ACCESS { background-color: #ffc107; color: black; }
        .badge-SHARE { background-color: #6610f2; color: white; }
        .badge-default { background-color: #6c757d; color: white; }
        
        .status-badge {
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 11px;
        }
        
        .status-SUCCESS { background-color: #d4edda; color: #155724; }
        .status-FAILED { background-color: #f8d7da; color: #721c24; }
        .status-PENDING { background-color: #fff3cd; color: #856404; }
        
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
            margin-left: 250px;
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
        
        .log-details {
            max-width: 300px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        
        .modal-detail-row {
            display: flex;
            margin-bottom: 12px;
            border-bottom: 1px solid #e9ecef;
            padding-bottom: 8px;
        }
        
        .modal-detail-label {
            font-weight: 600;
            width: 120px;
            color: #495057;
        }
        
        .modal-detail-value {
            flex: 1;
            color: #212529;
            word-break: break-word;
        }
        
        .modal-header {
            background: linear-gradient(135deg, #007bff, #0056b3);
            color: white;
        }
        
        .modal-header .btn-close {
            filter: brightness(0) invert(1);
        }
        
        .detail-badge {
            font-size: 12px;
            padding: 4px 10px;
            border-radius: 20px;
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
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/logs">
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

            <div class="col-md-9 col-lg-10 ms-sm-auto px-md-4 py-4">
                <div class="main-content">
                    <%-- Calculate log count safely --%>
                    <c:choose>
                        <c:when test="${empty logs}">
                            <c:set var="logCount" value="0" />
                        </c:when>
                        <c:otherwise>
                            <c:set var="logCount" value="${logs.size()}" />
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="page-header d-flex justify-content-between align-items-center">
                        <div>
                            <h2><i class="bi bi-clipboard-data me-2 text-primary"></i>Audit Logs</h2>
                            <p class="text-muted">View all system activities and user actions</p>
                        </div>
                        <div>
                            <span class="badge bg-primary p-3">
                                <i class="bi bi-list me-1"></i> Total Logs: ${logCount}
                            </span>
                        </div>
                    </div>

                    <div class="filter-section">
                        <form method="get" action="${pageContext.request.contextPath}/admin/logs" class="row g-3">
                            <div class="col-md-3">
                                <label class="form-label">Filter by Action</label>
                                <select name="filter" class="form-select">
                                    <option value="">All Actions</option>
                                    <option value="UPLOAD" ${filter == 'UPLOAD' ? 'selected' : ''}>Upload</option>
                                    <option value="DOWNLOAD" ${filter == 'DOWNLOAD' ? 'selected' : ''}>Download</option>
                                    <option value="LOGIN" ${filter == 'LOGIN' ? 'selected' : ''}>Login</option>
                                    <option value="LOGOUT" ${filter == 'LOGOUT' ? 'selected' : ''}>Logout</option>
                                    <option value="DELETE" ${filter == 'DELETE' ? 'selected' : ''}>Delete</option>
                                    <option value="SHARE" ${filter == 'SHARE' ? 'selected' : ''}>Share</option>
                                    <option value="ADMIN_ACCESS" ${filter == 'ADMIN_ACCESS' ? 'selected' : ''}>Admin Access</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">From Date</label>
                                <input type="date" name="dateFrom" class="form-control" value="${dateFrom}">
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">To Date</label>
                                <input type="date" name="dateTo" class="form-control" value="${dateTo}">
                            </div>
                            <div class="col-md-3 d-flex align-items-end">
                                <button type="submit" class="btn btn-primary me-2">
                                    <i class="bi bi-filter me-1"></i> Apply Filter
                                </button>
                                <a href="${pageContext.request.contextPath}/admin/logs" class="btn btn-secondary">
                                    <i class="bi bi-arrow-counterclockwise"></i>
                                </a>
                            </div>
                        </form>
                    </div>

                    <c:choose>
                        <c:when test="${not empty logs}">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>Timestamp</th>
                                            <th>User</th>
                                            <th>Action</th>
                                            <th>Description</th>
                                            <th>IP Address</th>
                                            <th>Status</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="log" items="${logs}" varStatus="status">
                                            <tr>
                                                <td><strong>#${log.id}</strong></td>
                                                <td>
                                                    <fmt:formatDate value="${log.timestamp}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${log.userId > 0}">
                                                            <span class="fw-bold" id="userName-${log.id}">User ID: ${log.userId}</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">System</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <span class="badge-action 
                                                        <c:choose>
                                                            <c:when test="${log.action == 'UPLOAD'}">badge-UPLOAD</c:when>
                                                            <c:when test="${log.action == 'DOWNLOAD'}">badge-DOWNLOAD</c:when>
                                                            <c:when test="${log.action == 'LOGIN'}">badge-LOGIN</c:when>
                                                            <c:when test="${log.action == 'LOGOUT'}">badge-LOGOUT</c:when>
                                                            <c:when test="${log.action == 'DELETE'}">badge-DELETE</c:when>
                                                            <c:when test="${log.action == 'SHARE'}">badge-SHARE</c:when>
                                                            <c:when test="${log.action == 'ADMIN_ACCESS'}">badge-ADMIN_ACCESS</c:when>
                                                            <c:otherwise>badge-default</c:otherwise>
                                                        </c:choose>
                                                    ">
                                                        <c:choose>
                                                            <c:when test="${log.action == 'UPLOAD'}"><i class="bi bi-upload me-1"></i></c:when>
                                                            <c:when test="${log.action == 'DOWNLOAD'}"><i class="bi bi-download me-1"></i></c:when>
                                                            <c:when test="${log.action == 'LOGIN'}"><i class="bi bi-box-arrow-in-right me-1"></i></c:when>
                                                            <c:when test="${log.action == 'LOGOUT'}"><i class="bi bi-box-arrow-right me-1"></i></c:when>
                                                            <c:when test="${log.action == 'DELETE'}"><i class="bi bi-trash me-1"></i></c:when>
                                                            <c:when test="${log.action == 'SHARE'}"><i class="bi bi-share me-1"></i></c:when>
                                                            <c:when test="${log.action == 'ADMIN_ACCESS'}"><i class="bi bi-shield-lock me-1"></i></c:when>
                                                        </c:choose>
                                                        ${log.action}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="log-details" title="${log.description}">
                                                        ${log.description}
                                                    </div>
                                                </td>
                                                <td>${log.ipAddress}</td>
                                                <td>
                                                    <span class="status-badge status-${log.status}">
                                                        ${log.status}
                                                    </span>
                                                </td>
                                                <td>
                                                    <button class="btn btn-sm btn-outline-info action-btn" 
                                                            onclick="viewLogDetails(${log.id})"
                                                            title="View Details">
                                                        <i class="bi bi-info-circle"></i>
                                                    </button>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state">
                                <div class="empty-state-icon">
                                    <i class="bi bi-clipboard-data"></i>
                                </div>
                                <h4 class="text-muted">No Logs Found</h4>
                                <p class="text-muted">There are no audit logs matching your criteria.</p>
                                <c:if test="${not empty filter or not empty dateFrom or not empty dateTo}">
                                    <a href="${pageContext.request.contextPath}/admin/logs" class="btn btn-primary mt-3">
                                        <i class="bi bi-arrow-counterclockwise me-1"></i> Clear Filters
                                    </a>
                                </c:if>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <div class="row mt-4">
                        <div class="col-md-3">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <h3 class="text-primary">${logCount}</h3>
                                    <p class="text-muted mb-0">Showing</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <c:set var="successCount" value="0"/>
                                    <c:forEach var="log" items="${logs}">
                                        <c:if test="${log.status == 'SUCCESS'}">
                                            <c:set var="successCount" value="${successCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <h3 class="text-success">${successCount}</h3>
                                    <p class="text-muted mb-0">Successful</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <c:set var="failedCount" value="0"/>
                                    <c:forEach var="log" items="${logs}">
                                        <c:if test="${log.status == 'FAILED'}">
                                            <c:set var="failedCount" value="${failedCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <h3 class="text-danger">${failedCount}</h3>
                                    <p class="text-muted mb-0">Failed</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <button class="btn btn-outline-danger btn-sm" onclick="clearOldLogs()">
                                        <i class="bi bi-trash me-1"></i> Clear Old Logs
                                    </button>
                                </div>
                            </div>
                        </div>
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

    <!-- Log Details Modal - FIXED: Now shows actual log details -->
    <div class="modal fade" id="logDetailsModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-info-circle me-2"></i>Log Details
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="logDetailsContent">
                    <div class="text-center py-4">
                        <div class="spinner-border text-primary" role="status">
                            <span class="visually-hidden">Loading...</span>
                        </div>
                        <p class="mt-2">Loading log details...</p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <script>
        const contextPath = '<%= request.getContextPath() %>';
        
        // FIXED: viewLogDetails function now shows actual log data
        function viewLogDetails(logId) {
            // Find the log data from the table row
            const row = event.target.closest('tr');
            
            // Extract data from the row
            const id = $(row).find('td:eq(0)').text().trim();
            const timestamp = $(row).find('td:eq(1)').text().trim();
            const user = $(row).find('td:eq(2)').text().trim();
            const action = $(row).find('td:eq(3) .badge-action').text().trim();
            const description = $(row).find('td:eq(4) .log-details').attr('title') || $(row).find('td:eq(4)').text().trim();
            const ipAddress = $(row).find('td:eq(5)').text().trim();
            const status = $(row).find('td:eq(6) .status-badge').text().trim();
            
            // Get status color
            const statusClass = $(row).find('td:eq(6) .status-badge').attr('class');
            const statusColor = statusClass && statusClass.includes('SUCCESS') ? 'success' : 
                               (statusClass && statusClass.includes('FAILED') ? 'danger' : 'warning');
            
            // Build HTML content
            let html = `
                <div class="modal-detail-row">
                    <div class="modal-detail-label">Log ID:</div>
                    <div class="modal-detail-value"><strong>${id}</strong></div>
                </div>
                <div class="modal-detail-row">
                    <div class="modal-detail-label">Timestamp:</div>
                    <div class="modal-detail-value">${timestamp}</div>
                </div>
                <div class="modal-detail-row">
                    <div class="modal-detail-label">User:</div>
                    <div class="modal-detail-value">${user}</div>
                </div>
                <div class="modal-detail-row">
                    <div class="modal-detail-label">Action:</div>
                    <div class="modal-detail-value">
                        <span class="badge-action badge-${action}">${action}</span>
                    </div>
                </div>
                <div class="modal-detail-row">
                    <div class="modal-detail-label">Description:</div>
                    <div class="modal-detail-value">${description}</div>
                </div>
                <div class="modal-detail-row">
                    <div class="modal-detail-label">IP Address:</div>
                    <div class="modal-detail-value">
                        <i class="bi bi-geo-alt"></i> ${ipAddress}
                        <a href="https://whatismyipaddress.com/ip/${ipAddress}" target="_blank" class="ms-2 small">
                            <i class="bi bi-box-arrow-up-right"></i> Lookup
                        </a>
                    </div>
                </div>
                <div class="modal-detail-row">
                    <div class="modal-detail-label">Status:</div>
                    <div class="modal-detail-value">
                        <span class="status-badge status-${status}">
                            <i class="bi bi-${status == 'SUCCESS' ? 'check-circle' : 'exclamation-circle'} me-1"></i>
                            ${status}
                        </span>
                    </div>
                </div>
            `;
            
            // Add additional info if available
            html += `
                <hr>
                <h6 class="mb-3">Additional Information</h6>
                <div class="modal-detail-row">
                    <div class="modal-detail-label">Browser Info:</div>
                    <div class="modal-detail-value">
                        <i class="bi bi-window"></i> <span id="browserInfo"></span>
                    </div>
                </div>
                <div class="modal-detail-row">
                    <div class="modal-detail-label">Request URL:</div>
                    <div class="modal-detail-value">
                        <i class="bi bi-link"></i> <span id="requestUrl"></span>
                    </div>
                </div>
            `;
            
            // Update modal content
            $('#logDetailsContent').html(html);
            
            // Set browser info (you can get from user agent if needed)
            document.getElementById('browserInfo').textContent = navigator.userAgent.split(' ').slice(0, 3).join(' ');
            document.getElementById('requestUrl').textContent = window.location.href;
            
            // Show the modal
            $('#logDetailsModal').modal('show');
        }
        
        function clearOldLogs() {
            if (confirm('Are you sure you want to clear logs older than 30 days? This action cannot be undone.')) {
                $.ajax({
                    url: contextPath + '/admin/logs',
                    type: 'POST',
                    data: {
                        action: 'clear-logs',
                        days: 30
                    },
                    success: function(response) {
                        if (response.success) {
                            alert(response.message);
                            location.reload();
                        } else {
                            alert('Failed to clear logs');
                        }
                    },
                    error: function() {
                        alert('Error clearing logs');
                    }
                });
            }
        }
    </script>
</body>
</html>