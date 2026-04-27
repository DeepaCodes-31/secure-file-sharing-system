<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Recent Files - Secure File Sharing</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- DataTables -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css">
    <!-- Moment.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    
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
        
        .recent-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .recent-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .recent-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .recent-body {
            padding: 30px;
        }
        
        .time-filter {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
        }
        
        .filter-btn {
            background: white;
            border: 2px solid #dee2e6;
            color: #6c757d;
            padding: 8px 20px;
            border-radius: 25px;
            margin: 0 5px;
            transition: all 0.3s;
        }
        
        .filter-btn:hover, .filter-btn.active {
            background: var(--primary-color);
            border-color: var(--primary-color);
            color: white;
        }
        
        /* REMOVED: The blue timeline line */
        .activity-timeline {
            /* position: relative; */  /* Commented out */
            padding-left: 30px;
            max-height: 500px;
            overflow-y: auto;
            padding-right: 10px;
        }
        
        /* REMOVED: The blue vertical line */
        /* .activity-timeline:before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            bottom: 0;
            width: 2px;
            background: linear-gradient(to bottom, var(--primary-color), var(--secondary-color));
        } */
        
        .activity-item {
            position: relative;
            margin-bottom: 25px;
            padding-left: 20px;
        }
        
        /* REMOVED: The blue dots */
        /* .activity-item:before {
            content: '';
            position: absolute;
            left: -26px;
            top: 0;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: var(--primary-color);
            border: 2px solid white;
            box-shadow: 0 0 0 2px rgba(67, 97, 238, 0.2);
        } */
        
        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
        }
        
        .file-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            border-left: 4px solid var(--primary-color);
            transition: all 0.3s;
        }
        
        .file-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
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
        
        .badge-drive {
            background: linear-gradient(135deg, #4285F4, #34A853);
            color: white;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 12px;
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
        
        .empty-state {
            text-align: center;
            padding: 60px 20px;
        }
        
        .empty-state-icon {
            font-size: 64px;
            color: #ccc;
            margin-bottom: 20px;
        }
        
        .stats-card {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 15px;
            padding: 20px;
            margin-top: 25px;
        }
    </style>
</head>
<body>
    <%-- Calculate activity count safely --%>
    <c:choose>
        <c:when test="${empty recentActivity}">
            <c:set var="activityCount" value="0" />
        </c:when>
        <c:otherwise>
            <c:set var="activityCount" value="${recentActivity.size()}" />
        </c:otherwise>
    </c:choose>

    <div class="recent-container">
        <div class="recent-card">
            <div class="recent-header">
                <i class="fas fa-history fa-4x mb-3"></i>
                <h2 class="mb-2">Recent Activity</h2>
                <p class="mb-0">Track your file uploads, downloads, and activities</p>
            </div>
            
            <div class="recent-body">
                <!-- Time Filter -->
                <div class="time-filter text-center">
                    <h6 class="mb-3"><i class="fas fa-filter me-2"></i>Filter by Time</h6>
                    <div>
                        <button class="filter-btn ${selectedPeriod == 'today' ? 'active' : ''}" onclick="filterByPeriod('today')">
                            <i class="fas fa-sun me-1"></i>Today
                        </button>
                        <button class="filter-btn ${selectedPeriod == 'week' ? 'active' : ''}" onclick="filterByPeriod('week')">
                            <i class="fas fa-calendar-week me-1"></i>This Week
                        </button>
                        <button class="filter-btn ${selectedPeriod == 'month' ? 'active' : ''}" onclick="filterByPeriod('month')">
                            <i class="fas fa-calendar-alt me-1"></i>This Month
                        </button>
                        <button class="filter-btn ${selectedPeriod == 'all' || selectedPeriod == null ? 'active' : ''}" onclick="filterByPeriod('all')">
                            <i class="fas fa-infinity me-1"></i>All Time
                        </button>
                    </div>
                </div>
                
                <div class="row">
                    <!-- Recent Files -->
                    <div class="col-lg-8">
                        <h5 class="mb-3">
                            <i class="fas fa-file-alt me-2"></i>
                            Recent Files
                            <span class="badge bg-primary ms-2">${fileCount}</span>
                        </h5>
                        
                        <c:choose>
                            <c:when test="${not empty recentFiles}">
                                <div style="max-height: 700px; overflow-y: auto; padding-right: 10px;">
                                    <c:forEach var="file" items="${recentFiles}">
                                        <c:set var="fileTypeLower" value="${fn:toLowerCase(file.fileType)}" />
                                        <div class="file-card">
                                            <div class="d-flex align-items-center">
                                                <div class="file-icon me-3 
                                                    <c:choose>
                                                        <c:when test="${fn:contains(fileTypeLower, 'pdf')}">bg-danger bg-opacity-10</c:when>
                                                        <c:when test="${fn:contains(fileTypeLower, 'doc')}">bg-primary bg-opacity-10</c:when>
                                                        <c:when test="${fn:contains(fileTypeLower, 'xls')}">bg-success bg-opacity-10</c:when>
                                                        <c:when test="${fn:contains(fileTypeLower, 'jpg') or fn:contains(fileTypeLower, 'png')}">bg-info bg-opacity-10</c:when>
                                                        <c:when test="${fn:contains(fileTypeLower, 'zip')}">bg-warning bg-opacity-10</c:when>
                                                        <c:otherwise>bg-secondary bg-opacity-10</c:otherwise>
                                                    </c:choose>">
                                                    <i class="fas 
                                                        <c:choose>
                                                            <c:when test="${fn:contains(fileTypeLower, 'pdf')}">fa-file-pdf text-danger</c:when>
                                                            <c:when test="${fn:contains(fileTypeLower, 'doc')}">fa-file-word text-primary</c:when>
                                                            <c:when test="${fn:contains(fileTypeLower, 'xls')}">fa-file-excel text-success</c:when>
                                                            <c:when test="${fn:contains(fileTypeLower, 'jpg') or fn:contains(fileTypeLower, 'png')}">fa-file-image text-info</c:when>
                                                            <c:when test="${fn:contains(fileTypeLower, 'zip')}">fa-file-archive text-warning</c:when>
                                                            <c:otherwise>fa-file text-secondary</c:otherwise>
                                                        </c:choose>"></i>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <div class="d-flex justify-content-between align-items-start">
                                                        <div>
                                                            <h6 class="mb-1 fw-bold">${file.originalFilename}</h6>
                                                            <small class="text-muted">
                                                                <i class="fas fa-clock me-1"></i>
                                                                <fmt:formatDate value="${file.uploadDate}" pattern="MMM dd, yyyy HH:mm:ss"/>
                                                            </small>
                                                        </div>
                                                        <div>
                                                            <c:if test="${file.encrypted}">
                                                                <span class="badge-encrypted me-2">
                                                                    <i class="fas fa-lock me-1"></i>AES-256
                                                                </span>
                                                            </c:if>
                                                            <span class="badge-drive">
                                                                <i class="fab fa-google-drive me-1"></i>Drive
                                                            </span>
                                                        </div>
                                                    </div>
                                                    <div class="mt-2">
                                                        <small class="text-muted">
                                                            <i class="fas fa-weight-hanging me-1"></i>
                                                            <fmt:formatNumber value="${file.fileSize / 1024}" pattern="#,##0.00"/> KB
                                                            <span class="mx-2">•</span>
                                                            <i class="fas fa-download me-1"></i>
                                                            ${file.accessCount} ${file.accessCount == 1 ? 'download' : 'downloads'}
                                                        </small>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="empty-state">
                                    <div class="empty-state-icon">
                                        <i class="fas fa-folder-open"></i>
                                    </div>
                                    <h5>No Recent Files</h5>
                                    <p class="text-muted">You haven't uploaded any files yet</p>
                                    <button class="btn btn-primary" onclick="window.location.href='${pageContext.request.contextPath}/jsp/user/upload.jsp'">
                                        <i class="fas fa-cloud-upload-alt me-2"></i>Upload Your First File
                                    </button>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    
                    <!-- Activity Timeline -->
                    <div class="col-lg-4">
                        <h5 class="mb-3">
                            <i class="fas fa-stream me-2"></i>
                            Activity Timeline
                        </h5>
                        
                        <div class="activity-timeline">
                            <c:choose>
                                <c:when test="${not empty recentActivity}">
                                    <c:forEach var="activity" items="${recentActivity}">
                                        <c:set var="actionLower" value="${fn:toLowerCase(activity.action)}" />
                                        <div class="activity-item">
                                            <div class="d-flex align-items-start">
                                                <div class="activity-icon 
                                                    <c:choose>
                                                        <c:when test="${fn:contains(actionLower, 'upload')}">bg-primary bg-opacity-10 text-primary</c:when>
                                                        <c:when test="${fn:contains(actionLower, 'download')}">bg-success bg-opacity-10 text-success</c:when>
                                                        <c:when test="${fn:contains(actionLower, 'delete')}">bg-danger bg-opacity-10 text-danger</c:when>
                                                        <c:when test="${fn:contains(actionLower, 'login')}">bg-info bg-opacity-10 text-info</c:when>
                                                        <c:when test="${fn:contains(actionLower, 'share')}">bg-warning bg-opacity-10 text-warning</c:when>
                                                        <c:otherwise>bg-secondary bg-opacity-10 text-secondary</c:otherwise>
                                                    </c:choose>
                                                    me-3">
                                                    <i class="fas 
                                                        <c:choose>
                                                            <c:when test="${fn:contains(actionLower, 'upload')}">fa-upload</c:when>
                                                            <c:when test="${fn:contains(actionLower, 'download')}">fa-download</c:when>
                                                            <c:when test="${fn:contains(actionLower, 'delete')}">fa-trash</c:when>
                                                            <c:when test="${fn:contains(actionLower, 'login')}">fa-sign-in-alt</c:when>
                                                            <c:when test="${fn:contains(actionLower, 'share')}">fa-share-alt</c:when>
                                                            <c:otherwise>fa-info-circle</c:otherwise>
                                                        </c:choose>"></i>
                                                </div>
                                                <div class="flex-grow-1">
                                                    <p class="mb-1 fw-bold small">${activity.description}</p>
                                                    <div class="d-flex flex-wrap align-items-center">
                                                        <small class="text-muted">
                                                            <i class="fas fa-clock me-1"></i>
                                                            <fmt:formatDate value="${activity.timestamp}" pattern="MMM dd, HH:mm:ss"/>
                                                        </small>
                                                        <c:if test="${not empty activity.ipAddress}">
                                                            <small class="text-muted ms-2">
                                                                <i class="fas fa-map-marker-alt me-1"></i>${activity.ipAddress}
                                                            </small>
                                                        </c:if>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center py-5">
                                        <i class="fas fa-history fa-3x text-muted mb-3"></i>
                                        <p class="text-muted">No recent activity</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- Summary Stats -->
                        <div class="stats-card">
                            <h6 class="mb-3"><i class="fas fa-chart-pie me-2"></i>Quick Stats</h6>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Total Files:</span>
                                <span class="fw-bold">${fileCount}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Encrypted Files:</span>
                                <span class="fw-bold text-success">
                                    <c:set var="encryptedCount" value="0"/>
                                    <c:forEach var="file" items="${recentFiles}">
                                        <c:if test="${file.encrypted}">
                                            <c:set var="encryptedCount" value="${encryptedCount + 1}"/>
                                        </c:if>
                                    </c:forEach>
                                    ${encryptedCount}
                                </span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span class="text-muted">Encryption Rate:</span>
                                <span class="fw-bold text-info">
                                    <c:choose>
                                        <c:when test="${fileCount > 0}">
                                            <fmt:formatNumber value="${(encryptedCount / fileCount) * 100}" pattern="#0"/>%
                                        </c:when>
                                        <c:otherwise>0%</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="d-flex justify-content-between">
                                <span class="text-muted">Last Upload:</span>
                                <span class="fw-bold">
                                    <c:if test="${not empty recentFiles}">
                                        <fmt:formatDate value="${recentFiles[0].uploadDate}" pattern="MMM dd, yyyy"/>
                                    </c:if>
                                    <c:if test="${empty recentFiles}">
                                        Never
                                    </c:if>
                                </span>
                            </div>
                        </div>
                        
                        <!-- Activity Summary -->
                        <div class="mt-3 text-center">
                            <small class="text-muted">
                                <i class="fas fa-info-circle me-1"></i>
                                Showing ${activityCount} most recent activities
                            </small>
                        </div>
                    </div>
                </div>
                
                <!-- View All Files Button -->
                <div class="text-center mt-4">
                    <a href="${pageContext.request.contextPath}/myfiles" class="btn btn-outline-primary btn-lg px-5">
                        <i class="fas fa-folder me-2"></i>View All Files
                    </a>
                </div>
            </div>
        </div>
        
        <div class="mt-4 text-center">
            <a href="${pageContext.request.contextPath}/dashboard" class="back-link">
                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
            </a>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        function filterByPeriod(period) {
            window.location.href = '${pageContext.request.contextPath}/recent?period=' + period;
        }
        
        $(document).ready(function() {
            // Initialize tooltips
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            tooltipTriggerList.map(function(tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
            
            // Auto-hide alerts after 5 seconds
            setTimeout(function() {
                $('.alert').alert('close');
            }, 5000);
        });
    </script>
</body>
</html>