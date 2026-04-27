<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Share Details - Secure File Sharing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .detail-section {
            margin-bottom: 20px;
        }
        .detail-label {
            font-weight: 600;
            color: #495057;
            font-size: 12px;
            text-transform: uppercase;
            margin-bottom: 5px;
        }
        .detail-value {
            color: #212529;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .share-link-box {
            background: #f8f9fa;
            border: 2px dashed #4361ee;
            border-radius: 8px;
            padding: 12px;
            margin: 15px 0;
            word-break: break-all;
            font-size: 12px;
        }
        .badge-permission {
            padding: 5px 10px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }
        .badge-view { background: #e3f2fd; color: #0d6efd; }
        .badge-edit { background: #fff3cd; color: #856404; }
        .badge-download { background: #d4edda; color: #155724; }
    </style>
</head>
<body>
    <c:if test="${not empty share}">
        <div class="detail-section">
            <h6 class="border-bottom pb-2 mb-3">Share Information</h6>
            <div class="detail-label">Share ID</div>
            <div class="detail-value">${share.shareId}</div>
            
            <div class="detail-label">Share Token</div>
            <div class="detail-value"><code>${share.shareToken}</code></div>
            
            <div class="detail-label">Permission</div>
            <div class="detail-value">
                <span class="badge-permission 
                    <c:choose>
                        <c:when test="${share.permission == 'VIEW'}">badge-view</c:when>
                        <c:when test="${share.permission == 'EDIT'}">badge-edit</c:when>
                        <c:when test="${share.permission == 'DOWNLOAD'}">badge-download</c:when>
                    </c:choose>">
                    ${share.permission}
                </span>
            </div>
            
            <div class="detail-label">Status</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${share.active}">
                        <span class="badge bg-success">Active</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-secondary">Revoked</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <div class="detail-section">
            <h6 class="border-bottom pb-2 mb-3">File Information</h6>
            <c:if test="${not empty file}">
                <div class="detail-label">File Name</div>
                <div class="detail-value">${file.originalFilename}</div>
                
                <div class="detail-label">File Size</div>
                <div class="detail-value">
                    <c:choose>
                        <c:when test="${file.fileSize < 1024}">${file.fileSize} B</c:when>
                        <c:when test="${file.fileSize < 1048576}"><fmt:formatNumber value="${file.fileSize / 1024}" pattern="#,##0.00"/> KB</c:when>
                        <c:otherwise><fmt:formatNumber value="${file.fileSize / 1048576}" pattern="#,##0.00"/> MB</c:otherwise>
                    </c:choose>
                </div>
                
                <div class="detail-label">Uploaded By</div>
                <div class="detail-value">${file.userId}</div>
                
                <div class="detail-label">Upload Date</div>
                <div class="detail-value"><fmt:formatDate value="${file.uploadDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
            </c:if>
        </div>
        
        <c:if test="${not empty share.recipientEmail}">
            <div class="detail-section">
                <h6 class="border-bottom pb-2 mb-3">Recipient Information</h6>
                <div class="detail-label">Email</div>
                <div class="detail-value">${share.recipientEmail}</div>
                
                <c:if test="${not empty recipient}">
                    <div class="detail-label">Username</div>
                    <div class="detail-value">${recipient.username}</div>
                    
                    <div class="detail-label">Full Name</div>
                    <div class="detail-value">${recipient.fullName}</div>
                </c:if>
            </div>
        </c:if>
        
        <c:if test="${empty share.recipientEmail}">
            <div class="detail-section">
                <h6 class="border-bottom pb-2 mb-3">Public Link</h6>
                <div class="share-link-box">
                    ${pageContext.request.contextPath}/shared?action=view&token=${share.shareToken}
                </div>
                <button class="btn btn-sm btn-outline-primary w-100" onclick="copyPublicLink()">
                    <i class="fas fa-copy me-1"></i> Copy Link
                </button>
            </div>
        </c:if>
        
        <div class="detail-section">
            <h6 class="border-bottom pb-2 mb-3">Dates & Limits</h6>
            <div class="detail-label">Created At</div>
            <div class="detail-value"><fmt:formatDate value="${share.createdAt}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
            
            <div class="detail-label">Expiry Date</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${not empty share.expiryDate}">
                        <fmt:formatDate value="${share.expiryDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </c:when>
                    <c:otherwise>No expiry</c:otherwise>
                </c:choose>
            </div>
            
            <div class="detail-label">Downloads</div>
            <div class="detail-value">${share.downloadCount} / ${share.maxDownloads > 0 ? share.maxDownloads : '∞'}</div>
            
            <div class="detail-label">Last Accessed</div>
            <div class="detail-value">
                <c:choose>
                    <c:when test="${not empty share.lastAccessed}">
                        <fmt:formatDate value="${share.lastAccessed}" pattern="yyyy-MM-dd HH:mm:ss"/>
                    </c:when>
                    <c:otherwise>Never</c:otherwise>
                </c:choose>
            </div>
        </div>
        
        <c:if test="${share.ownerId == sessionScope.user.userId}">
            <div class="mt-3">
                <c:if test="${share.active}">
                    <button class="btn btn-danger w-100" onclick="revokeFromDetails('${share.shareId}')">
                        <i class="fas fa-ban me-2"></i>Revoke Access
                    </button>
                </c:if>
            </div>
        </c:if>
    </c:if>
    
    <c:if test="${empty share}">
        <div class="text-center py-4">
            <i class="fas fa-exclamation-circle fa-3x text-warning mb-3"></i>
            <p class="text-muted">Share details not found</p>
        </div>
    </c:if>

    <script>
        function copyPublicLink() {
            var link = '${pageContext.request.contextPath}/shared?action=view&token=${share.shareToken}';
            navigator.clipboard.writeText(link).then(function() {
                alert('Link copied to clipboard!');
            });
        }
        
        function revokeFromDetails(shareId) {
            if (confirm('Are you sure you want to revoke access to this file?')) {
                $.ajax({
                    url: '${pageContext.request.contextPath}/shared',
                    type: 'POST',
                    data: {
                        action: 'revoke',
                        shareId: shareId
                    },
                    success: function(response) {
                        if (response.success) {
                            alert('Share access revoked successfully');
                            location.reload();
                        } else {
                            alert('Failed to revoke access');
                        }
                    }
                });
            }
        }
    </script>
</body>
</html>