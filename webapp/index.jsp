<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Secure File Sharing System | AES-256 Encryption & Integrity Verification</title>
    
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <!-- Font Awesome Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Roboto+Mono:wght@400;500&display=swap" rel="stylesheet">
    
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #e74c3c;
            --light-color: #ecf0f1;
            --dark-color: #2c3e50;
            --success-color: #27ae60;
            --warning-color: #f39c12;
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: var(--light-color);
            min-height: 100vh;
            overflow-x: hidden;
        }
        
        .navbar-brand {
            font-family: 'Roboto Mono', monospace;
            font-weight: 700;
            font-size: 1.8rem;
            color: var(--light-color) !important;
        }
        
        .navbar-brand i {
            color: var(--secondary-color);
            margin-right: 10px;
        }
        
        .hero-section {
            padding: 100px 0 80px;
            background: rgba(0, 0, 0, 0.7);
            position: relative;
            overflow: hidden;
        }
        
        .hero-section::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,0 L100,0 L100,100 Z" fill="rgba(44, 62, 80, 0.1)"/></svg>');
            background-size: cover;
            z-index: 0;
        }
        
        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 20px;
            background: linear-gradient(to right, #3498db, #2ecc71);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        }
        
        .hero-subtitle {
            font-size: 1.3rem;
            margin-bottom: 30px;
            opacity: 0.9;
            max-width: 600px;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            height: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.3);
        }
        
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 20px;
            color: var(--secondary-color);
        }
        
        .feature-title {
            font-size: 1.5rem;
            margin-bottom: 15px;
            color: var(--light-color);
        }
        
        .feature-description {
            font-size: 1rem;
            opacity: 0.8;
            line-height: 1.6;
        }
        
        .auth-buttons {
            margin-top: 40px;
            position: relative;
            z-index: 100;
        }
        
        .btn-custom {
            padding: 12px 30px;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            margin: 0 10px 10px 0;
            text-decoration: none;
            display: inline-block;
            cursor: pointer;
        }
        
        .btn-login {
            background: linear-gradient(135deg, #3498db, #2980b9);
            border: none;
            color: white;
        }
        
        .btn-login:hover {
            background: linear-gradient(135deg, #2980b9, #1f6392);
            transform: scale(1.05);
            box-shadow: 0 5px 15px rgba(52, 152, 219, 0.4);
            color: white;
            text-decoration: none;
        }
        
        .btn-register {
            background: transparent;
            border: 2px solid var(--light-color);
            color: var(--light-color);
        }
        
        .btn-register:hover {
            background: rgba(255, 255, 255, 0.1);
            transform: scale(1.05);
            color: var(--light-color);
            text-decoration: none;
        }
        
        .security-badge {
            display: inline-block;
            padding: 5px 15px;
            background: rgba(231, 76, 60, 0.2);
            border: 1px solid rgba(231, 76, 60, 0.4);
            border-radius: 20px;
            font-size: 0.9rem;
            margin: 5px;
            color: #ffcccc;
        }
        
        .stats-section {
            padding: 80px 0;
            background: rgba(44, 62, 80, 0.9);
        }
        
        .stat-item {
            text-align: center;
            padding: 30px;
        }
        
        .stat-number {
            font-size: 3rem;
            font-weight: 800;
            color: var(--secondary-color);
            margin-bottom: 10px;
        }
        
        .stat-label {
            font-size: 1.2rem;
            opacity: 0.9;
        }
        
        .how-it-works {
            padding: 80px 0;
            background: rgba(0, 0, 0, 0.8);
        }
        
        .step-card {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            padding: 25px;
            margin-bottom: 20px;
            position: relative;
            border-left: 4px solid var(--secondary-color);
        }
        
        .step-number {
            position: absolute;
            top: -15px;
            left: -15px;
            width: 40px;
            height: 40px;
            background: var(--secondary-color);
            color: white;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
        }
        
        .footer {
            background: rgba(0, 0, 0, 0.95);
            padding: 40px 0;
            margin-top: 60px;
        }
        
        .footer-title {
            font-size: 1.5rem;
            margin-bottom: 20px;
            color: var(--secondary-color);
        }
        
        .footer-links {
            list-style: none;
            padding: 0;
        }
        
        .footer-links li {
            margin-bottom: 10px;
        }
        
        .footer-links a {
            color: var(--light-color);
            text-decoration: none;
            opacity: 0.8;
            transition: opacity 0.3s;
        }
        
        .footer-links a:hover {
            opacity: 1;
            color: var(--secondary-color);
        }
        
        .copyright {
            text-align: center;
            padding-top: 20px;
            margin-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            opacity: 0.7;
        }
        
        .animated-text {
            background: linear-gradient(90deg, #3498db, #2ecc71, #3498db);
            background-size: 200% auto;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            animation: gradient 3s linear infinite;
        }
        
        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        
        .floating {
            animation: floating 3s ease-in-out infinite;
            position: relative;
            z-index: 1;
        }
        
        @keyframes floating {
            0% { transform: translateY(0px); }
            50% { transform: translateY(-15px); }
            100% { transform: translateY(0px); }
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .hero-title {
                font-size: 2.5rem;
            }
            
            .hero-subtitle {
                font-size: 1.1rem;
            }
            
            .feature-card {
                padding: 20px;
            }
            
            .btn-custom {
                padding: 10px 20px;
                font-size: 1rem;
                display: block;
                width: 200px;
                margin-bottom: 15px;
            }
            
            .auth-buttons {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }
        }
        
        /* Alert Messages */
        .alert-container {
            position: fixed;
            top: 80px;
            right: 20px;
            z-index: 9999;
            width: 300px;
        }
        
        /* Demo Section */
        .demo-section {
            padding: 60px 0;
            background: linear-gradient(rgba(44, 62, 80, 0.9), rgba(44, 62, 80, 0.95));
        }
        
        .demo-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            height: 100%;
        }
        
        .demo-card:hover {
            background: rgba(255, 255, 255, 0.15);
            transform: translateY(-5px);
        }
        
        .demo-icon {
            font-size: 2.5rem;
            color: var(--secondary-color);
            margin-bottom: 20px;
        }
        
        /* Fix for z-index issues */
        .hero-section {
            position: relative;
            z-index: 0;
        }
        
        .navbar {
            position: relative;
            z-index: 1000;
        }
        
        .auth-buttons a {
            position: relative;
            z-index: 100;
        }
        
        /* Button click fix */
        a.btn-custom {
            position: relative;
            z-index: 10;
        }
        
        /* Ensure buttons are clickable */
        .btn-custom, .btn-custom:focus, .btn-custom:active {
            outline: none;
            box-shadow: none;
        }
    </style>
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="fas fa-shield-alt"></i> SecureShare
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="#home">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#how-it-works">How It Works</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#demo">Demo</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#contact">Contact</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <section id="home" class="hero-section">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6">
                    <h1 class="hero-title animated-text">
                        Secure File Sharing <br>with Military-Grade Encryption
                    </h1>
                    <p class="hero-subtitle">
                        Share your sensitive files with confidence using AES-256 encryption, 
                        SHA-256 integrity verification, and OTP-based multi-factor authentication.
                    </p>
                    
                    <div class="mb-4">
                        <span class="security-badge"><i class="fas fa-lock"></i> AES-256</span>
                        <span class="security-badge"><i class="fas fa-fingerprint"></i> SHA-256 Hash</span>
                        <span class="security-badge"><i class="fas fa-shield-alt"></i> OTP MFA</span>
                        <span class="security-badge"><i class="fas fa-clock"></i> Time-bound Access</span>
                    </div>
                    
                    <div class="auth-buttons">
                        <!-- Fixed Login Button -->
                        <a href="<%= request.getContextPath() %>/jsp/auth/login.jsp" 
                           class="btn btn-login btn-custom">
                            <i class="fas fa-sign-in-alt"></i> Login
                        </a>
                        <!-- Fixed Register Button -->
                        <a href="<%= request.getContextPath() %>/jsp/auth/register.jsp" 
                           class="btn btn-register btn-custom">
                            <i class="fas fa-user-plus"></i> Register
                        </a>
                    </div>
                </div>
                
                <div class="col-lg-6 text-center">
                    <div class="floating">
                        <img src="https://cdn-icons-png.flaticon.com/512/3067/3067256.png" 
                             alt="Secure File Sharing" 
                             class="img-fluid" 
                             style="max-width: 500px; filter: drop-shadow(0 10px 20px rgba(0,0,0,0.3));">
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="py-5">
        <div class="container">
            <div class="row mb-5">
                <div class="col-12 text-center">
                    <h2 class="display-4 mb-3">Security Features</h2>
                    <p class="lead">Enterprise-grade security for your sensitive files</p>
                </div>
            </div>
            
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <h3 class="feature-title">Client-Side Encryption</h3>
                        <p class="feature-description">
                            Files are encrypted with AES-256 algorithm on your device before upload. 
                            Only encrypted data reaches our servers.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-fingerprint"></i>
                        </div>
                        <h3 class="feature-title">Integrity Verification</h3>
                        <p class="feature-description">
                            SHA-256 hash verification ensures files haven't been tampered with. 
                            Any alteration is immediately detected during download.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-shield-alt"></i>
                        </div>
                        <h3 class="feature-title">OTP MFA Protection</h3>
                        <p class="feature-description">
                            One-Time Password verification for sensitive files and new devices. 
                            Adds an extra layer of security for critical documents.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-clock"></i>
                        </div>
                        <h3 class="feature-title">Time-Bound Access</h3>
                        <p class="feature-description">
                            Set expiration times for file access. After expiry, encryption keys 
                            are automatically invalidated.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-history"></i>
                        </div>
                        <h3 class="feature-title">Complete Audit Trail</h3>
                        <p class="feature-description">
                            Every upload, download, and access attempt is logged with 
                            timestamp, IP address, and device information.
                        </p>
                    </div>
                </div>
                
                <div class="col-lg-4 col-md-6">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-user-shield"></i>
                        </div>
                        <h3 class="feature-title">Zero-Knowledge Architecture</h3>
                        <p class="feature-description">
                            We never have access to your encryption keys or unencrypted files. 
                            You control all security parameters.
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- How It Works Section -->
    <section id="how-it-works" class="how-it-works">
        <div class="container">
            <div class="row mb-5">
                <div class="col-12 text-center">
                    <h2 class="display-4 mb-3">How It Works</h2>
                    <p class="lead">Secure file sharing in 4 simple steps</p>
                </div>
            </div>
            
            <div class="row">
                <div class="col-lg-3 col-md-6">
                    <div class="step-card">
                        <div class="step-number">1</div>
                        <h4>Upload & Encrypt</h4>
                        <p>Select your file. Our system generates a unique AES-256 key and encrypts the file on your device.</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="step-card">
                        <div class="step-number">2</div>
                        <h4>Generate Hash</h4>
                        <p>A SHA-256 hash is created from the original file for integrity verification.</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="step-card">
                        <div class="step-number">3</div>
                        <h4>Secure Storage</h4>
                        <p>Only the encrypted file is uploaded to cloud storage. Encryption keys are stored securely in database.</p>
                    </div>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <div class="step-card">
                        <div class="step-number">4</div>
                        <h4>Download & Verify</h4>
                        <p>Download the encrypted file, decrypt it locally, and verify integrity with the stored hash.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Demo Section -->
    <section id="demo" class="demo-section">
        <div class="container">
            <div class="row mb-5">
                <div class="col-12 text-center">
                    <h2 class="display-4 mb-3">Try It Out</h2>
                    <p class="lead">Experience secure file sharing in action</p>
                </div>
            </div>
            
            <div class="row">
                <div class="col-md-4">
                    <div class="demo-card">
                        <div class="demo-icon">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <h4>Create Account</h4>
                        <p>Register with your email to get started. No personal information required.</p>
                        <a href="<%= request.getContextPath() %>/jsp/auth/register.jsp" 
                           class="btn btn-outline-light mt-3">
                            Sign Up Free
                        </a>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="demo-card">
                        <div class="demo-icon">
                            <i class="fas fa-cloud-upload-alt"></i>
                        </div>
                        <h4>Upload Securely</h4>
                        <p>Upload any file up to 5GB. Watch it get encrypted before leaving your device.</p>
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <a href="<%= request.getContextPath() %>/jsp/user/upload.jsp" 
                                   class="btn btn-outline-light mt-3">
                                    Upload Files
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="<%= request.getContextPath() %>/jsp/auth/login.jsp" 
                                   class="btn btn-outline-light mt-3">
                                    Login to Upload
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div class="col-md-4">
                    <div class="demo-card">
                        <div class="demo-icon">
                            <i class="fas fa-shield-check"></i>
                        </div>
                        <h4>Verify Security</h4>
                        <p>Check the audit logs to see how your files are protected at every step.</p>
                        <c:choose>
                            <c:when test="${not empty sessionScope.user}">
                                <a href="<%= request.getContextPath() %>/dashboard" 
                                   class="btn btn-outline-light mt-3">
                                    View Dashboard
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="<%= request.getContextPath() %>/jsp/auth/login.jsp" 
                                   class="btn btn-outline-light mt-3">
                                    Login to View
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="row">
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-number" data-count="256">0</div>
                        <div class="stat-label">Bit Encryption</div>
                    </div>
                </div>
                
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-number" data-count="5">0</div>
                        <div class="stat-label">GB Max File Size</div>
                    </div>
                </div>
                
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-number" data-count="99">0</div>
                        <div class="stat-label">% Uptime</div>
                    </div>
                </div>
                
                <div class="col-md-3 col-6">
                    <div class="stat-item">
                        <div class="stat-number" data-count="0">0</div>
                        <div class="stat-label">Security Breaches</div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer id="contact" class="footer">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <h3 class="footer-title">
                        <i class="fas fa-shield-alt"></i> SecureShare
                    </h3>
                    <p class="mb-4">
                        A secure file sharing platform with end-to-end encryption, 
                        integrity verification, and multi-factor authentication.
                    </p>
                    <div class="social-icons">
                        <a href="#" class="text-light me-3"><i class="fab fa-twitter fa-lg"></i></a>
                        <a href="#" class="text-light me-3"><i class="fab fa-github fa-lg"></i></a>
                        <a href="#" class="text-light me-3"><i class="fab fa-linkedin fa-lg"></i></a>
                        <a href="#" class="text-light"><i class="fab fa-youtube fa-lg"></i></a>
                    </div>
                </div>
                
                <div class="col-lg-2 col-md-6">
                    <h4 class="footer-title">Quick Links</h4>
                    <ul class="footer-links">
                        <li><a href="#home">Home</a></li>
                        <li><a href="#features">Features</a></li>
                        <li><a href="#how-it-works">How It Works</a></li>
                        <li><a href="#demo">Demo</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <h4 class="footer-title">Security Features</h4>
                    <ul class="footer-links">
                        <li><a href="#">AES-256 Encryption</a></li>
                        <li><a href="#">SHA-256 Hashing</a></li>
                        <li><a href="#">OTP MFA</a></li>
                        <li><a href="#">Audit Logging</a></li>
                    </ul>
                </div>
                
                <div class="col-lg-3 col-md-6">
                    <h4 class="footer-title">Contact Info</h4>
                    <ul class="footer-links">
                        <li><i class="fas fa-envelope me-2"></i> support@secureshare.com</li>
                        <li><i class="fas fa-phone me-2"></i> +1 (555) 123-4567</li>
                        <li><i class="fas fa-map-marker-alt me-2"></i> Security Tower, Cyber City</li>
                    </ul>
                </div>
            </div>
            
            <div class="row mt-5">
                <div class="col-12">
                    <div class="copyright">
                        <p>&copy; 2026 Secure File Sharing System. All rights reserved. | 
                        <span class="text-info">AES-256 Encryption | SHA-256 Integrity | OTP MFA Authentication</span></p>
                    </div>
                </div>
            </div>
        </div>
    </footer>

    <!-- Alert Container for Messages -->
    <div class="alert-container">
        <c:if test="${not empty success}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fas fa-check-circle"></i> ${success}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
        
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fas fa-exclamation-triangle"></i> ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>
    </div>

    <!-- Bootstrap JS Bundle with Popper -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    
    <!-- Custom JavaScript -->
    <script>
        $(document).ready(function() {
            // Smooth scrolling for navigation links
            $('a.nav-link').on('click', function(event) {
                if (this.hash !== "") {
                    event.preventDefault();
                    var hash = this.hash;
                    $('html, body').animate({
                        scrollTop: $(hash).offset().top - 70
                    }, 800);
                }
            });
            
            // Animate stats counter
            $('.stat-number').each(function() {
                var $this = $(this);
                var countTo = $this.attr('data-count');
                $({ countNum: 0 }).animate({
                    countNum: countTo
                }, {
                    duration: 2000,
                    easing: 'swing',
                    step: function() {
                        $this.text(Math.floor(this.countNum));
                    },
                    complete: function() {
                        $this.text(this.countNum);
                    }
                });
            });
            
            // Auto-dismiss alerts after 5 seconds
            setTimeout(function() {
                $('.alert').alert('close');
            }, 5000);
            
            // Add active class to current nav item
            var scrollPos = $(document).scrollTop();
            $('nav a').each(function() {
                var currLink = $(this);
                var refElement = $(currLink.attr("href"));
                if (refElement.length && 
                    refElement.position().top <= scrollPos + 100 &&
                    refElement.position().top + refElement.height() > scrollPos) {
                    $('nav ul li a').removeClass("active");
                    currLink.addClass("active");
                }
            });
            
            // Parallax effect for hero section
            $(window).scroll(function() {
                var scrolled = $(window).scrollTop();
                $('.hero-section').css('background-position', 'center ' + (scrolled * 0.5) + 'px');
            });
            
            // Ensure all buttons are clickable
            $('.btn-custom').on('click', function(e) {
                console.log('Button clicked:', $(this).attr('href'));
                // Allow default navigation to happen
            });
            
            // Debug: Log all button clicks
            $('a').on('click', function(e) {
                console.log('Link clicked:', $(this).attr('href'));
            });
        });
        
        // File size format helper
        function formatFileSize(bytes) {
            if (bytes === 0) return '0 Bytes';
            var k = 1024;
            var sizes = ['Bytes', 'KB', 'MB', 'GB'];
            var i = Math.floor(Math.log(bytes) / Math.log(k));
            return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + ' ' + sizes[i];
        }
    </script>
</body>
</html>