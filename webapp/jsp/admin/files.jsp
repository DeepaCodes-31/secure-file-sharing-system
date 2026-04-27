<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>File Management - Admin Panel</title>
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
        
        .table thead {
            background-color: #e9ecef;
        }
        
        .file-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        
        .file-pdf { background-color: #ffebee; color: #f44336; }
        .file-doc { background-color: #e3f2fd; color: #2196f3; }
        .file-excel { background-color: #e8f5e9; color: #4caf50; }
        .file-image { background-color: #f3e5f5; color: #9c27b0; }
        .file-zip { background-color: #fff3e0; color: #ff9800; }
        .file-default { background-color: #e0e0e0; color: #616161; }
        
        .badge-encrypted {
            background-color: #6f42c1;
            color: white;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 11px;
        }
        
        .badge-sensitive {
            background-color: #dc3545;
            color: white;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 11px;
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
                            <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="bi bi-people"></i> Users
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/files">
                                <i class="bi bi-files"></i> Files
                                <span class="badge bg-primary float-end mt-1">${fn:length(files)}</span>
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
                            <h2><i class="bi bi-files me-2 text-primary"></i>File Management</h2>
                            <p class="text-muted">View and manage all files in the system</p>
                        </div>
                        <div>
                            <span class="badge bg-primary p-3">
                                <i class="bi bi-files me-1"></i> Total Files: ${fn:length(files)}
                            </span>
                        </div>
                    </div>

                    <%-- Files Table --%>
                    <c:choose>
                        <c:when test="${not empty files}">
                            <div class="table-responsive">
                                <table class="table table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th>ID</th>
                                            <th>File</th>
                                            <th>Owner</th>
                                            <th>Size</th>
                                            <th>Type</th>
                                            <th>Uploaded</th>
                                            <th>Security</th>
                                            <th>Shares</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="file" items="${files}">
                                            <tr>
                                                <td><strong>#${file.fileId}</strong></td>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <%-- File Icon based on type --%>
                                                        <div class="file-icon me-2 
                                                            <c:choose>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'pdf')}">file-pdf</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'doc')}">file-doc</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'xls')}">file-excel</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'jpg') || fn:containsIgnoreCase(file.fileType, 'png')}">file-image</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'zip')}">file-zip</c:when>
                                                                <c:otherwise>file-default</c:otherwise>
                                                            </c:choose>
                                                        ">
                                                            <i class="fas 
                                                                <c:choose>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'pdf')}">fa-file-pdf</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'doc')}">fa-file-word</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'xls')}">fa-file-excel</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'jpg') || fn:containsIgnoreCase(file.fileType, 'png')}">fa-file-image</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'zip')}">fa-file-archive</c:when>
                                                                    <c:otherwise>fa-file</c:otherwise>
                                                                </c:choose>
                                                            "></i>
                                                        </div>
                                                        <div>
                                                            <strong>${file.originalFilename}</strong>
                                                            <c:if test="${not empty file.description}">
                                                                <br>
                                                                <small class="text-muted">${file.description}</small>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${not empty fileOwners[file.fileId]}">
                                                            <strong>${fileOwners[file.fileId]}</strong>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">User ID: ${file.userId}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${file.fileSize < 1024}">
                                                            ${file.fileSize} B
                                                        </c:when>
                                                        <c:when test="${file.fileSize < 1048576}">
                                                            <fmt:formatNumber value="${file.fileSize / 1024}" pattern="#,##0.00"/> KB
                                                        </c:when>
                                                        <c:otherwise>
                                                            <fmt:formatNumber value="${file.fileSize / 1048576}" pattern="#,##0.00"/> MB
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <span class="badge bg-secondary">${file.fileType}</span>
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${file.uploadDate}" pattern="yyyy-MM-dd"/>
                                                    <br>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${file.uploadDate}" pattern="HH:mm:ss"/>
                                                    </small>
                                                </td>
                                                <td>
                                                    <c:if test="${file.encrypted}">
                                                        <span class="badge-encrypted me-1">
                                                            <i class="bi bi-lock-fill"></i> Encrypted
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${file.sensitive}">
                                                        <span class="badge-sensitive">
                                                            <i class="bi bi-exclamation-triangle-fill"></i> Sensitive
                                                        </span>
                                                    </c:if>
                                                    <c:if test="${!file.encrypted && !file.sensitive}">
                                                        <span class="badge bg-secondary">Standard</span>
                                                    </c:if>
                                                </td>
                                                <td>
                                                    <span class="badge bg-info text-white">
                                                        ${fileShares[file.fileId] != null ? fileShares[file.fileId] : 0}
                                                    </span>
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <%-- Removed download button --%>
                                                        <button class="btn btn-sm btn-outline-danger action-btn" 
                                                                onclick="deleteFile(${file.fileId}, '${file.originalFilename}')"
                                                                title="Delete File">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                        <a href="${pageContext.request.contextPath}/admin/files/${file.fileId}" 
                                                           class="btn btn-sm btn-outline-info action-btn"
                                                           title="View Details">
                                                            <i class="bi bi-info-circle"></i>
                                                        </a>
                                                    </div>
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
                                    <i class="bi bi-files"></i>
                                </div>
                                <h4 class="text-muted">No Files Found</h4>
                                <p class="text-muted">There are no files in the system yet.</p>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <%-- Summary Cards --%>
                    <div class="row mt-4">
                        <div class="col-md-3">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <h3 class="text-primary">${fn:length(files)}</h3>
                                    <p class="text-muted mb-0">Total Files</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <c:set var="encryptedCount" value="0"/>
                                    <c:forEach var="file" items="${files}">
                                        <c:if test="${file.encrypted}">
                                            <c:set var="encryptedCount" value="${encryptedCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <h3 class="text-success">${encryptedCount}</h3>
                                    <p class="text-muted mb-0">Encrypted</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <c:set var="sensitiveCount" value="0"/>
                                    <c:forEach var="file" items="${files}">
                                        <c:if test="${file.sensitive}">
                                            <c:set var="sensitiveCount" value="${sensitiveCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <h3 class="text-warning">${sensitiveCount}</h3>
                                    <p class="text-muted mb-0">Sensitive</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-light">
                                <div class="card-body text-center">
                                    <c:set var="totalShares" value="0"/>
                                    <c:forEach var="shareCount" items="${fileShares}">
                                        <c:set var="totalShares" value="${totalShares + shareCount.value}"/>
                                    </c:forEach>
                                    <h3 class="text-info">${totalShares}</h3>
                                    <p class="text-muted mb-0">Total Shares</p>
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
        
        function deleteFile(fileId, filename) {
            if (confirm('⚠️ Are you sure you want to delete "' + filename + '"? This action cannot be undone.')) {
                $.ajax({
                    url: contextPath + '/admin/files',
                    type: 'POST',
                    data: {
                        action: 'delete-file',
                        fileId: fileId
                    },
                    success: function(response) {
                        if (response.success) {
                            alert('File deleted successfully');
                            location.reload();
                        } else {
                            alert('Failed to delete file');
                        }
                    },
                    error: function() {
                        alert('Error deleting file');
                    }
                });
            }
        }
    </script>
</body>
</html>