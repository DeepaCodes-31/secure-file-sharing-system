<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>File Details - Admin Panel</title>
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
        
        .detail-card {
            border: 1px solid #dee2e6;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
        }
        
        .detail-label {
            font-weight: 600;
            color: #495057;
            margin-bottom: 5px;
        }
        
        .detail-value {
            color: #212529;
            margin-bottom: 15px;
        }
        
        .file-preview-icon {
            width: 80px;
            height: 80px;
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 40px;
        }
        
        .file-pdf { background-color: #ffebee; color: #f44336; }
        .file-doc { background-color: #e3f2fd; color: #2196f3; }
        .file-excel { background-color: #e8f5e9; color: #4caf50; }
        .file-image { background-color: #f3e5f5; color: #9c27b0; }
        .file-zip { background-color: #fff3e0; color: #ff9800; }
        .file-default { background-color: #e0e0e0; color: #616161; }
        
        .back-link {
            margin-top: 20px;
        }
        
        .footer {
            background-color: #343a40 !important;
            color: white;
            padding: 1rem 0;
            margin-top: 2rem;
        }
        
        .hash-value {
            font-family: monospace;
            font-size: 12px;
            word-break: break-all;
            background-color: #f8f9fa;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #dee2e6;
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
                    <%-- Page Header with Back Button --%>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <div>
                            <h2><i class="bi bi-info-circle me-2 text-primary"></i>File Details</h2>
                            <p class="text-muted">Detailed information about the selected file</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/files" class="btn btn-outline-secondary">
                            <i class="bi bi-arrow-left me-1"></i> Back to Files
                        </a>
                    </div>

                    <c:choose>
                        <c:when test="${not empty file}">
                            <%-- File Header with Icon --%>
                            <div class="row mb-4">
                                <div class="col-12">
                                    <div class="detail-card d-flex align-items-center">
                                        <div class="file-preview-icon me-4 
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
                                            <h3 class="mb-1">${file.originalFilename}</h3>
                                            <p class="text-muted mb-0">
                                                <i class="bi bi-person-circle me-1"></i> Owner: ${owner != null ? owner : 'Unknown'}
                                                <span class="mx-2">|</span>
                                                <i class="bi bi-shield-lock me-1"></i> 
                                                <c:choose>
                                                    <c:when test="${file.encrypted}">Encrypted</c:when>
                                                    <c:otherwise>Not Encrypted</c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- File Details Grid --%>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="detail-card">
                                        <h5 class="mb-3"><i class="bi bi-info-circle me-2"></i>Basic Information</h5>
                                        
                                        <div class="detail-label">File ID</div>
                                        <div class="detail-value">#${file.fileId}</div>
                                        
                                        <div class="detail-label">File Name</div>
                                        <div class="detail-value">${file.originalFilename}</div>
                                        
                                        <div class="detail-label">Stored As</div>
                                        <div class="detail-value">${file.storedFilename}</div>
                                        
                                        <div class="detail-label">File Type</div>
                                        <div class="detail-value">
                                            <span class="badge bg-secondary">${file.fileType}</span>
                                        </div>
                                        
                                        <div class="detail-label">File Size</div>
                                        <div class="detail-value">
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
                                        </div>
                                        
                                        <div class="detail-label">Description</div>
                                        <div class="detail-value">
                                            <c:choose>
                                                <c:when test="${not empty file.description}">
                                                    ${file.description}
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="text-muted">No description provided</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="col-md-6">
                                    <div class="detail-card">
                                        <h5 class="mb-3"><i class="bi bi-calendar me-2"></i>Upload Information</h5>
                                        
                                        <div class="detail-label">Upload Date</div>
                                        <div class="detail-value">
                                            <fmt:formatDate value="${file.uploadDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                                        </div>
                                        
                                        <div class="detail-label">Uploaded By</div>
                                        <div class="detail-value">
                                            <strong>${owner != null ? owner : 'Unknown'}</strong>
                                            <br>
                                            <small class="text-muted">User ID: ${file.userId}</small>
                                        </div>
                                        
                                        <div class="detail-label">Access Count</div>
                                        <div class="detail-value">
                                            <span class="badge bg-info text-white">${file.accessCount} downloads</span>
                                        </div>
                                        
                                        <div class="detail-label">Cloud Storage</div>
                                        <div class="detail-value">
                                            <c:choose>
                                                <c:when test="${not empty file.cloudFileId}">
                                                    <span class="badge bg-success">Google Drive</span>
                                                    <br>
                                                    <small class="text-muted">ID: ${file.cloudFileId}</small>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">Local Storage</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- Security Information --%>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <div class="detail-card">
                                        <h5 class="mb-3"><i class="bi bi-shield-lock me-2"></i>Security Information</h5>
                                        
                                        <div class="row">
                                            <div class="col-md-6">
                                                <div class="detail-label">Encryption Status</div>
                                                <div class="detail-value">
                                                    <c:choose>
                                                        <c:when test="${file.encrypted}">
                                                            <span class="badge badge-encrypted bg-primary">AES-256 Encrypted</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">Not Encrypted</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                            <div class="col-md-6">
                                                <div class="detail-label">Sensitive Status</div>
                                                <div class="detail-value">
                                                    <c:choose>
                                                        <c:when test="${file.sensitive}">
                                                            <span class="badge badge-sensitive bg-danger">Sensitive Content</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">Standard</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="row mt-3">
                                            <div class="col-12">
                                                <div class="detail-label">File Hash (SHA-256)</div>
                                                <div class="hash-value">
                                                    <c:choose>
                                                        <c:when test="${not empty file.fileHash}">
                                                            ${file.fileHash}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Not available</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="row mt-3">
                                            <div class="col-12">
                                                <div class="detail-label">Encrypted File Hash (SHA-256)</div>
                                                <div class="hash-value">
                                                    <c:choose>
                                                        <c:when test="${not empty file.processedHash}">
                                                            ${file.processedHash}
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="text-muted">Not available</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <%-- Sharing Information --%>
                            <div class="row mt-3">
                                <div class="col-12">
                                    <div class="detail-card">
                                        <h5 class="mb-3"><i class="bi bi-share me-2"></i>Sharing Information</h5>
                                        
                                        <div class="detail-label">Total Shares</div>
                                        <div class="detail-value">
                                            <span class="badge bg-info text-white">${shareCount} active shares</span>
                                        </div>
                                        
                                        <c:if test="${shareCount > 0}">
                                            <div class="mt-2">
                                                <a href="${pageContext.request.contextPath}/admin/shares?fileId=${file.fileId}" class="btn btn-sm btn-outline-info">
                                                    <i class="bi bi-eye me-1"></i> View Share Details
                                                </a>
                                            </div>
                                        </c:if>
                                    </div>
                                </div>
                            </div>

                            <%-- Actions --%>
                            <div class="row mt-4">
                                <div class="col-12">
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="${pageContext.request.contextPath}/admin/files" class="btn btn-secondary">
                                            <i class="bi bi-arrow-left me-1"></i> Back to Files
                                        </a>
                                        <button class="btn btn-danger" onclick="deleteFile(${file.fileId}, '${file.originalFilename}')">
                                            <i class="bi bi-trash me-1"></i> Delete File
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="empty-state text-center py-5">
                                <i class="bi bi-exclamation-triangle fa-3x text-warning mb-3"></i>
                                <h4 class="text-muted">File Not Found</h4>
                                <p class="text-muted">The requested file could not be found.</p>
                                <a href="${pageContext.request.contextPath}/admin/files" class="btn btn-primary mt-3">
                                    <i class="bi bi-arrow-left me-1"></i> Back to Files
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
                            window.location.href = contextPath + '/admin/files';
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