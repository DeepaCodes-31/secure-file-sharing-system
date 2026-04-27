<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Security Dashboard - Secure File Sharing</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <!-- Chart.js -->
    <script src="https://cdn.jsdelivr.net/npm/chart.js@3.9.1/dist/chart.min.js"></script>
    
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #28a745;
            --warning-color: #ffc107;
            --danger-color: #dc3545;
            --info-color: #17a2b8;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        
        .security-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .security-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .security-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .security-body {
            padding: 30px;
        }
        
        .score-card {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 20px;
            padding: 25px;
            margin-bottom: 25px;
            border-left: 4px solid var(--primary-color);
        }
        
        .score-circle {
            width: 150px;
            height: 150px;
            margin: 0 auto;
            position: relative;
        }
        
        .score-number {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            font-size: 36px;
            font-weight: 700;
        }
        
        .security-badge {
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
            display: inline-block;
        }
        
        .badge-excellent {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
        }
        
        .badge-good {
            background: linear-gradient(135deg, #17a2b8, #6c757d);
            color: white;
        }
        
        .badge-fair {
            background: linear-gradient(135deg, #ffc107, #fd7e14);
            color: white;
        }
        
        .badge-poor {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
        }
        
        .feature-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s;
            border-left: 4px solid transparent;
        }
        
        .feature-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .feature-card.enabled {
            border-left-color: var(--success-color);
        }
        
        .feature-card.disabled {
            border-left-color: var(--danger-color);
            opacity: 0.8;
        }
        
        .feature-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-shrink: 0;
        }
        
        .event-timeline {
            max-height: 400px;
            overflow-y: auto;
            padding-right: 10px;
        }
        
        .event-item {
            padding: 15px;
            border-bottom: 1px solid #e9ecef;
            transition: all 0.3s;
        }
        
        .event-item:hover {
            background: #f8f9fa;
        }
        
        .event-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
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
        
        .encryption-stats {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 20px;
            border-radius: 15px;
        }
        
        .event-timeline::-webkit-scrollbar {
            width: 6px;
        }
        
        .event-timeline::-webkit-scrollbar-track {
            background: #f1f1f1;
            border-radius: 10px;
        }
        
        .event-timeline::-webkit-scrollbar-thumb {
            background: var(--primary-color);
            border-radius: 10px;
        }
        
        .event-timeline::-webkit-scrollbar-thumb:hover {
            background: var(--secondary-color);
        }
    </style>
