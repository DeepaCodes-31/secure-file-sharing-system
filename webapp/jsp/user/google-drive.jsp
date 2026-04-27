<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Google Drive - Secure File Sharing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --google-blue: #4285F4;
            --google-green: #34A853;
            --google-yellow: #FBBC05;
            --google-red: #EA4335;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        
        .drive-container {
            max-width: 800px;
            margin: 0 auto;
        }
        
        .drive-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .drive-header {
            background: linear-gradient(135deg, var(--google-blue), #3367D6);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .drive-body {
            padding: 30px;
        }
        
        .status-card {
            background: linear-gradient(135deg, #f8f9fa, #e9ecef);
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            border-left: 4px solid var(--google-blue);
        }
        
        .storage-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            margin-bottom: 25px;
            border: 1px solid #dee2e6;
        }
        
        .progress {
            height: 10px;
            border-radius: 5px;
            margin: 15px 0;
        }
        
        .progress-bar {
            background: linear-gradient(90deg, var(--google-blue), var(--google-green));
        }
        
        .feature-card {
            background: #f8f9fa;
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            transition: all 0.3s;
        }
        
        .feature-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .feature-icon {
            width: 50px;
            height: 50px;
            background: white;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--google-blue);
            font-size: 24px;
            margin-bottom: 15px;
        }
        
        .btn-drive {
            background: linear-gradient(135deg, var(--google-blue), #3367D6);
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 10px;
            transition: all 0.3s;
        }
        
        .btn-drive:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(66, 133, 244, 0.3);
            color: white;
        }
        
        .btn-drive-outline {
            background: white;
            border: 2px solid var(--google-blue);
            color: var(--google-blue);
            padding: 10px 20px;
            border-radius: 10px;
            transition: all 0.3s;
        }
        
        .btn-drive-outline:hover {
            background: var(--google-blue);
            color: white;
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
        
        .badge-connected {
            background: linear-gradient(135deg, var(--google-green), #2c974b);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
        }
        
        .badge-disconnected {
            background: linear-gradient(135deg, #dc3545, #c82333);
            color: white;
            padding: 8px 16px;
            border-radius: 20px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="drive-container">
        <div class="drive-card">
            <div class="drive-header">
                <i class="fab fa-google-drive fa-4x mb-3"></i>
                <h2 class="mb-2">Google Drive Integration</h2>
                <p class="mb-0">Secure cloud storage for your encrypted files</p>
            </div>
            
            <div class="drive-body">
                <!-- Connection Status -->
                <div class="status-card d-flex align-items-center">
                    <div class="flex-grow-1">
                        <h5 class="mb-2">Connection Status</h5>
                        <c:choose>
                            <c:when test="${isAvailable}">
                                <span class="badge-connected">
                                    <i class="fas fa-check-circle me-1"></i>Connected
                                </span>
                                <p class="text-success mt-2 mb-0">
                                    <i class="fas fa-user-circle me-1"></i>
                                    Connected as: ds860645@gmail.com
                                </p>
                            </c:when>
                            <c:otherwise>
                                <span class="badge-disconnected">
                                    <i class="fas fa-exclamation-circle me-1"></i>Disconnected
                                </span>
                                <p class="text-danger mt-2 mb-0">
                                    Please check your Google Drive configuration
                                </p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <i class="fab fa-google-drive fa-3x text-muted opacity-50"></i>
                </div>
                
                <!-- Storage Usage -->
                <div class="storage-card">
                    <h5 class="mb-3"><i class="fas fa-database me-2"></i>Storage Usage</h5>
                    <div class="d-flex justify-content-between mb-2">
                        <span class="fw-bold">${storageUsed} / ${storageTotal}</span>
                        <span class="text-muted">${storagePercent}% used</span>
                    </div>
                    <div class="progress">
                        <div class="progress-bar" style="width: ${storagePercent}%"></div>
                    </div>
                    <p class="text-muted small mt-3 mb-0">
                        <i class="fas fa-info-circle me-1"></i>
                        Your files are encrypted before upload and securely stored in Google Drive
                    </p>
                </div>
                
                <!-- Features -->
                <h5 class="mb-3"><i class="fas fa-star me-2"></i>Features</h5>
                <div class="row">
                    <div class="col-md-6">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-lock"></i>
                            </div>
                            <h6 class="fw-bold">AES-256 Encryption</h6>
                            <p class="text-muted small mb-0">Files are encrypted before upload</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-fingerprint"></i>
                            </div>
                            <h6 class="fw-bold">SHA-256 Verification</h6>
                            <p class="text-muted small mb-0">Verify file integrity</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-share-alt"></i>
                            </div>
                            <h6 class="fw-bold">Shareable Links</h6>
                            <p class="text-muted small mb-0">Generate secure share links</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="feature-card">
                            <div class="feature-icon">
                                <i class="fas fa-history"></i>
                            </div>
                            <h6 class="fw-bold">Version History</h6>
                            <p class="text-muted small mb-0">Track file changes</p>
                        </div>
                    </div>
                </div>
                
                <!-- Actions -->
                <div class="mt-4 d-flex gap-3">
                    <button class="btn-drive flex-grow-1" onclick="window.location.href='${pageContext.request.contextPath}/jsp/user/upload.jsp'">
                        <i class="fas fa-cloud-upload-alt me-2"></i>Upload Files
                    </button>
                    <button class="btn-drive-outline flex-grow-1" onclick="window.location.href='${pageContext.request.contextPath}/myfiles'">
                        <i class="fas fa-folder me-2"></i>My Files
                    </button>
                </div>
                
                
            </div>
        </div>
        
        <div class="mt-4 text-center">
            <a href="${pageContext.request.contextPath}/dashboard" class="back-link">
                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
            </a>
        </div>
    </div>
</body>
</html>
