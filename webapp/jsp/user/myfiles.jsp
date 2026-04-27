<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Files - Secure File Sharing System</title>
    
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
            background-color: #f5f7fb;
        }
        
        .sidebar {
            background: linear-gradient(180deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            min-height: 100vh;
            position: fixed;
            width: 250px;
            padding-top: 20px;
            box-shadow: 3px 0 10px rgba(0,0,0,0.1);
        }
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        
        .user-profile {
            text-align: center;
            padding: 20px;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .user-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: white;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 15px;
            font-size: 30px;
            color: var(--primary-color);
        }
        
        .nav-link {
            color: rgba(255,255,255,0.8);
            padding: 12px 20px;
            margin: 5px 10px;
            border-radius: 8px;
            transition: all 0.3s;
        }
        
        .nav-link:hover, .nav-link.active {
            background: rgba(255,255,255,0.1);
            color: white;
        }
        
        .nav-link i {
            width: 24px;
            margin-right: 10px;
        }
        
        .files-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            padding: 25px;
        }
        
        .file-icon {
            width: 40px;
            height: 40px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }
        
        .file-pdf { background: #ffebee; color: #f44336; }
        .file-doc { background: #e3f2fd; color: #2196f3; }
        .file-img { background: #f3e5f5; color: #9c27b0; }
        .file-zip { background: #fff3e0; color: #ff9800; }
        .file-txt { background: #e8f5e9; color: #4caf50; }
        .file-default { background: #e0e0e0; color: #616161; }
        
        .badge-encrypted {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
        }
        
        .badge-cloud {
            background: linear-gradient(135deg, #4285F4, #34A853);
            color: white;
        }
        
        .action-btn {
            padding: 5px 15px;
            border-radius: 6px;
            transition: all 0.3s;
            margin: 0 3px;
        }
        
        .action-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
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
        
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                position: relative;
                min-height: auto;
            }
            .main-content {
                margin-left: 0;
            }
        }
        
        /* File hash tooltip */
        .hash-tooltip {
            cursor: help;
            border-bottom: 1px dashed #ccc;
        }
        
        /* Loading overlay */
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.8);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
        }
        
        .loading-spinner {
            width: 60px;
            height: 60px;
            border: 5px solid #f3f3f3;
            border-top: 5px solid var(--primary-color);
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
    <!-- Loading Overlay -->
    <div id="loadingOverlay" class="loading-overlay">
        <div class="text-center">
            <div class="loading-spinner mb-3"></div>
            <h5 class="text-primary">Processing...</h5>
        </div>
    </div>
    
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 sidebar d-md-block">
                <div class="user-profile">
                    <div class="user-avatar">
                        <i class="fas fa-user-shield"></i>
                    </div>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <h5><c:out value="${sessionScope.user.username}" /></h5>
                            <p class="text-muted"><c:out value="${sessionScope.user.email}" /></p>
                            <div class="badge bg-success"><c:out value="${sessionScope.user.role}" /></div>
                        </c:when>
                    </c:choose>
                </div>
                
                <nav class="nav flex-column mt-4">
                    <a class="nav-link" href="${pageContext.request.contextPath}/dashboard">
                        <i class="fas fa-tachometer-alt"></i> Dashboard
                    </a>
                    <a class="nav-link" href="#" data-bs-toggle="modal" data-bs-target="#uploadModal">
                        <i class="fas fa-cloud-upload-alt"></i> Upload Files
                    </a>
                    <a class="nav-link active" href="${pageContext.request.contextPath}/myfiles">
                        <i class="fas fa-folder"></i> My Files
                        <c:if test="${not empty fileCount and fileCount > 0}">
                            <span class="badge bg-light text-dark float-end">${fileCount}</span>
                        </c:if>
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/shared">
                        <i class="fas fa-share-alt"></i> Shared Files
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/drive">
                        <i class="fab fa-google-drive"></i> Google Drive
                    </a>
                    <a class="nav-link" href="${pageContext.request.contextPath}/profile">
                        <i class="fas fa-user-cog"></i> Profile Settings
                    </a>
                    <div class="mt-5">
                        <a class="nav-link text-danger" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i> Logout
                        </a>
                    </div>
                </nav>
            </div>
            
            <!-- Main Content -->
            <div class="col-md-9 col-lg-10 main-content">
                <!-- Header -->
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div>
                        <h2 class="mb-1">My Files</h2>
                        <p class="text-muted">
                            <i class="fas fa-database me-1"></i>
                            Total Storage: ${totalStorage}
                            <span class="mx-2">|</span>
                            <i class="fas fa-file me-1"></i>
                            Total Files: ${fileCount}
                        </p>
                    </div>
                    <div>
                        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#uploadModal">
                            <i class="fas fa-plus me-2"></i> Upload New File
                        </button>
                    </div>
                </div>
                
                <!-- Alert Container -->
                <div id="alertContainer"></div>
                
                <!-- Files Table -->
                <div class="files-card">
                    <c:choose>
                        <c:when test="${empty files}">
                            <div class="empty-state">
                                <div class="empty-state-icon">
                                    <i class="fas fa-folder-open"></i>
                                </div>
                                <h4 class="mb-3">No Files Yet</h4>
                                <p class="text-muted mb-4">Upload your first file to get started with secure file sharing.</p>
                                <button class="btn btn-primary btn-lg" data-bs-toggle="modal" data-bs-target="#uploadModal">
                                    <i class="fas fa-cloud-upload-alt me-2"></i> Upload Your First File
                                </button>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="table-responsive">
                                <table id="filesTable" class="table table-hover align-middle">
                                    <thead>
                                        <tr>
                                            <th>File Name</th>
                                            <th>Size</th>
                                            <th>Uploaded</th>
                                            <th>Security</th>
                                            <th>Downloads</th>
                                            <th>Actions</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach var="file" items="${files}">
                                            <tr>
                                                <td>
                                                    <div class="d-flex align-items-center">
                                                        <div class="file-icon 
                                                            <c:choose>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'pdf')}">file-pdf</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'doc')}">file-doc</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'xls')}">file-doc</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'jpg')}">file-img</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'png')}">file-img</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'zip')}">file-zip</c:when>
                                                                <c:when test="${fn:containsIgnoreCase(file.fileType, 'txt')}">file-txt</c:when>
                                                                <c:otherwise>file-default</c:otherwise>
                                                            </c:choose>
                                                            me-3">
                                                            <i class="fas 
                                                                <c:choose>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'pdf')}">fa-file-pdf</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'doc')}">fa-file-word</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'xls')}">fa-file-excel</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'jpg')}">fa-file-image</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'png')}">fa-file-image</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'zip')}">fa-file-archive</c:when>
                                                                    <c:when test="${fn:containsIgnoreCase(file.fileType, 'txt')}">fa-file-alt</c:when>
                                                                    <c:otherwise>fa-file</c:otherwise>
                                                                </c:choose>">
                                                            </i>
                                                        </div>
                                                        <div>
                                                            <span class="fw-bold">${file.originalFilename}</span>
                                                            <c:if test="${not empty file.description}">
                                                                <br>
                                                                <small class="text-muted">${file.description}</small>
                                                            </c:if>
                                                        </div>
                                                    </div>
                                                </td>
                                                <td>
                                                    <fmt:formatNumber value="${file.fileSize / 1024}" pattern="#,##0.00"/> KB
                                                </td>
                                                <td>
                                                    <fmt:formatDate value="${file.uploadDate}" pattern="MMM dd, yyyy"/>
                                                    <br>
                                                    <small class="text-muted">
                                                        <fmt:formatDate value="${file.uploadDate}" pattern="HH:mm:ss"/>
                                                    </small>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${file.encrypted}">
                                                            <span class="badge badge-encrypted mb-1">
                                                                <i class="fas fa-lock me-1"></i>AES-256
                                                            </span>
                                                            <span class="hash-tooltip d-block small text-muted" 
                                                                  title="Original Hash: ${file.fileHash}">
                                                                <i class="fas fa-fingerprint"></i> SHA-256
                                                            </span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge bg-secondary">
                                                                <i class="fas fa-unlock-alt me-1"></i>Unencrypted
                                                            </span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td>
                                                    <span class="fw-bold">${file.accessCount}</span>
                                                    <br>
                                                    <small class="text-muted">downloads</small>
                                                </td>
                                                <td>
                                                    <div class="btn-group" role="group">
                                                        <button type="button" class="btn btn-sm btn-outline-primary action-btn" 
                                                                onclick="downloadFile(${file.fileId}, ${file.encrypted})"
                                                                title="Download">
                                                            <i class="fas fa-download"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-sm btn-outline-info action-btn" 
                                                                onclick="showFileInfo(${file.fileId})"
                                                                title="File Info">
                                                            <i class="fas fa-info-circle"></i>
                                                        </button>
                                                        <button type="button" class="btn btn-sm btn-outline-danger action-btn" 
                                                                onclick="deleteFile(${file.fileId}, '${file.originalFilename}')"
                                                                title="Delete">
                                                            <i class="fas fa-trash"></i>
                                                        </button>
                                                    </div>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                            
                            <!-- Cloud Storage Status -->
                            <div class="mt-4 p-3 bg-light rounded">
                                <div class="d-flex align-items-center">
                                    <i class="fab fa-google-drive fa-2x text-success me-3"></i>
                                    <div>
                                        <h6 class="mb-1">Google Drive Storage</h6>
                                        <p class="mb-0 text-muted small">
                                            <c:choose>
                                                <c:when test="${cloudStorageAvailable}">
                                                    <i class="fas fa-check-circle text-success me-1"></i>
                                                    Connected and ready
                                                </c:when>
                                                <c:otherwise>
                                                    <i class="fas fa-exclamation-triangle text-warning me-1"></i>
                                                    Service unavailable
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Upload Modal (Include from dashboard.jsp) -->
    <!-- ... your existing upload modal ... -->
    
    <!-- File Info Modal -->
    <div class="modal fade" id="fileInfoModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-info-circle me-2"></i>File Information
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body" id="fileInfoContent">
                    <!-- File info will be loaded here -->
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Scripts -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    
    <script>
        $(document).ready(function() {
            // Initialize DataTable
            $('#filesTable').DataTable({
                pageLength: 10,
                order: [[2, 'desc']],
                language: {
                    emptyTable: "No files found",
                    info: "Showing _START_ to _END_ of _TOTAL_ files",
                    infoEmpty: "Showing 0 to 0 of 0 files",
                    search: "Search files:",
                    paginate: {
                        first: "First",
                        last: "Last",
                        next: "Next",
                        previous: "Previous"
                    }
                }
            });
        });
        
        // Show loading overlay
        function showLoading(message) {
            $('#loadingOverlay').fadeIn(200);
            $('#loadingOverlay h5').text(message || 'Processing...');
        }
        
        // Hide loading overlay
        function hideLoading() {
            $('#loadingOverlay').fadeOut(200);
        }
        
        // Download file
        function downloadFile(fileId, isEncrypted) {
            if (isEncrypted) {
                // Redirect to password page for encrypted files
                window.location.href = '${pageContext.request.contextPath}/jsp/user/decrypt-password.jsp?fileId=' + fileId;
            } else {
                // Direct download for unencrypted files
                showLoading('Preparing download...');
                window.location.href = '${pageContext.request.contextPath}/download?fileId=' + fileId;
                setTimeout(hideLoading, 2000);
            }
        }
        
        // Show file information
        function showFileInfo(fileId) {
            showLoading('Loading file information...');
            
            $.ajax({
                url: '${pageContext.request.contextPath}/download',
                type: 'GET',
                data: {
                    fileId: fileId,
                    action: 'verify'
                },
                success: function(response) {
                    hideLoading();
                    if (response.success) {
                        let html = `
                            <div class="row">
                                <div class="col-md-6">
                                    <h6 class="border-bottom pb-2 mb-3">File Details</h6>
                                    <table class="table table-sm">
                                        <tr>
                                            <th>File Name:</th>
                                            <td>\${response.fileName}</td>
                                        </tr>
                                        <tr>
                                            <th>File Size:</th>
                                            <td>\${response.fileSize}</td>
                                        </tr>
                                        <tr>
                                            <th>Upload Date:</th>
                                            <td>\${response.uploadDate}</td>
                                        </tr>
                                        <tr>
                                            <th>Cloud Storage:</th>
                                            <td><span class="badge bg-success">\${response.cloudStorage}</span></td>
                                        </tr>
                                        <tr>
                                            <th>Cloud File ID:</th>
                                            <td><small class="text-muted">\${response.cloudFileId}</small></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <h6 class="border-bottom pb-2 mb-3">Security Details</h6>
                                    <table class="table table-sm">
                                        <tr>
                                            <th>Encryption:</th>
                                            <td>\${response.encrypted ? 
                                                '<span class="badge bg-warning">AES-256 Encrypted</span>' : 
                                                '<span class="badge bg-secondary">Not Encrypted</span>'}
                                            </td>
                                        </tr>
                        `;
                        
                        if (response.encrypted) {
                            html += `
                                        <tr>
                                            <th>Algorithm:</th>
                                            <td>\${response.encryptionAlgorithm || 'AES-256'}</td>
                                        </tr>
                                        <tr>
                                            <th>Original Hash:</th>
                                            <td><small class="font-monospace" style="word-break: break-all;">\${response.originalHash}</small></td>
                                        </tr>
                                        <tr>
                                            <th>Encrypted Hash:</th>
                                            <td><small class="font-monospace" style="word-break: break-all;">\${response.encryptedHash}</small></td>
                                        </tr>
                            `;
                        } else {
                            html += `
                                        <tr>
                                            <th>File Hash:</th>
                                            <td><small class="font-monospace" style="word-break: break-all;">\${response.fileHash}</small></td>
                                        </tr>
                            `;
                        }
                        
                        html += `
                                    </table>
                                </div>
                            </div>
                        `;
                        
                        $('#fileInfoContent').html(html);
                        $('#fileInfoModal').modal('show');
                    } else {
                        showAlert('Failed to load file information: ' + response.message, 'danger');
                    }
                },
                error: function(xhr, status, error) {
                    hideLoading();
                    showAlert('Error loading file information: ' + error, 'danger');
                }
            });
        }
        
        // Delete file
        function deleteFile(fileId, fileName) {
            if (confirm('Are you sure you want to delete "' + fileName + '"? This action cannot be undone.')) {
                showLoading('Deleting file...');
                
                $.ajax({
                    url: '${pageContext.request.contextPath}/delete-file',
                    type: 'POST',
                    data: {
                        fileId: fileId
                    },
                    success: function(response) {
                        hideLoading();
                        if (response.success) {
                            showAlert('File deleted successfully!', 'success');
                            setTimeout(() => {
                                window.location.reload();
                            }, 1500);
                        } else {
                            showAlert('Failed to delete file: ' + response.message, 'danger');
                        }
                    },
                    error: function(xhr, status, error) {
                        hideLoading();
                        showAlert('Error deleting file: ' + error, 'danger');
                    }
                });
            }
        }
        
        // Show alert
        function showAlert(message, type) {
            const alertHtml = `
                <div class="alert alert-\${type} alert-dismissible fade show" role="alert">
                    \${message}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            `;
            $('#alertContainer').html(alertHtml);
            
            setTimeout(() => {
                $('.alert').alert('close');
            }, 5000);
        }
        
        // Format file size
        function formatFileSize(bytes) {
            if (!bytes || bytes === 0) return '0 Bytes';
            const k = 1024;
            const sizes = ['Bytes', 'KB', 'MB', 'GB'];
            const i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }
    </script>
</body>
</html>