</head>
<body>
    <div class="security-container">
        <div class="security-card">
            <!-- Header -->
            <div class="security-header">
                <i class="fas fa-shield-alt fa-4x mb-3"></i>
                <h2 class="mb-2">Security Dashboard</h2>
                <p class="mb-0">Monitor and enhance your account security</p>
            </div>
            
            <!-- Body -->
            <div class="security-body">
                <!-- Security Score Section -->
                <div class="score-card">
                    <div class="row align-items-center">
                        <div class="col-md-4 text-center">
                            <div class="score-circle">
                                <canvas id="securityScoreChart" width="150" height="150"></canvas>
                                <div class="score-number">${securityScore}%</div>
                            </div>
                            <h5 class="mt-3">Security Score</h5>
                            
                            <!-- Security Score Badge -->
                            <c:choose>
                                <c:when test="${securityScore >= 80}">
                                    <span class="security-badge badge-excellent">Excellent</span>
                                </c:when>
                                <c:when test="${securityScore >= 60}">
                                    <span class="security-badge badge-good">Good</span>
                                </c:when>
                                <c:when test="${securityScore >= 40}">
                                    <span class="security-badge badge-fair">Fair</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="security-badge badge-poor">Needs Improvement</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <!-- Security Stats -->
                        <div class="col-md-8">
                            <div class="row">
                                <!-- Encrypted Files -->
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="bg-primary bg-opacity-10 p-3 rounded-circle me-3">
                                            <i class="fas fa-lock text-primary"></i>
                                        </div>
                                        <div>
                                            <small class="text-muted">Encrypted Files</small>
                                            <h4 class="mb-0">${encryptedFiles}/${totalFiles}</h4>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- Encryption Rate -->
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center mb-3">
                                        <div class="bg-success bg-opacity-10 p-3 rounded-circle me-3">
                                            <i class="fas fa-check-circle text-success"></i>
                                        </div>
                                        <div>
                                            <small class="text-muted">Encryption Rate</small>
                                            <h4 class="mb-0">${encryptionPercentage}%</h4>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- SHA-256 Verified -->
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-info bg-opacity-10 p-3 rounded-circle me-3">
                                            <i class="fas fa-fingerprint text-info"></i>
                                        </div>
                                        <div>
                                            <small class="text-muted">SHA-256 Verified</small>
                                            <h4 class="mb-0">100%</h4>
                                        </div>
                                    </div>
                                </div>
                                
                                <!-- AES-256 -->
                                <div class="col-md-6">
                                    <div class="d-flex align-items-center">
                                        <div class="bg-warning bg-opacity-10 p-3 rounded-circle me-3">
                                            <i class="fas fa-shield-alt text-warning"></i>
                                        </div>
                                        <div>
                                            <small class="text-muted">AES-256</small>
                                            <h4 class="mb-0">Enabled</h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                
                <!-- Security Features and Events Row -->
                <div class="row">
                    <!-- Security Features Column -->
                    <div class="col-lg-6">
                        <h5 class="mb-3"><i class="fas fa-shield-virus me-2"></i>Security Features</h5>
                        
                        <!-- Feature 1: AES-256 Encryption -->
                        <div class="feature-card enabled">
                            <div class="d-flex align-items-start">
                                <div class="feature-icon me-3">
                                    <i class="fas fa-lock fa-2x text-success"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="fw-bold mb-1">AES-256 Encryption</h6>
                                        <span class="badge bg-success">Enabled</span>
                                    </div>
                                    <p class="text-muted small mb-0">
                                        Military-grade encryption for all your files
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Feature 2: SHA-256 Integrity Verification -->
                        <div class="feature-card enabled">
                            <div class="d-flex align-items-start">
                                <div class="feature-icon me-3">
                                    <i class="fas fa-fingerprint fa-2x text-success"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="fw-bold mb-1">SHA-256 Integrity Verification</h6>
                                        <span class="badge bg-success">Enabled</span>
                                    </div>
                                    <p class="text-muted small mb-0">
                                        Verify file integrity with cryptographic hashes
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Feature 3: Secure Cloud Storage -->
                        <div class="feature-card enabled">
                            <div class="d-flex align-items-start">
                                <div class="feature-icon me-3">
                                    <i class="fab fa-google-drive fa-2x text-success"></i>
                                </div>
                                <div class="flex-grow-1">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <h6 class="fw-bold mb-1">Secure Cloud Storage</h6>
                                        <span class="badge bg-success">Connected</span>
                                    </div>
                                    <p class="text-muted small mb-0">
                                        Files encrypted before uploading to Google Drive
                                    </p>
                                </div>
                            </div>
                        </div>
                        
                        
                        
                    </div>
                    
                    <!-- Recent Security Events Column -->
                    <div class="col-lg-6">
                        <h5 class="mb-3"><i class="fas fa-clock me-2"></i>Recent Security Events</h5>
                        
                        <div class="event-timeline">
                            <c:choose>
                                <c:when test="${not empty securityEvents}">
                                    <c:forEach var="event" items="${securityEvents}">
                                        <c:set var="eventAction" value="${fn:toLowerCase(event.action)}" />
                                        <div class="event-item d-flex align-items-start">
                                            <!-- Event Icon based on action type -->
                                            <c:choose>
                                                <c:when test="${fn:contains(eventAction, 'login')}">
                                                    <div class="event-icon bg-success bg-opacity-10 text-success me-3">
                                                        <i class="fas fa-sign-in-alt"></i>
                                                    </div>
                                                </c:when>
                                                <c:when test="${fn:contains(eventAction, 'upload')}">
                                                    <div class="event-icon bg-primary bg-opacity-10 text-primary me-3">
                                                        <i class="fas fa-upload"></i>
                                                    </div>
                                                </c:when>
                                                <c:when test="${fn:contains(eventAction, 'download')}">
                                                    <div class="event-icon bg-info bg-opacity-10 text-info me-3">
                                                        <i class="fas fa-download"></i>
                                                    </div>
                                                </c:when>
                                                <c:when test="${fn:contains(eventAction, 'delete')}">
                                                    <div class="event-icon bg-danger bg-opacity-10 text-danger me-3">
                                                        <i class="fas fa-trash"></i>
                                                    </div>
                                                </c:when>
                                                <c:otherwise>
                                                    <div class="event-icon bg-warning bg-opacity-10 text-warning me-3">
                                                        <i class="fas fa-shield-alt"></i>
                                                    </div>
                                                </c:otherwise>
                                            </c:choose>
                                            
                                            <!-- Event Details -->
                                            <div class="flex-grow-1">
                                                <div class="d-flex justify-content-between align-items-start">
                                                    <div>
                                                        <p class="mb-1 fw-bold">${event.description}</p>
                                                        <small class="text-muted">
                                                            <i class="fas fa-map-marker-alt me-1"></i>${event.ipAddress}
                                                        </small>
                                                    </div>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${event.timestamp}" pattern="HH:mm:ss"/>
                                                    </small>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                
                                <%-- No Events Fallback --%>
                                <c:otherwise>
                                    <div class="text-center py-5">
                                        <i class="fas fa-shield-alt fa-3x text-muted mb-3"></i>
                                        <p class="text-muted">No security events found</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        
                    </div>
                </div>
                
                <!-- Encryption Stats Footer -->
                <div class="encryption-stats mt-4">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h5 class="mb-2">🔐 AES-256 Encryption Active</h5>
                            <p class="mb-0 opacity-75">
                                Your files are encrypted with military-grade AES-256 before upload. 
                                Each file uses a unique encryption key and initialization vector.
                            </p>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <span class="badge bg-white text-dark p-3">
                                <i class="fas fa-check-circle text-success me-2"></i>
                                ${encryptedFiles}/${totalFiles} Files Encrypted
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Back to Dashboard Link -->
        <div class="mt-4 text-center">
            <a href="${pageContext.request.contextPath}/dashboard" class="back-link">
                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
            </a>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Security Score Chart
            var ctx = document.getElementById('securityScoreChart').getContext('2d');
            var securityScore = ${securityScore != null ? securityScore : 0};
            
            new Chart(ctx, {
                type: 'doughnut',
                data: {
                    datasets: [{
                        data: [securityScore, 100 - securityScore],
                        backgroundColor: [
                            securityScore >= 80 ? '#28a745' : 
                            securityScore >= 60 ? '#17a2b8' : 
                            securityScore >= 40 ? '#ffc107' : '#dc3545',
                            '#e9ecef'
                        ],
                        borderWidth: 0
                    }]
                },
                options: {
                    cutout: '70%',
                    responsive: true,
                    maintainAspectRatio: true,
                    plugins: {
                        tooltip: { enabled: false },
                        legend: { display: false }
                    }
                }
            });
        });
    </script>
</body>
</html>