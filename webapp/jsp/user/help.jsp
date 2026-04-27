
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Help & Support - Secure File Sharing</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            min-height: 100vh;
            padding: 40px 20px;
        }
        .help-card {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.3);
            overflow: hidden;
        }
        .help-header {
            background: linear-gradient(135deg, #4361ee, #3f37c9);
            color: white;
            padding: 30px;
            text-align: center;
        }
        .help-body {
            padding: 30px;
        }
        .section-title {
            color: #4361ee;
            border-bottom: 2px solid #e9ecef;
            padding-bottom: 10px;
            margin-bottom: 20px;
        }
        .faq-item {
            margin-bottom: 15px;
            border: 1px solid #e9ecef;
            border-radius: 10px;
            overflow: hidden;
        }
        .faq-question {
            background: #f8f9fa;
            padding: 15px 20px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .faq-question:hover {
            background: #e9ecef;
        }
        .faq-answer {
            padding: 20px;
            display: none;
            border-top: 1px solid #e9ecef;
        }
        .contact-box {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            text-align: center;
        }
        .back-link {
            color: white;
            text-decoration: none;
            display: inline-block;
            margin-top: 20px;
        }
        .back-link:hover {
            text-decoration: underline;
        }
        .contact-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            height: 100%;
            transition: transform 0.3s;
            border: 1px solid #e9ecef;
        }
        .contact-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            border-color: #4361ee;
        }
        .contact-icon {
            width: 70px;
            height: 70px;
            background: linear-gradient(135deg, #4361ee, #3f37c9);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            margin: 0 auto 20px;
        }
        .contact-value {
            font-size: 18px;
            font-weight: 600;
            color: #333;
            margin: 10px 0;
        }
        .contact-label {
            color: #6c757d;
            font-size: 14px;
            margin-bottom: 15px;
        }
        .btn-contact {
            padding: 10px 25px;
            border-radius: 50px;
            transition: all 0.3s;
        }
        .btn-contact:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(67, 97, 238, 0.3);
        }
    </style>
</head>
<body>
    <div class="help-card">
        <div class="help-header">
            <i class="fas fa-headset fa-4x mb-3"></i>
            <h2>Help & Support</h2>
            <p class="mb-0">We're here to assist you</p>
        </div>
        
        <div class="help-body">
            <!-- Quick Links -->
            <h4 class="section-title">
                <i class="fas fa-compass me-2"></i>Quick Links
            </h4>
            <div class="row mb-4">
                <div class="col-md-4 mb-3">
                    <div class="card text-center h-100">
                        <div class="card-body">
                            <i class="fas fa-cloud-upload-alt fa-2x text-primary mb-3"></i>
                            <h6>Upload Files</h6>
                            <a href="${pageContext.request.contextPath}/jsp/user/upload.jsp" class="btn btn-sm btn-outline-primary">Go to Upload</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card text-center h-100">
                        <div class="card-body">
                            <i class="fas fa-share-alt fa-2x text-success mb-3"></i>
                            <h6>Share Files</h6>
                            <a href="${pageContext.request.contextPath}/shared" class="btn btn-sm btn-outline-success">Go to Sharing</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-4 mb-3">
                    <div class="card text-center h-100">
                        <div class="card-body">
                            <i class="fas fa-shield-alt fa-2x text-warning mb-3"></i>
                            <h6>Security</h6>
                            <a href="${pageContext.request.contextPath}/security" class="btn btn-sm btn-outline-warning">View Security</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- FAQ Section -->
            <h4 class="section-title">
                <i class="fas fa-question-circle me-2"></i>Frequently Asked Questions
            </h4>
            
            <div class="faq-item">
                <div class="faq-question" onclick="toggleFAQ(this)">
                    <span>How do I upload a file?</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    Click on "Upload Files" in the sidebar, select your file, and click "Upload". 
                    You can choose to encrypt the file with a password for extra security.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question" onclick="toggleFAQ(this)">
                    <span>How do I share a file with someone?</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    Go to "Shared Files" → "Shared By Me" → "Share New File". Enter the recipient's email,
                    set permissions, and click "Share File". The recipient will get an email notification.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question" onclick="toggleFAQ(this)">
                    <span>What if I forget my encryption password?</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    <strong>Important:</strong> Encryption passwords cannot be recovered! 
                    They are never stored on our servers. Always save your passwords in a 
                    password manager or write them down securely.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question" onclick="toggleFAQ(this)">
                    <span>Is my data really secure?</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    Yes! All files are encrypted with AES-256 before upload. Google Drive only 
                    stores encrypted data. Without your password, even Google cannot read your files.
                </div>
            </div>
            
            <div class="faq-item">
                <div class="faq-question" onclick="toggleFAQ(this)">
                    <span>What's the maximum file size?</span>
                    <i class="fas fa-chevron-down"></i>
                </div>
                <div class="faq-answer">
                    Maximum file size is 5GB per file. This is due to Google Drive limitations.
                </div>
            </div>
            
            <!-- Contact Support - Phone & Email Only (No Buttons) -->
            <h4 class="section-title mt-4">
                <i class="fas fa-headset me-2"></i>Contact Us
            </h4>
            
            <div class="row">
                <div class="col-md-6 mb-4">
                    <div class="contact-card text-center">
                        <div class="contact-icon">
                            <i class="fas fa-envelope"></i>
                        </div>
                        <h5>Email Support</h5>
                        <p class="contact-value">securefilesharee@gmail.com</p>
                        <p class="contact-label">We'll respond within 24 hours</p>
                        <!-- Button removed - just displaying the email -->
                    </div>
                </div>
                
                <div class="col-md-6 mb-4">
                    <div class="contact-card text-center">
                        <div class="contact-icon">
                            <i class="fas fa-phone-alt"></i>
                        </div>
                        <h5>Phone Support</h5>
                        <p class="contact-value">+1 (800) 123-4567</p>
                        <p class="contact-label">Toll-free</p>
                        <!-- Button removed - just displaying the phone number -->
                    </div>
                </div>
            </div>
            
            <!-- Back to Dashboard -->
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/dashboard" class="btn btn-outline-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>
    </div>
    
    <script>
        function toggleFAQ(element) {
            var answer = element.nextElementSibling;
            var icon = element.querySelector('i');
            
            if (answer.style.display === 'block') {
                answer.style.display = 'none';
                icon.className = 'fas fa-chevron-down';
            } else {
                answer.style.display = 'block';
                icon.className = 'fas fa-chevron-up';
            }
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>