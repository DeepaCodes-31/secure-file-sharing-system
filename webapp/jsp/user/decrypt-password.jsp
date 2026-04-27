<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Enter Decryption Password - Secure File Sharing</title>
    
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    
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
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }
        
        .password-card {
            max-width: 550px;
            width: 100%;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
            animation: slideIn 0.5s ease-out;
        }
        
        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        .card-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .card-body {
            padding: 35px 30px;
        }
        
        .file-info {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin-bottom: 25px;
            border-left: 4px solid var(--primary-color);
        }
        
        .file-icon {
            width: 50px;
            height: 50px;
            background: linear-gradient(135deg, #e3f2fd, #bbdefb);
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--primary-color);
            font-size: 24px;
        }
        
        .password-input-group {
            position: relative;
            margin-bottom: 20px;
        }
        
        .password-input {
            width: 100%;
            padding: 15px 50px 15px 15px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s;
            background: #f8f9fa;
        }
        
        .password-input:focus {
            border-color: var(--primary-color);
            background: white;
            outline: none;
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
        }
        
        .password-input.error {
            border-color: var(--danger-color);
            background: #fff8f8;
        }
        
        .password-input.error:focus {
            box-shadow: 0 0 0 4px rgba(220, 53, 69, 0.1);
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
            padding: 5px;
        }
        
        .btn-download {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .btn-download:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }
        
        .btn-download:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        
        .alert {
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            animation: slideIn 0.3s ease-out;
        }
        
        .hash-verification {
            background: #e3f2fd;
            border-radius: 15px;
            padding: 20px;
            margin-top: 25px;
            display: none;
            border-left: 4px solid var(--info-color);
        }
        
        .hash-box {
            background: white;
            border-radius: 10px;
            padding: 12px;
            border: 1px solid #dee2e6;
            margin-top: 8px;
            word-break: break-all;
            font-family: 'Courier New', monospace;
            font-size: 12px;
        }
        
        .hash-match {
            color: #28a745;
            background: #d4edda;
            padding: 10px;
            border-radius: 8px;
            display: block;
            text-align: center;
        }
        
        .badge-encrypted {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .badge-cloud {
            background: linear-gradient(135deg, #4285F4, #34A853);
            color: white;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 12px;
            font-weight: 500;
        }
        
        .password-strength {
            margin-top: 5px;
            font-size: 12px;
        }
        
        .attempts-left {
            font-size: 12px;
            color: #6c757d;
            margin-top: 5px;
        }
        
        .attempts-left.warning {
            color: var(--warning-color);
            font-weight: 600;
        }
        
        .attempts-left.danger {
            color: var(--danger-color);
            font-weight: 600;
        }
        
        .download-hint {
            background: #fff3cd;
            border: 1px solid #ffeeba;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            text-align: center;
        }
        
        .download-hint i {
            color: #856404;
            margin-right: 8px;
        }
    </style>
</head>
<body>
    <div class="password-card">
        <div class="card-header">
            <i class="fas fa-lock fa-4x mb-3" style="opacity: 0.9;"></i>
            <h2 class="mb-2" style="font-size: 28px; font-weight: 700;">File Encrypted</h2>
            <p class="mb-0" style="opacity: 0.9; font-size: 16px;">Enter password to decrypt and download</p>
        </div>
        
        <div class="card-body">
            <!-- File Information -->
            <div class="file-info">
                <div class="d-flex align-items-center">
                    <div class="file-icon me-3">
                        <i class="fas fa-file-alt"></i>
                    </div>
                    <div style="flex: 1;">
                        <h6 class="mb-1" id="fileName" style="font-weight: 600; font-size: 16px;">Loading...</h6>
                        <small class="text-muted" id="fileSize">Size: --</small>
                    </div>
                </div>
                <div class="mt-3">
                    <span class="badge-encrypted me-2">
                        <i class="fas fa-shield-alt me-1"></i>AES-256 Encrypted
                    </span>
                    <span class="badge-cloud">
                        <i class="fab fa-google-drive me-1"></i>Google Drive
                    </span>
                </div>
            </div>
            
            <!-- Alert Container -->
            <div id="alertContainer"></div>
            
            <!-- Error message from server (if any) -->
            <c:if test="${not empty param.error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert" id="serverErrorAlert">
                    <i class="fas fa-exclamation-circle me-2"></i>
                    <c:choose>
                        <c:when test="${param.error == 'invalid_password'}">
                            Incorrect password. Please try again.
                        </c:when>
                        <c:when test="${param.error == 'corrupted_file'}">
                            File appears to be corrupted. Please re-upload.
                        </c:when>
                        <c:when test="${param.error == 'download_failed'}">
                            Failed to download file. Please try again.
                        </c:when>
                        <c:otherwise>
                            An error occurred. Please try again.
                        </c:otherwise>
                    </c:choose>
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <!-- Password Input -->
            <div class="password-input-group">
                <input type="password" id="password" class="password-input ${not empty param.error ? 'error' : ''}" 
                       placeholder="Enter decryption password" autofocus>
                <i class="fas fa-eye toggle-password" onclick="togglePassword()" id="toggleIcon"></i>
            </div>
            
            <!-- Attempts left indicator -->
            <div class="attempts-left" id="attemptsLeft"></div>
            
            <!-- Download Button -->
            <button id="downloadBtn" class="btn-download" onclick="downloadWithPassword()" disabled>
                <i class="fas fa-download me-2"></i>Decrypt & Download
            </button>
            
         
            
            <!-- Hash Verification Results (shown after successful decryption) -->
            <div id="hashVerification" class="hash-verification">
                <div class="d-flex align-items-center mb-3">
                    <i class="fas fa-fingerprint fa-2x text-info me-3"></i>
                    <div>
                        <h6 class="mb-1" style="font-weight: 600;">SHA-256 Integrity Verification</h6>
                        <small class="text-muted">File integrity verified successfully</small>
                    </div>
                </div>
                <div class="hash-match">
                    <i class="fas fa-check-circle me-2"></i>✓ File integrity verified - Hashes match!
                </div>
            </div>
            
            <!-- Back Links -->
            <div class="mt-4 text-center">
                <a href="${pageContext.request.contextPath}/myfiles" class="text-decoration-none" style="color: var(--primary-color);">
                    <i class="fas fa-arrow-left me-1"></i>Back to My Files
                </a>
                <span class="mx-2 text-muted">|</span>
                <a href="${pageContext.request.contextPath}/dashboard" class="text-decoration-none" style="color: var(--primary-color);">
                    <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                </a>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        var contextPath = '${pageContext.request.contextPath}';
        var fileId = getQueryParameter('fileId');
        var attempts = 3; // Track remaining attempts
        var isProcessing = false;
        
        $(document).ready(function() {
            console.log("Decrypt page loaded with fileId:", fileId);
            
            if (!fileId) {
                showAlert('No file selected. Please go back and try again.', 'danger');
                $('#downloadBtn').prop('disabled', true);
                return;
            }
            
            loadFileInfo();
            loadAttempts();
            
            $('#password').keypress(function(e) {
                if (e.which == 13) { // Enter key
                    downloadWithPassword();
                    return false;
                }
            });
            
            // Enable download button when password is entered
            $('#password').on('input', function() {
                var password = $(this).val().trim();
                if (password.length > 0) {
                    $('#downloadBtn').prop('disabled', false);
                } else {
                    $('#downloadBtn').prop('disabled', true);
                }
                
                // Clear error styling when user starts typing
                $(this).removeClass('error');
                $('#serverErrorAlert').fadeOut(300, function() {
                    $(this).remove();
                });
            });
            
            // Check for error parameter on page load
            var urlParams = new URLSearchParams(window.location.search);
            if (urlParams.get('error') === 'invalid_password') {
                $('#password').addClass('error').val('');
                updateAttempts();
            }
            
            // Focus on password field
            setTimeout(function() {
                $('#password').focus();
            }, 500);
        });
        
        function getQueryParameter(name) {
            var urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(name);
        }
        
        function loadFileInfo() {
            $.ajax({
                url: contextPath + '/download',
                type: 'GET',
                data: {
                    fileId: fileId,
                    action: 'verify'
                },
                dataType: 'json',
                success: function(data) {
                    if (data.success) {
                        $('#fileName').text(data.fileName || 'Unknown');
                        $('#fileSize').text('Size: ' + (data.fileSize || 'Unknown'));
                        
                        // Enable download button if password field has value
                        if ($('#password').val().trim().length > 0) {
                            $('#downloadBtn').prop('disabled', false);
                        }
                    } else {
                        showAlert('Failed to load file information', 'danger');
                    }
                },
                error: function(xhr) {
                    var errorMsg = 'Failed to load file information';
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMsg = xhr.responseJSON.message;
                    }
                    showAlert(errorMsg, 'danger');
                }
            });
        }
        
        function loadAttempts() {
            // For now, we'll use session storage to track attempts
            var storedAttempts = sessionStorage.getItem('decryptAttempts_' + fileId);
            if (storedAttempts) {
                attempts = parseInt(storedAttempts);
            }
            updateAttemptsDisplay();
        }
        
        function updateAttempts() {
            attempts--;
            sessionStorage.setItem('decryptAttempts_' + fileId, attempts);
            updateAttemptsDisplay();
            
            if (attempts <= 0) {
                $('#downloadBtn').prop('disabled', true);
                $('#downloadBtn').html('<i class="fas fa-ban me-2"></i>Too Many Attempts');
                showAlert('Too many failed attempts. Please try again later.', 'danger');
            }
        }
        
        function updateAttemptsDisplay() {
            var attemptsLeftDiv = $('#attemptsLeft');
            if (attempts < 3) {
                attemptsLeftDiv.text(attempts + ' attempt' + (attempts !== 1 ? 's' : '') + ' remaining');
                if (attempts <= 1) {
                    attemptsLeftDiv.addClass('danger').removeClass('warning');
                } else if (attempts <= 2) {
                    attemptsLeftDiv.addClass('warning').removeClass('danger');
                }
                attemptsLeftDiv.show();
            } else {
                attemptsLeftDiv.hide();
            }
        }
        
        function togglePassword() {
            var passwordInput = $('#password');
            var toggleIcon = $('#toggleIcon');
            
            if (passwordInput.attr('type') === 'password') {
                passwordInput.attr('type', 'text');
                toggleIcon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                passwordInput.attr('type', 'password');
                toggleIcon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        }
        
        function downloadWithPassword() {
            if (isProcessing) return;
            
            var password = $('#password').val().trim();
            
            if (!password) {
                showAlert('Please enter the decryption password', 'warning');
                $('#password').addClass('error').focus();
                return;
            }
            
            if (attempts <= 0) {
                showAlert('Too many failed attempts. Please try again later.', 'danger');
                return;
            }
            
            isProcessing = true;
            var downloadBtn = $('#downloadBtn');
            var originalText = downloadBtn.html();
            downloadBtn.html('<i class="fas fa-spinner fa-spin me-2"></i>Decrypting...');
            downloadBtn.prop('disabled', true);
            
            console.log("Sending decrypt request for fileId:", fileId);
            
            // Create a hidden form for file download
            // This is more reliable for file downloads than AJAX
            var form = document.createElement('form');
            form.method = 'POST';
            form.action = contextPath + '/download';
            form.style.display = 'none';
            
            var fileIdInput = document.createElement('input');
            fileIdInput.type = 'hidden';
            fileIdInput.name = 'fileId';
            fileIdInput.value = fileId;
            
            var passwordInput = document.createElement('input');
            passwordInput.type = 'hidden';
            passwordInput.name = 'password';
            passwordInput.value = password;
            
            var actionInput = document.createElement('input');
            actionInput.type = 'hidden';
            actionInput.name = 'action';
            actionInput.value = 'decrypt_and_download';
            
            form.appendChild(fileIdInput);
            form.appendChild(passwordInput);
            form.appendChild(actionInput);
            document.body.appendChild(form);
            
            // Submit the form
            form.submit();
            
            // Reset processing state after a delay
            setTimeout(function() {
                isProcessing = false;
                downloadBtn.html(originalText);
                downloadBtn.prop('disabled', false);
                
                // Check if we need to show hash verification
                checkHashVerification();
                
                // Show success message
                showAlert('File download started! Check your browser downloads folder.', 'success');
                
                // Clear password field
                $('#password').val('');
            }, 3000);
        }
        
        // Alternative AJAX approach (for better error handling)
        function downloadWithPasswordAJAX() {
            if (isProcessing) return;
            
            var password = $('#password').val().trim();
            
            if (!password) {
                showAlert('Please enter the decryption password', 'warning');
                $('#password').addClass('error').focus();
                return;
            }
            
            if (attempts <= 0) {
                showAlert('Too many failed attempts. Please try again later.', 'danger');
                return;
            }
            
            isProcessing = true;
            var downloadBtn = $('#downloadBtn');
            var originalText = downloadBtn.html();
            downloadBtn.html('<i class="fas fa-spinner fa-spin me-2"></i>Decrypting...');
            downloadBtn.prop('disabled', true);
            
            console.log("Sending decrypt request for fileId:", fileId);
            
            $.ajax({
                url: contextPath + '/download',
                type: 'POST',
                data: {
                    fileId: fileId,
                    password: password,
                    action: 'decrypt_and_download'
                },
                xhrFields: {
                    responseType: 'blob' // Important for file download
                },
                success: function(data, status, xhr) {
                    console.log("Decrypt successful, preparing download");
                    
                    // Get filename from Content-Disposition header
                    var disposition = xhr.getResponseHeader('Content-Disposition');
                    var filename = 'downloaded_file';
                    if (disposition && disposition.indexOf('attachment') !== -1) {
                        var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                        var matches = filenameRegex.exec(disposition);
                        if (matches != null && matches[1]) {
                            filename = matches[1].replace(/['"]/g, '');
                        }
                    }
                    
                    // Create download link
                    var blob = new Blob([data]);
                    var link = document.createElement('a');
                    link.href = window.URL.createObjectURL(blob);
                    link.download = filename;
                    link.click();
                    
                    // Clean up
                    window.URL.revokeObjectURL(link.href);
                    
                    // Reset UI
                    isProcessing = false;
                    downloadBtn.html(originalText);
                    downloadBtn.prop('disabled', false);
                    
                    // Show success message
                    showAlert('File downloaded successfully!', 'success');
                    
                    // Clear password field
                    $('#password').val('');
                    
                    // Show hash verification
                    checkHashVerification();
                },
                error: function(xhr) {
                    console.error("Decrypt error:", xhr);
                    
                    isProcessing = false;
                    downloadBtn.html(originalText);
                    downloadBtn.prop('disabled', false);
                    
                    var errorMsg = 'Incorrect password';
                    if (xhr.responseJSON && xhr.responseJSON.message) {
                        errorMsg = xhr.responseJSON.message;
                    } else if (xhr.responseText) {
                        try {
                            var response = JSON.parse(xhr.responseText);
                            errorMsg = response.message || errorMsg;
                        } catch (e) {
                            // Not JSON, use default message
                        }
                    }
                    
                    // Update attempts
                    updateAttempts();
                    
                    // Show error
                    showAlert(errorMsg, 'danger');
                    $('#password').addClass('error').val('').focus();
                }
            });
        }
        
        function showForgotPasswordHint() {
            showAlert('Password hint: The password was set during file upload. If you forgot it, you cannot recover the file.', 'info');
        }
        
        function checkHashVerification() {
            // Check sessionStorage for hash verification
            var hashMatch = sessionStorage.getItem('hashMatch_' + fileId);
            if (hashMatch === 'true') {
                $('#hashVerification').fadeIn(300);
                
                // Clear after showing
                setTimeout(function() {
                    sessionStorage.removeItem('hashMatch_' + fileId);
                }, 5000);
            }
        }
        
        function showAlert(message, type) {
            var alertClass = 'alert-' + type;
            var icon = type === 'success' ? 'fa-check-circle' : 
                      (type === 'danger' ? 'fa-exclamation-circle' : 
                      (type === 'warning' ? 'fa-exclamation-triangle' : 'fa-info-circle'));
            
            var alertHtml = '<div class="alert ' + alertClass + ' alert-dismissible fade show" role="alert">' +
                '<i class="fas ' + icon + ' me-2"></i>' + message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
                '</div>';
            
            $('#alertContainer').html(alertHtml);
            
            // Auto dismiss after 5 seconds
            setTimeout(function() {
                $('.alert').fadeOut(300, function() {
                    $(this).remove();
                });
            }, 5000);
        }
        
        // Handle browser back button
        window.addEventListener('pageshow', function(event) {
            if (event.persisted) {
                window.location.reload();
            }
        });
        
        // Clear attempts on successful download
        function clearAttempts() {
            sessionStorage.removeItem('decryptAttempts_' + fileId);
            attempts = 3;
            updateAttemptsDisplay();
        }
    </script>
</body>
</html>