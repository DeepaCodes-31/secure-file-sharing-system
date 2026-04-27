<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Upload File - Secure File Sharing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #4361ee;
            --secondary-color: #3f37c9;
            --success-color: #28a745;
            --danger-color: #f72585;
            --warning-color: #ff9e00;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 40px 20px;
        }
        
        .upload-container {
            max-width: 700px;
            margin: 0 auto;
        }
        
        .upload-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        
        .upload-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .upload-body {
            padding: 30px;
        }
        
        .upload-area {
            border: 2px dashed #ddd;
            border-radius: 15px;
            padding: 40px 20px;
            text-align: center;
            background: #f8f9fa;
            cursor: pointer;
            transition: all 0.3s;
            margin-bottom: 20px;
        }
        
        .upload-area:hover {
            border-color: var(--primary-color);
            background: #f0f5ff;
        }
        
        .upload-area.dragover {
            border-color: var(--success-color);
            background: #e8f5e9;
        }
        
        .password-section {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 20px;
            margin: 20px 0;
            border-left: 4px solid var(--warning-color);
        }
        
        .password-input-group {
            position: relative;
            margin-top: 10px;
        }
        
        .password-input {
            width: 100%;
            padding: 12px 50px 12px 15px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 14px;
            transition: all 0.3s;
        }
        
        .password-input:focus {
            border-color: var(--primary-color);
            outline: none;
            box-shadow: 0 0 0 3px rgba(67, 97, 238, 0.1);
        }
        
        .toggle-password {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            cursor: pointer;
            color: #6c757d;
        }
        
        .password-strength {
            margin-top: 10px;
            height: 5px;
            border-radius: 3px;
            background: #e9ecef;
            overflow: hidden;
        }
        
        .strength-bar {
            height: 100%;
            width: 0%;
            transition: width 0.3s, background-color 0.3s;
        }
        
        .strength-text {
            font-size: 12px;
            margin-top: 5px;
            display: block;
        }
        
        .btn-upload {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            transition: all 0.3s;
            margin-top: 20px;
        }
        
        .btn-upload:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }
        
        .btn-upload:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            transform: none;
        }
        
        .file-preview {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 15px;
            margin-top: 20px;
            display: none;
        }
        
        .progress {
            height: 8px;
            border-radius: 4px;
            margin-top: 15px;
            display: none;
        }
        
        .badge-recommended {
            background: var(--warning-color);
            color: white;
            font-size: 10px;
            padding: 3px 8px;
            border-radius: 12px;
            margin-left: 10px;
        }
        
        /* Add these styles for better clickability */
        .upload-area input[type="file"] {
            position: absolute;
            width: 100%;
            height: 100%;
            top: 0;
            left: 0;
            opacity: 0;
            cursor: pointer;
        }
        
        .upload-area {
            position: relative;
            overflow: hidden;
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
    </style>
</head>
<body>
    <div class="upload-container">
        <div class="upload-card">
            <div class="upload-header">
                <i class="fas fa-cloud-upload-alt fa-4x mb-3"></i>
                <h2 class="mb-2">Upload File</h2>
                <p class="mb-0">Securely upload and encrypt your files to Google Drive</p>
            </div>
            
            <div class="upload-body">
                <form id="uploadForm" method="post" enctype="multipart/form-data">
                    <!-- File Upload Area - FIXED: Added direct file input -->
                    <div class="upload-area" id="dropArea">
                        <i class="fas fa-file-upload fa-3x text-primary mb-3"></i>
                        <h5>Drag & Drop or Click to Select</h5>
                        <p class="text-muted mb-2">Supported: All file types</p>
                        <p class="text-muted small">Maximum file size: 5GB</p>
                        <!-- IMPORTANT FIX: Direct file input without d-none class -->
                        <input type="file" id="fileInput" name="file" style="position: absolute; width: 100%; height: 100%; top: 0; left: 0; opacity: 0; cursor: pointer;">
                    </div>
                    
                    <!-- File Preview -->
                    <div id="filePreview" class="file-preview">
                        <div class="d-flex align-items-center">
                            <i class="fas fa-file fa-2x text-primary me-3"></i>
                            <div class="flex-grow-1">
                                <h6 id="fileName" class="mb-1"></h6>
                                <small id="fileSize" class="text-muted"></small>
                            </div>
                            <button type="button" class="btn btn-sm btn-outline-danger" onclick="clearFile()">
                                <i class="fas fa-times"></i>
                            </button>
                        </div>
                    </div>
                    
                    <!-- Encryption Options -->
                    <div class="form-check form-switch mt-4">
                        <input class="form-check-input" type="checkbox" id="encryptFile" name="encrypt" checked>
                        <label class="form-check-label" for="encryptFile">
                            <strong>🔐 Encrypt with AES-256</strong>
                        </label>
                        <small class="form-text text-muted d-block mt-1">
                            Military-grade encryption to protect your file
                        </small>
                    </div>
                    
                    <!-- Custom Password Section (Shown when encryption is enabled) -->
                    <div id="passwordSection" class="password-section">
                        <div class="d-flex align-items-center mb-2">
                            <i class="fas fa-key text-warning me-2"></i>
                            <strong>Encryption Password</strong>
                            <span class="badge-recommended">Optional</span>
                        </div>
                        <p class="small text-muted mb-2">
                            Leave blank to auto-generate a secure random password
                        </p>
                        
                        <div class="password-input-group">
                            <input type="password" id="encryptionPassword" name="encryptionPassword" 
                                   class="password-input" placeholder="Enter your own password (optional)">
                            <i class="fas fa-eye toggle-password" onclick="togglePassword()"></i>
                        </div>
                        
                        <!-- Password Strength Meter -->
                        <div id="passwordStrength" style="display: none;">
                            <div class="password-strength">
                                <div id="strengthBar" class="strength-bar"></div>
                            </div>
                            <span id="strengthText" class="strength-text"></span>
                        </div>
                        
                        <div class="form-check mt-2">
                            <input class="form-check-input" type="checkbox" id="showPassword">
                            <label class="form-check-label" for="showPassword">
                                Show password
                            </label>
                        </div>
                        
                        <div class="alert alert-info mt-3 mb-0 small">
                            <i class="fas fa-info-circle me-1"></i>
                            <strong>Remember:</strong> If you set your own password, make sure it's strong and memorable.
                            This password cannot be recovered if lost!
                        </div>
                    </div>
                    
                    <!-- File Description -->
                    <div class="mt-4">
                        <label for="fileDescription" class="form-label">
                            <i class="fas fa-align-left me-2"></i>Description (Optional)
                        </label>
                        <textarea class="form-control" id="fileDescription" name="description" 
                                  rows="2" placeholder="Add a description for your file"></textarea>
                    </div>
                    
                    <!-- Progress Bar -->
                    <div id="progressContainer" class="progress">
                        <div id="progressBar" class="progress-bar progress-bar-striped progress-bar-animated" 
                             style="width: 0%">0%</div>
                    </div>
                    
                    <!-- Upload Button -->
                    <button type="button" id="uploadBtn" class="btn-upload" onclick="startUpload()" disabled>
                        <i class="fas fa-lock me-2"></i>Encrypt & Upload
                    </button>
                </form>
                
                <div class="mt-4 text-center">
                    <a href="${pageContext.request.contextPath}/dashboard" class="back-link">
                        <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        let selectedFile = null;
        const contextPath = '${pageContext.request.contextPath}';
        
        $(document).ready(function() {
            console.log("Upload page loaded");
            
            // FIXED: Direct file input handler
            $('#fileInput').on('change', function(e) {
                console.log("File input changed");
                handleFileSelect(e);
            });
            
            // Click on drop area also triggers file input
            $('#dropArea').on('click', function(e) {
                // Don't trigger if clicking on file input itself
                if (e.target.tagName !== 'INPUT') {
                    $('#fileInput').click();
                }
            });
            
            // Drag and drop handlers
            $('#dropArea').on('dragover', function(e) {
                e.preventDefault();
                e.stopPropagation();
                $(this).addClass('dragover');
            });
            
            $('#dropArea').on('dragleave', function(e) {
                e.preventDefault();
                e.stopPropagation();
                $(this).removeClass('dragover');
            });
            
            $('#dropArea').on('drop', function(e) {
                e.preventDefault();
                e.stopPropagation();
                $(this).removeClass('dragover');
                
                let files = e.originalEvent.dataTransfer.files;
                if (files.length > 0) {
                    $('#fileInput')[0].files = files;
                    handleFileSelect({ target: { files: files } });
                }
            });
            
            // Toggle password section based on encryption checkbox
            $('#encryptFile').change(function() {
                if ($(this).is(':checked')) {
                    $('#passwordSection').slideDown();
                    $('#uploadBtn').html('<i class="fas fa-lock me-2"></i>Encrypt & Upload');
                } else {
                    $('#passwordSection').slideUp();
                    $('#uploadBtn').html('<i class="fas fa-cloud-upload-alt me-2"></i>Upload without Encryption');
                }
            });
            
            // Show/hide password
            $('#showPassword').change(function() {
                let passwordField = $('#encryptionPassword');
                if ($(this).is(':checked')) {
                    passwordField.attr('type', 'text');
                } else {
                    passwordField.attr('type', 'password');
                }
            });
            
            // Password strength meter
            $('#encryptionPassword').on('input', function() {
                let password = $(this).val();
                if (password.length > 0) {
                    $('#passwordStrength').show();
                    updatePasswordStrength(password);
                } else {
                    $('#passwordStrength').hide();
                }
            });
        });
        
        function handleFileSelect(event) {
            console.log("Handling file select", event);
            let files = event.target.files;
            if (!files || files.length === 0) return;
            
            let file = files[0];
            selectedFile = file;
            
            console.log("File selected:", file.name, file.size, "bytes");
            
            // Validate file size (5GB limit)
            if (file.size > 5 * 1024 * 1024 * 1024) {
                alert('File size exceeds 5GB limit!');
                clearFile();
                return;
            }
            
            // Show file preview
            $('#fileName').text(file.name);
            $('#fileSize').text(formatFileSize(file.size));
            $('#filePreview').show();
            
            // Enable upload button
            $('#uploadBtn').prop('disabled', false);
        }
        
        function clearFile() {
            $('#fileInput').val('');
            $('#filePreview').hide();
            selectedFile = null;
            $('#uploadBtn').prop('disabled', true);
        }
        
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }
        
        function updatePasswordStrength(password) {
            let strength = 0;
            
            // Length check
            if (password.length >= 8) strength += 25;
            if (password.length >= 12) strength += 25;
            
            // Complexity checks
            if (/[a-z]/.test(password)) strength += 12.5;
            if (/[A-Z]/.test(password)) strength += 12.5;
            if (/[0-9]/.test(password)) strength += 12.5;
            if (/[^a-zA-Z0-9]/.test(password)) strength += 12.5;
            
            // Cap at 100
            strength = Math.min(strength, 100);
            
            // Update strength bar
            $('#strengthBar').css('width', strength + '%');
            
            // Update color and text
            if (strength < 25) {
                $('#strengthBar').css('background-color', '#dc3545');
                $('#strengthText').text('Very Weak').css('color', '#dc3545');
            } else if (strength < 50) {
                $('#strengthBar').css('background-color', '#ffc107');
                $('#strengthText').text('Weak').css('color', '#ffc107');
            } else if (strength < 75) {
                $('#strengthBar').css('background-color', '#17a2b8');
                $('#strengthText').text('Good').css('color', '#17a2b8');
            } else {
                $('#strengthBar').css('background-color', '#28a745');
                $('#strengthText').text('Strong').css('color', '#28a745');
            }
        }
        
        function togglePassword() {
            let passwordField = $('#encryptionPassword');
            let toggleIcon = $('.toggle-password');
            
            if (passwordField.attr('type') === 'password') {
                passwordField.attr('type', 'text');
                toggleIcon.removeClass('fa-eye').addClass('fa-eye-slash');
            } else {
                passwordField.attr('type', 'password');
                toggleIcon.removeClass('fa-eye-slash').addClass('fa-eye');
            }
        }
        
        function startUpload() {
            if (!selectedFile) {
                alert('Please select a file to upload');
                return;
            }
            
            let formData = new FormData();
            formData.append('file', selectedFile);
            formData.append('encrypt', $('#encryptFile').is(':checked') ? 'on' : 'off');
            
            // Add password if provided
            let password = $('#encryptionPassword').val();
            if (password && password.trim() !== '') {
                formData.append('encryptionPassword', password.trim());
            }
            
            let description = $('#fileDescription').val();
            if (description) {
                formData.append('description', description);
            }
            
            formData.append('folder', 'SecureFiles');
            
            // Show progress bar
            $('#progressContainer').show();
            $('#uploadBtn').prop('disabled', true);
            $('#uploadBtn').html('<i class="fas fa-spinner fa-spin me-2"></i>Uploading...');
            
            $.ajax({
                url: contextPath + '/upload',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                xhr: function() {
                    let xhr = new window.XMLHttpRequest();
                    xhr.upload.addEventListener('progress', function(e) {
                        if (e.lengthComputable) {
                            let percent = Math.round((e.loaded / e.total) * 100);
                            $('#progressBar').css('width', percent + '%');
                            $('#progressBar').text(percent + '%');
                        }
                    });
                    return xhr;
                },
                success: function(response) {
                    console.log("Upload success:", response);
                    if (response.redirect) {
                        window.location.href = response.redirect;
                    }
                },
                error: function(xhr) {
                    console.error("Upload error:", xhr);
                    try {
                        let response = JSON.parse(xhr.responseText);
                        alert('Upload failed: ' + response.message);
                    } catch (e) {
                        alert('Upload failed. Please try again.');
                    }
                    $('#progressContainer').hide();
                    $('#uploadBtn').prop('disabled', false);
                    $('#uploadBtn').html('<i class="fas fa-lock me-2"></i>Encrypt & Upload');
                }
            });
        }
    </script>
</body>
</html>