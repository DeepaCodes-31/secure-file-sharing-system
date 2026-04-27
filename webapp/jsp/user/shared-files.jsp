<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shared Files - Secure File Sharing</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    
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
        
        .shared-container {
            max-width: 1400px;
            margin: 0 auto;
        }
        
        .shared-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .shared-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .shared-body {
            padding: 30px;
        }
        
        .nav-tabs {
            border-bottom: 2px solid #e9ecef;
            margin-bottom: 25px;
        }
        
        .nav-tabs .nav-link {
            border: none;
            color: #6c757d;
            padding: 12px 25px;
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
        
        .file-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            flex-shrink: 0;
        }
        
        .badge-encrypted {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
        }
        
        .badge-permission {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        
        .badge-view {
            background: #e3f2fd;
            color: #0d6efd;
        }
        
        .badge-edit {
            background: #fff3cd;
            color: #856404;
        }
        
        .badge-download {
            background: #d4edda;
            color: #155724;
        }
        
        .share-modal .modal-content {
            border-radius: 15px;
            border: none;
        }
        
        .share-modal .modal-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border-radius: 15px 15px 0 0;
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
        
        .back-link {
            color: white;
            text-decoration: none;
            transition: all 0.3s;
        }
        
        .back-link:hover {
            color: rgba(255,255,255,0.8);
            text-decoration: underline;
        }
        
        .share-link-box {
            background: #f8f9fa;
            border: 2px dashed var(--primary-color);
            border-radius: 10px;
            padding: 15px;
            margin: 15px 0;
            word-break: break-all;
        }
        
        .expiry-badge {
            background: #fff3cd;
            color: #856404;
            padding: 4px 10px;
            border-radius: 15px;
            font-size: 11px;
            font-weight: 600;
        }
        
        .expiry-badge.expired {
            background: #f8d7da;
            color: #721c24;
        }
        
        .table > :not(caption) > * > * {
            vertical-align: middle;
        }
        
        .form-select-sm {
            padding-top: 0.25rem;
            padding-bottom: 0.25rem;
            padding-left: 0.5rem;
            font-size: 0.875rem;
        }
        
        .download-limit-badge {
            background: #e2e3e5;
            color: #383d41;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 10px;
        }
    </style>
</head>
<body>
    <div class="shared-container">
        <div class="shared-card">
            <div class="shared-header">
                <i class="fas fa-share-alt fa-4x mb-3"></i>
                <h2 class="mb-2">Shared Files</h2>
                <p class="mb-0">Manage files shared with you and files you've shared</p>
            </div>
            
            <div class="shared-body">
                <!-- Alert Container -->
                <div id="alertContainer"></div>
                
                <!-- Tabs -->
                <ul class="nav nav-tabs" id="shareTabs" role="tablist">
                    <li class="nav-item" role="presentation">
                        <button class="nav-link active" id="shared-with-me-tab" data-bs-toggle="tab" data-bs-target="#shared-with-me" type="button" role="tab">
                            <i class="fas fa-inbox me-2"></i>Shared With Me
                            <span class="badge bg-primary ms-2">${sharedWithMeCount}</span>
                        </button>
                    </li>
                    <li class="nav-item" role="presentation">
                        <button class="nav-link" id="shared-by-me-tab" data-bs-toggle="tab" data-bs-target="#shared-by-me" type="button" role="tab">
                            <i class="fas fa-share-square me-2"></i>Shared By Me
                            <span class="badge bg-primary ms-2">${sharedByMeCount}</span>
                        </button>
                    </li>
                </ul>
                
                <!-- Tab Content -->
                <div class="tab-content">
                    <!-- Shared With Me Tab -->
                    <div class="tab-pane fade show active" id="shared-with-me" role="tabpanel">
                        <c:choose>
                            <c:when test="${not empty sharedWithMe}">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle" id="sharedWithMeTable">
                                        <thead>
                                            <tr>
                                                <th>File Name</th>
                                                <th>Owner</th>
                                                <th>Shared Date</th>
                                                <th>Permission</th>
                                                <th>Expiry</th>
                                                <th>Downloads</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="share" items="${sharedWithMe}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <c:if test="${not empty share.file}">
                                                                <div class="file-icon 
                                                                    <c:choose>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'pdf')}">bg-danger bg-opacity-10</c:when>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'doc')}">bg-primary bg-opacity-10</c:when>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'xls')}">bg-success bg-opacity-10</c:when>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'jpg') || fn:containsIgnoreCase(share.file.fileType, 'png')}">bg-info bg-opacity-10</c:when>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'zip')}">bg-warning bg-opacity-10</c:when>
                                                                        <c:otherwise>bg-secondary bg-opacity-10</c:otherwise>
                                                                    </c:choose>
                                                                    me-3">
                                                                    <i class="fas 
                                                                        <c:choose>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'pdf')}">fa-file-pdf text-danger</c:when>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'doc')}">fa-file-word text-primary</c:when>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'xls')}">fa-file-excel text-success</c:when>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'jpg') || fn:containsIgnoreCase(share.file.fileType, 'png')}">fa-file-image text-info</c:when>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'zip')}">fa-file-archive text-warning</c:when>
                                                                            <c:otherwise>fa-file text-secondary</c:otherwise>
                                                                        </c:choose>
                                                                    "></i>
                                                                </div>
                                                            </c:if>
                                                            <div>
                                                                <span class="fw-bold">${share.file.originalFilename}</span>
                                                                <c:if test="${share.file.encrypted}">
                                                                    <span class="badge-encrypted ms-2">
                                                                        <i class="fas fa-lock me-1"></i>Encrypted
                                                                    </span>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:if test="${not empty share.owner}">
                                                            <div>
                                                                <span>${share.owner.fullName != null ? share.owner.fullName : share.owner.username}</span>
                                                                <br>
                                                                <small class="text-muted">${share.owner.email}</small>
                                                            </div>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${share.createdAt}" pattern="MMM dd, yyyy"/>
                                                        <br>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${share.createdAt}" pattern="HH:mm:ss"/>
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <span class="badge-permission 
                                                            <c:choose>
                                                                <c:when test="${share.permission == 'VIEW'}">badge-view</c:when>
                                                                <c:when test="${share.permission == 'EDIT'}">badge-edit</c:when>
                                                                <c:when test="${share.permission == 'DOWNLOAD'}">badge-download</c:when>
                                                                <c:otherwise>badge-view</c:otherwise>
                                                            </c:choose>
                                                        ">
                                                            <i class="fas 
                                                                <c:choose>
                                                                    <c:when test="${share.permission == 'VIEW'}">fa-eye</c:when>
                                                                    <c:when test="${share.permission == 'EDIT'}">fa-pencil-alt</c:when>
                                                                    <c:when test="${share.permission == 'DOWNLOAD'}">fa-download</c:when>
                                                                    <c:otherwise>fa-eye</c:otherwise>
                                                                </c:choose>
                                                            "></i>
                                                            ${share.permission}
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty share.expiryDate}">
                                                                <c:set var="now" value="<%= new java.util.Date() %>" />
                                                                <c:set var="expiry" value="${share.expiryDate}" />
                                                                <c:choose>
                                                                    <c:when test="${expiry > now}">
                                                                        <span class="expiry-badge">
                                                                            <i class="fas fa-clock me-1"></i>
                                                                            <fmt:formatDate value="${share.expiryDate}" pattern="MMM dd, yyyy"/>
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="expiry-badge expired">
                                                                            <i class="fas fa-exclamation-circle me-1"></i>Expired
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">No expiry</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <span class="fw-bold">${share.downloadCount}</span>
                                                            <c:if test="${share.maxDownloads > 0}">
                                                                <span class="download-limit-badge ms-1">
                                                                    / ${share.maxDownloads}
                                                                </span>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <button type="button" class="btn btn-sm btn-outline-primary" 
                                                                    onclick="downloadSharedFile(${share.fileId}, '${share.permission}')"
                                                                    ${share.permission == 'VIEW' || share.permission == 'DOWNLOAD' || share.permission == 'EDIT' ? '' : 'disabled'}>
                                                                <i class="fas fa-download"></i>
                                                            </button>
                                                            <button type="button" class="btn btn-sm btn-outline-info" 
                                                                    onclick="viewShareDetails('${share.shareId}')">
                                                                <i class="fas fa-info-circle"></i>
                                                            </button>
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
                                        <i class="fas fa-inbox"></i>
                                    </div>
                                    <h5>No files shared with you</h5>
                                    <p class="text-muted">When someone shares a file with you, it will appear here</p>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Shared By Me Tab -->
                    <div class="tab-pane fade" id="shared-by-me" role="tabpanel">
                        <div class="d-flex justify-content-end mb-3">
                            <button class="btn btn-primary" onclick="openShareModal()">
                                <i class="fas fa-plus-circle me-2"></i>Share New File
                            </button>
                        </div>
                        
                        <c:choose>
                            <c:when test="${not empty sharedByMe}">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle" id="sharedByMeTable">
                                        <thead>
                                            <tr>
                                                <th>File Name</th>
                                                <th>Shared With</th>
                                                <th>Share Date</th>
                                                <th>Permission</th>
                                                <th>Expiry</th>
                                                <th>Downloads</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="share" items="${sharedByMe}">
                                                <tr>
                                                    <td>
                                                        <div class="d-flex align-items-center">
                                                            <c:if test="${not empty share.file}">
                                                                <div class="file-icon 
                                                                    <c:choose>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'pdf')}">bg-danger bg-opacity-10</c:when>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'doc')}">bg-primary bg-opacity-10</c:when>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'xls')}">bg-success bg-opacity-10</c:when>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'jpg') || fn:containsIgnoreCase(share.file.fileType, 'png')}">bg-info bg-opacity-10</c:when>
                                                                        <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'zip')}">bg-warning bg-opacity-10</c:when>
                                                                        <c:otherwise>bg-secondary bg-opacity-10</c:otherwise>
                                                                    </c:choose>
                                                                    me-3">
                                                                    <i class="fas 
                                                                        <c:choose>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'pdf')}">fa-file-pdf text-danger</c:when>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'doc')}">fa-file-word text-primary</c:when>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'xls')}">fa-file-excel text-success</c:when>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'jpg') || fn:containsIgnoreCase(share.file.fileType, 'png')}">fa-file-image text-info</c:when>
                                                                            <c:when test="${fn:containsIgnoreCase(share.file.fileType, 'zip')}">fa-file-archive text-warning</c:when>
                                                                            <c:otherwise>fa-file text-secondary</c:otherwise>
                                                                        </c:choose>
                                                                    "></i>
                                                                </div>
                                                            </c:if>
                                                            <div>
                                                                <span class="fw-bold">${share.file.originalFilename}</span>
                                                                <c:if test="${share.file.encrypted}">
                                                                    <span class="badge-encrypted ms-2">
                                                                        <i class="fas fa-lock me-1"></i>Encrypted
                                                                    </span>
                                                                </c:if>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${empty share.recipientEmail}">
                                                                <span class="badge bg-secondary">
                                                                    <i class="fas fa-link me-1"></i>Public Link
                                                                </span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <c:if test="${not empty share.recipient}">
                                                                    <div>
                                                                        <span>${share.recipient.fullName != null ? share.recipient.fullName : share.recipient.username}</span>
                                                                        <br>
                                                                        <small class="text-muted">${share.recipient.email}</small>
                                                                    </div>
                                                                </c:if>
                                                                <c:if test="${empty share.recipient}">
                                                                    <div>
                                                                        <span>${share.recipientEmail}</span>
                                                                        <br>
                                                                        <small class="text-muted">Pending registration</small>
                                                                    </div>
                                                                </c:if>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${share.createdAt}" pattern="MMM dd, yyyy"/>
                                                        <br>
                                                        <small class="text-muted">
                                                            <fmt:formatDate value="${share.createdAt}" pattern="HH:mm:ss"/>
                                                        </small>
                                                    </td>
                                                    <td>
                                                        <select class="form-select form-select-sm" style="width: auto;" 
                                                                onchange="updatePermission('${share.shareId}', this.value)" ${not share.active ? 'disabled' : ''}>
                                                            <option value="VIEW" ${share.permission == 'VIEW' ? 'selected' : ''}>View</option>
                                                            <option value="DOWNLOAD" ${share.permission == 'DOWNLOAD' ? 'selected' : ''}>Download</option>
                                                            <option value="EDIT" ${share.permission == 'EDIT' ? 'selected' : ''}>Edit</option>
                                                        </select>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty share.expiryDate}">
                                                                <c:set var="now" value="<%= new java.util.Date() %>" />
                                                                <c:set var="expiry" value="${share.expiryDate}" />
                                                                <c:choose>
                                                                    <c:when test="${expiry > now && share.active}">
                                                                        <span class="expiry-badge">
                                                                            <i class="fas fa-clock me-1"></i>
                                                                            <fmt:formatDate value="${share.expiryDate}" pattern="MMM dd, yyyy"/>
                                                                        </span>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <span class="expiry-badge expired">
                                                                            <i class="fas fa-exclamation-circle me-1"></i>Expired
                                                                        </span>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">No expiry</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div>
                                                            <span class="fw-bold">${share.downloadCount}</span>
                                                            <c:if test="${share.maxDownloads > 0}">
                                                                <span class="download-limit-badge ms-1">
                                                                    / ${share.maxDownloads}
                                                                </span>
                                                            </c:if>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${share.active}">
                                                                <span class="badge bg-success">Active</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-secondary">Revoked</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <div class="btn-group" role="group">
                                                            <c:if test="${empty share.recipientEmail}">
                                                                <button type="button" class="btn btn-sm btn-outline-info" 
                                                                        onclick="copyShareLink('${pageContext.request.contextPath}/shared?action=view&token=${share.shareToken}')">
                                                                    <i class="fas fa-link"></i>
                                                                </button>
                                                            </c:if>
                                                            <button type="button" class="btn btn-sm btn-outline-danger" 
                                                                    onclick="revokeShare('${share.shareId}')" ${not share.active ? 'disabled' : ''}>
                                                                <i class="fas fa-ban"></i>
                                                            </button>
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
                                        <i class="fas fa-share-alt"></i>
                                    </div>
                                    <h5>No files shared yet</h5>
                                    <p class="text-muted">Share your files with others securely</p>
                                    <button class="btn btn-primary" onclick="openShareModal()">
                                        <i class="fas fa-plus-circle me-2"></i>Share Your First File
                                    </button>
                                </div>
                            </c:otherwise>
                        </c:choose>
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
    
    <!-- Share File Modal -->
    <div class="modal fade share-modal" id="shareModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-share-alt me-2"></i>Share File</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <form id="shareForm">
                        <div class="mb-3">
                            <label class="form-label fw-bold">Select File</label>
                            <select class="form-select" id="fileId" required>
                                <option value="">-- Choose a file to share --</option>
                                <c:forEach var="file" items="${userFiles}">
                                    <option value="${file.fileId}">${file.originalFilename}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Share Type</label>
                            <div class="btn-group w-100" role="group">
                                <input type="radio" class="btn-check" name="shareType" id="shareWithUser" value="user" checked>
                                <label class="btn btn-outline-primary" for="shareWithUser">
                                    <i class="fas fa-user me-2"></i>Share with User
                                </label>
                                
                                <input type="radio" class="btn-check" name="shareType" id="sharePublicLink" value="link">
                                <label class="btn btn-outline-primary" for="sharePublicLink">
                                    <i class="fas fa-link me-2"></i>Generate Public Link
                                </label>
                            </div>
                        </div>
                        
                        <div id="userShareSection">
                            <div class="mb-3">
                                <label class="form-label fw-bold">Recipient Email</label>
                                <input type="email" class="form-control" id="recipientEmail" 
                                       placeholder="Enter user's email address" required>
                                <small class="text-muted">The user must be registered in the system</small>
                            </div>
                        </div>
                        
                        <div id="linkShareSection" style="display: none;">
                            <div class="alert alert-info">
                                <i class="fas fa-info-circle me-2"></i>
                                A public shareable link will be generated. Anyone with the link can access the file.
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Permission</label>
                            <select class="form-select" id="permission">
                                <option value="VIEW">View Only - Can view and download</option>
                                <option value="DOWNLOAD">Download - Can download only</option>
                                <option value="EDIT">Edit - Can view, download and modify</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label class="form-label fw-bold">Expiry Date (Optional)</label>
                            <input type="date" class="form-control" id="expiryDate" 
                                   min="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>">
                            <small class="text-muted">Leave blank for no expiry</small>
                        </div>
                        
                        <div class="mb-3 form-check" id="emailNotificationSection">
                            <input type="checkbox" class="form-check-input" id="sendEmail" checked>
                            <label class="form-check-label" for="sendEmail">
                                Send email notification to recipient
                            </label>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-primary" onclick="submitShare()" id="shareBtn">
                        <i class="fas fa-share me-2"></i>Share File
                    </button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Share Link Modal -->
    <div class="modal fade share-modal" id="shareLinkModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-link me-2"></i>Shareable Link</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="text-center mb-4">
                        <i class="fas fa-check-circle fa-4x text-success"></i>
                        <h5 class="mt-3">Link Generated Successfully!</h5>
                    </div>
                    
                    <label class="form-label fw-bold">Share this link:</label>
                    <div class="share-link-box" id="shareLinkBox"></div>
                    
                    <div class="alert alert-warning mt-3">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        <strong>Anyone with this link can access the file.</strong> Share it securely.
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" onclick="copyShareLinkFromModal()">
                        <i class="fas fa-copy me-2"></i>Copy Link
                    </button>
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Done</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Share Details Modal -->
    <div class="modal fade share-modal" id="shareDetailsModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title"><i class="fas fa-info-circle me-2"></i>Share Details</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body p-4" id="shareDetailsContent">
                    <!-- Loaded via AJAX -->
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        var contextPath = '<%= request.getContextPath() %>';
        
        $(document).ready(function() {
            // Initialize DataTables
            if ($.fn.DataTable.isDataTable('#sharedWithMeTable')) {
                $('#sharedWithMeTable').DataTable().destroy();
            }
            if ($.fn.DataTable.isDataTable('#sharedByMeTable')) {
                $('#sharedByMeTable').DataTable().destroy();
            }
            
            $('#sharedWithMeTable, #sharedByMeTable').DataTable({
                pageLength: 10,
                order: [[2, 'desc']],
                language: {
                    emptyTable: "No files found",
                    info: "Showing _START_ to _END_ of _TOTAL_ files",
                    infoEmpty: "Showing 0 to 0 of 0 files",
                    search: "Search:",
                    paginate: {
                        first: "First",
                        last: "Last",
                        next: "Next",
                        previous: "Previous"
                    }
                }
            });
            
            // Toggle share type sections
            $('input[name="shareType"]').change(function() {
                if ($(this).val() === 'user') {
                    $('#userShareSection').show();
                    $('#linkShareSection').hide();
                    $('#emailNotificationSection').show();
                    $('#shareBtn').html('<i class="fas fa-share me-2"></i>Share File');
                    
                    // Make recipient email required
                    $('#recipientEmail').prop('required', true);
                } else {
                    $('#userShareSection').hide();
                    $('#linkShareSection').show();
                    $('#emailNotificationSection').hide();
                    $('#shareBtn').html('<i class="fas fa-link me-2"></i>Generate Link');
                    
                    // Remove required from recipient email
                    $('#recipientEmail').prop('required', false);
                }
            });
        });
        
        function openShareModal() {
            $('#shareModal').modal('show');
        }
        
        function submitShare() {
            var fileId = $('#fileId').val();
            var shareType = $('input[name="shareType"]:checked').val();
            var permission = $('#permission').val();
            var expiryDate = $('#expiryDate').val();
            
            if (!fileId) {
                alert('Please select a file to share');
                return;
            }
            
            $('#shareBtn').prop('disabled', true);
            $('#shareBtn').html('<i class="fas fa-spinner fa-spin me-2"></i>Processing...');
            
            if (shareType === 'user') {
                var recipientEmail = $('#recipientEmail').val();
                var sendEmail = $('#sendEmail').is(':checked');
                
                if (!recipientEmail) {
                    alert('Please enter recipient email');
                    $('#shareBtn').prop('disabled', false);
                    $('#shareBtn').html('<i class="fas fa-share me-2"></i>Share File');
                    return;
                }
                
                $.ajax({
                    url: contextPath + '/shared',
                    type: 'POST',
                    data: {
                        action: 'share',
                        fileId: fileId,
                        recipientEmail: recipientEmail,
                        permission: permission,
                        expiryDate: expiryDate,
                        sendEmail: sendEmail
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            showAlert('success', response.message);
                            $('#shareModal').modal('hide');
                            setTimeout(function() {
                                location.reload();
                            }, 1500);
                        } else {
                            showAlert('danger', response.message);
                            $('#shareBtn').prop('disabled', false);
                            $('#shareBtn').html('<i class="fas fa-share me-2"></i>Share File');
                        }
                    },
                    error: function(xhr) {
                        showAlert('danger', 'Error sharing file');
                        $('#shareBtn').prop('disabled', false);
                        $('#shareBtn').html('<i class="fas fa-share me-2"></i>Share File');
                    }
                });
            } else {
                $.ajax({
                    url: contextPath + '/shared',
                    type: 'POST',
                    data: {
                        action: 'generate-link',
                        fileId: fileId,
                        permission: permission,
                        expiryDate: expiryDate
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            $('#shareLinkBox').text(response.shareLink);
                            $('#shareModal').modal('hide');
                            $('#shareLinkModal').modal('show');
                        } else {
                            showAlert('danger', response.message);
                        }
                        $('#shareBtn').prop('disabled', false);
                        $('#shareBtn').html('<i class="fas fa-link me-2"></i>Generate Link');
                    },
                    error: function(xhr) {
                        showAlert('danger', 'Error generating link');
                        $('#shareBtn').prop('disabled', false);
                        $('#shareBtn').html('<i class="fas fa-link me-2"></i>Generate Link');
                    }
                });
            }
        }
        
        function updatePermission(shareId, permission) {
            $.ajax({
                url: contextPath + '/shared',
                type: 'POST',
                data: {
                    action: 'update-permissions',
                    shareId: shareId,
                    permission: permission
                },
                dataType: 'json',
                success: function(response) {
                    if (response.success) {
                        showAlert('success', 'Permissions updated successfully');
                    } else {
                        showAlert('danger', response.message);
                    }
                },
                error: function() {
                    showAlert('danger', 'Error updating permissions');
                }
            });
        }
        
        function revokeShare(shareId) {
            if (confirm('Are you sure you want to revoke access to this file?')) {
                $.ajax({
                    url: contextPath + '/shared',
                    type: 'POST',
                    data: {
                        action: 'revoke',
                        shareId: shareId
                    },
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            showAlert('success', 'Share access revoked successfully');
                            setTimeout(function() {
                                location.reload();
                            }, 1500);
                        } else {
                            showAlert('danger', response.message);
                        }
                    },
                    error: function() {
                        showAlert('danger', 'Error revoking access');
                    }
                });
            }
        }
        
        function copyShareLink(link) {
            navigator.clipboard.writeText(link).then(function() {
                showAlert('success', 'Share link copied to clipboard!');
            }).catch(function() {
                showAlert('danger', 'Failed to copy link');
            });
        }
        
        function copyShareLinkFromModal() {
            var link = $('#shareLinkBox').text();
            navigator.clipboard.writeText(link).then(function() {
                showAlert('success', 'Share link copied to clipboard!');
            }).catch(function() {
                showAlert('danger', 'Failed to copy link');
            });
        }
        
        function downloadSharedFile(fileId, permission) {
            if (permission === 'VIEW' || permission === 'EDIT' || permission === 'DOWNLOAD') {
                window.location.href = contextPath + '/download?fileId=' + fileId;
            } else {
                showAlert('warning', 'You do not have permission to download this file');
            }
        }
        
        function viewShareDetails(shareId) {
            $.ajax({
                url: contextPath + '/shared',
                type: 'GET',
                data: {
                    action: 'share-details',
                    shareId: shareId
                },
                success: function(response) {
                    $('#shareDetailsContent').html(response);
                    $('#shareDetailsModal').modal('show');
                },
                error: function() {
                    showAlert('danger', 'Error loading share details');
                }
            });
        }
        
        function showAlert(type, message) {
            var alertHtml = '<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
                '<i class="fas fa-' + (type === 'success' ? 'check-circle' : 'exclamation-circle') + ' me-2"></i>' +
                message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
                '</div>';
            
            $('#alertContainer').html(alertHtml);
            
            setTimeout(function() {
                $('.alert').fadeOut(300, function() {
                    $(this).remove();
                });
            }, 5000);
        }
    </script>
</body>
</html>