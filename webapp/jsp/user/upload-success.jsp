<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload Success - Secure File Sharing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #28a745;
            --danger-color: #f72585;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fb;
        }
        
        .success-container {
            max-width: 800px;
            margin: 50px auto;
            padding: 30px;
        }
        
        .success-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border: none;
            overflow: hidden;
        }
        
        .success-header {
            background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .success-body {
            padding: 30px;
        }
        
        .encryption-details {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            margin: 20px 0;
        }
        
        .hash-box {
            background: #e9ecef;
            border-radius: 5px;
            padding: 10px;
            font-family: monospace;
            font-size: 12px;
            word-break: break-all;
            margin: 5px 0;
        }
        
        .password-box {
            background: #d1ecf1;
            border: 2px dashed #0c5460;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            font-size: 18px;
            font-weight: bold;
            color: #0c5460;
            margin: 15px 0;
        }
        
        .warning-box {
            background: #fff3cd;
            border: 1px solid #ffeaa7;
            border-radius: 5px;
            padding: 15px;
            color: #856404;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-card">
            <!-- Header -->
            <div class="success-header">
                <i class="fas fa-check-circle fa-4x mb-3"></i>
                <h1 class="mb-2">Upload Successful!</h1>
                <p class="mb-0">Your file has been encrypted and stored securely in Google Drive</p>
            </div>
            
            <!-- Body -->
            <div class="success-body">
                <!-- File Info -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <h5><i class="fas fa-file-alt text-primary me-2"></i>File Information</h5>
                        <table class="table table-sm">
                            <tr>
                                <td><strong>Original File:</strong></td>
                                <td>${uploadedFile}</td>
                            </tr>
                            <tr>
                                <td><strong>Stored As:</strong></td>
                                <td>${storedFile}</td>
                            </tr>
                            <tr>
                                <td><strong>File Size:</strong></td>
                                <td>${fileSize}</td>
                            </tr>
                            <tr>
                                <td><strong>Storage:</strong></td>
                                <td><span class="badge bg-info">Google Drive</span></td>
                            </tr>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <h5><i class="fas fa-shield-alt text-success me-2"></i>Security Information</h5>
                        <table class="table table-sm">
                            <tr>
                                <td><strong>Encryption:</strong></td>
                                <td><span class="badge bg-success">AES-256</span></td>
                            </tr>
                            <tr>
                                <td><strong>Algorithm:</strong></td>
                                <td>AES/CBC/PKCS5Padding</td>
                            </tr>
                            <tr>
                                <td><strong>Hash:</strong></td>
                                <td>SHA-256</td>
                            </tr>
                            <tr>
                                <td><strong>Status:</strong></td>
                                <td><span class="badge bg-success">Encrypted & Secure</span></td>
                            </tr>
                        </table>
                    </div>
                </div>
                
                <!-- Encryption Password -->
<div class="mb-4">
    <h5><i class="fas fa-key text-warning me-2"></i>Encryption Password</h5>
    <div class="password-box">
        ${encryptionPassword}
    </div>
    <div class="mt-2 mb-2">
        <c:choose>
            <c:when test="${isUserProvidedPassword}">
                <span class="badge bg-info">
                    <i class="fas fa-user me-1"></i>You provided this password
                </span>
            </c:when>
            <c:otherwise>
                <span class="badge bg-secondary">
                    <i class="fas fa-random me-1"></i>Auto-generated password
                </span>
            </c:otherwise>
        </c:choose>
    </div>
    <div class="warning-box">
        <i class="fas fa-exclamation-triangle me-2"></i>
        <strong>Important:</strong> Save this password! You will need it to decrypt this file. 
        This password is not stored anywhere and cannot be recovered if lost.
    </div>
</div>
                
                <!-- Hash Values for Integrity -->
                <div class="mb-4">
                    <h5><i class="fas fa-fingerprint text-info me-2"></i>Integrity Verification Hashes</h5>
                    <p class="text-muted">Use these SHA-256 hashes to verify file integrity:</p>
                    
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label"><strong>Original File Hash:</strong></label>
                            <div class="hash-box">
                                ${originalHash}
                            </div>
                            <small class="text-muted">SHA-256 of original file (before encryption)</small>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label"><strong>Encrypted File Hash:</strong></label>
                            <div class="hash-box">
                                ${encryptedHash}
                            </div>
                            <small class="text-muted">SHA-256 of encrypted file (stored in CloudMe)</small>
                        </div>
                    </div>
                    
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i>
                        These hash values ensure file integrity. Compare them when downloading/decrypting 
                        to verify the file hasn't been tampered with.
                    </div>
                </div>
                
                <!-- Actions -->
                <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                    <button class="btn btn-outline-secondary me-2" onclick="copyPassword()">
                        <i class="fas fa-copy me-2"></i>Copy Password
                    </button>
                    <button class="btn btn-outline-info me-2" onclick="copyHash('original')">
                        <i class="fas fa-copy me-2"></i>Copy Original Hash
                    </button>
                    <button class="btn btn-outline-info me-2" onclick="copyHash('encrypted')">
                        <i class="fas fa-copy me-2"></i>Copy Encrypted Hash
                    </button>
                    <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-primary">
                        <i class="fas fa-tachometer-alt me-2"></i>Go to Dashboard
                    </a>
                    <a href="${pageContext.request.contextPath}/jsp/user/upload.jsp" class="btn btn-success">
                        <i class="fas fa-cloud-upload-alt me-2"></i>Upload Another File
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Copy password to clipboard
        function copyPassword() {
            const password = '${encryptionPassword}';
            navigator.clipboard.writeText(password).then(() => {
                alert('Encryption password copied to clipboard!');
            });
        }
        
        // Copy hash to clipboard
        function copyHash(type) {
            let hash = '';
            if (type === 'original') {
                hash = '${originalHash}';
            } else {
                hash = '${encryptedHash}';
            }
            
            navigator.clipboard.writeText(hash).then(() => {
                alert(type.charAt(0).toUpperCase() + type.slice(1) + ' hash copied to clipboard!');
            });
        }
        
        // Auto-clear session data after 5 minutes
        setTimeout(() => {
            // Clear sensitive data from session
            fetch('${pageContext.request.contextPath}/clear-upload-session', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            });
        }, 300000); // 5 minutes
    </script>
</body>
</html>