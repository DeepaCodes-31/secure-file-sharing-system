<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Download Complete - Secure File Sharing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .success-card {
            max-width: 600px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .success-header {
            background: linear-gradient(135deg, #28a745, #20c997);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .success-body {
            padding: 30px;
        }
        
        .hash-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin: 15px 0;
            border-left: 4px solid #17a2b8;
        }
        
        .hash-code {
            font-family: 'Courier New', monospace;
            font-size: 12px;
            word-break: break-all;
            background: white;
            padding: 10px;
            border-radius: 5px;
            border: 1px solid #dee2e6;
        }
        
        .match-badge {
            background: #28a745;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
        }
        
        .mismatch-badge {
            background: #dc3545;
            color: white;
            padding: 5px 10px;
            border-radius: 5px;
            font-size: 14px;
        }
    </style>
</head>
<body>
    <div class="success-card">
        <div class="success-header">
            <i class="fas fa-check-circle fa-4x mb-3"></i>
            <h2 class="mb-2">Download Complete!</h2>
            <p class="mb-0">Your file has been downloaded and decrypted successfully</p>
        </div>
        
        <div class="success-body">
            <!-- File Information -->
            <div class="d-flex align-items-center mb-4">
                <i class="fas fa-file-alt fa-3x text-primary me-3"></i>
                <div>
                    <h5 class="mb-1">${sessionScope.fileName}</h5>
                    <small class="text-muted">Size: ${sessionScope.fileSize}</small>
                </div>
            </div>
            
            <!-- Hash Verification Results -->
            <div class="hash-box">
                <h6 class="mb-3"><i class="fas fa-fingerprint me-2"></i>SHA-256 Integrity Verification</h6>
                
                <div class="mb-3">
                    <small class="text-muted">Original File Hash:</small>
                    <div class="hash-code mt-1">${sessionScope.expectedHash}</div>
                </div>
                
                <div class="mb-3">
                    <small class="text-muted">Downloaded File Hash:</small>
                    <div class="hash-code mt-1">${sessionScope.downloadedHash}</div>
                </div>
                
                <c:choose>
                    <c:when test="${sessionScope.downloadedHash eq sessionScope.expectedHash}">
                        <div class="match-badge text-center">
                            <i class="fas fa-check-circle me-2"></i>File Verified - Hashes Match!
                        </div>
                        <p class="text-success mt-2 mb-0 small">
                            <i class="fas fa-shield-alt me-1"></i>
                            File integrity confirmed. The file has not been tampered with.
                        </p>
                    </c:when>
                    <c:otherwise>
                        <div class="mismatch-badge text-center">
                            <i class="fas fa-exclamation-triangle me-2"></i>WARNING: Hash Mismatch!
                        </div>
                        <p class="text-danger mt-2 mb-0 small">
                            <i class="fas fa-exclamation-circle me-1"></i>
                            File integrity check failed. The file may have been corrupted or tampered with.
                        </p>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <!-- Encrypted File Hash (for reference) -->
            <c:if test="${not empty sessionScope.encryptedHash}">
                <div class="mt-3 p-3 bg-light rounded">
                    <small class="text-muted">Encrypted File Hash (Google Drive):</small>
                    <div class="font-monospace small mt-1" style="word-break: break-all;">
                        ${sessionScope.encryptedHash}
                    </div>
                </div>
            </c:if>
            
            <!-- Action Buttons -->
            <div class="d-flex justify-content-end gap-2 mt-4">
                <a href="${pageContext.request.contextPath}/myfiles" class="btn btn-primary">
                    <i class="fas fa-folder me-2"></i>My Files
                </a>
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-secondary">
                    <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                </a>
            </div>
        </div>
    </div>
    
    <script>
        // Clear session data after 5 minutes
        setTimeout(() => {
            fetch('${pageContext.request.contextPath}/clear-download-session', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
        }, 300000);
    </script>
</body>
</html>