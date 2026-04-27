<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>OTP Verification - Secure File Sharing</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
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
        
        .otp-card {
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
        
        .otp-header {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 30px;
            text-align: center;
        }
        
        .otp-body {
            padding: 30px;
        }
        
        .otp-display-box {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 20px;
            border-radius: 15px;
            margin-bottom: 25px;
            text-align: center;
            border: 3px dashed rgba(255,255,255,0.3);
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.3);
        }
        
        .otp-code {
            font-size: 56px;
            font-weight: 700;
            letter-spacing: 15px;
            margin: 15px 0;
            font-family: 'Courier New', monospace;
            text-shadow: 0 2px 10px rgba(0,0,0,0.2);
        }
        
        .countdown {
            font-size: 16px;
            font-weight: 600;
            padding: 10px 20px;
            background: rgba(255,255,255,0.2);
            border-radius: 50px;
            display: inline-block;
        }
        
        .email-note {
            background: #e7f3ff;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 25px;
            border-left: 5px solid var(--primary-color);
            box-shadow: 0 4px 12px rgba(67, 97, 238, 0.1);
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 12px;
            padding: 15px;
            font-size: 24px;
            text-align: center;
            letter-spacing: 8px;
            font-family: 'Courier New', monospace;
            font-weight: 600;
            transition: all 0.3s;
        }
        
        .form-control:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
            outline: none;
        }
        
        .btn-verify {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            font-size: 16px;
            transition: all 0.3s;
            margin-bottom: 15px;
        }
        
        .btn-verify:hover:not(:disabled) {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(67, 97, 238, 0.3);
        }
        
        .btn-verify:disabled {
            opacity: 0.7;
            cursor: not-allowed;
        }
        
        .btn-outline {
            border: 2px solid #dee2e6;
            background: white;
            color: #6c757d;
            padding: 12px 20px;
            border-radius: 10px;
            transition: all 0.3s;
            font-weight: 500;
        }
        
        .btn-outline:hover {
            background: #f8f9fa;
            border-color: var(--primary-color);
            color: var(--primary-color);
        }
        
        .btn-resend {
            border: 2px solid var(--warning-color);
            background: white;
            color: var(--warning-color);
            padding: 12px 20px;
            border-radius: 10px;
            transition: all 0.3s;
            font-weight: 500;
        }
        
        .btn-resend:hover:not(:disabled) {
            background: var(--warning-color);
            color: white;
        }
        
        .btn-resend:disabled {
            opacity: 0.6;
            cursor: not-allowed;
            border-color: #6c757d;
            color: #6c757d;
        }
        
        .alert {
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 25px;
        }
        
        .spinner {
            display: inline-block;
            width: 20px;
            height: 20px;
            border: 3px solid rgba(255,255,255,.3);
            border-radius: 50%;
            border-top-color: white;
            animation: spin 1s ease-in-out infinite;
            margin-right: 8px;
            vertical-align: middle;
        }
        
        @keyframes spin {
            to { transform: rotate(360deg); }
        }
        
        .loading-overlay {
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(255,255,255,0.9);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 9999;
            backdrop-filter: blur(3px);
        }
        
        .loading-spinner {
            text-align: center;
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0,0,0,0.2);
        }
        
        .loading-spinner i {
            font-size: 48px;
            color: var(--primary-color);
            margin-bottom: 15px;
        }
        
        .otp-input-group {
            display: flex;
            gap: 10px;
            justify-content: center;
            margin-bottom: 25px;
        }
        
        .otp-digit {
            width: 60px;
            height: 70px;
            border: 2px solid #e9ecef;
            border-radius: 12px;
            text-align: center;
            font-size: 32px;
            font-weight: 700;
            font-family: 'Courier New', monospace;
            transition: all 0.3s;
        }
        
        .otp-digit:focus {
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(67, 97, 238, 0.1);
            outline: none;
        }
        
        .otp-digit.filled {
            border-color: var(--success-color);
            background: #f8fff9;
        }
        
        .timer-warning {
            color: var(--danger-color);
            animation: pulse 1s infinite;
        }
        
        @keyframes pulse {
            0% { opacity: 1; }
            50% { opacity: 0.7; }
            100% { opacity: 1; }
        }
    </style>
</head>
<body>
    <div id="loadingOverlay" class="loading-overlay">
        <div class="loading-spinner">
            <i class="bi bi-arrow-clockwise bi-spin"></i>
            <h5 class="mt-3">Verifying OTP...</h5>
            <p class="text-muted">Please wait while we verify your code</p>
        </div>
    </div>
    
    <div class="otp-card">
        <div class="otp-header">
            <i class="bi bi-shield-lock fs-1 mb-3 d-block"></i>
            <h2 class="mb-2">OTP Verification</h2>
            <p class="mb-0 opacity-75">Enter the verification code sent to your email</p>
        </div>
        
        <div class="otp-body">
            <c:if test="${not empty sessionScope.otp}">
                <div class="otp-display-box">
                    <small class="d-block mb-2 opacity-75">🔐 DEBUG MODE - Your OTP Code</small>
                    <div class="otp-code">${sessionScope.otp}</div>
                    <span class="countdown" id="countdownTimer">
                        <i class="bi bi-clock"></i> Expires in: 10:00
                    </span>
                </div>
            </c:if>
            
            <div class="email-note d-flex align-items-start">
                <i class="bi bi-envelope-fill fs-4 me-3 text-primary"></i>
                <div>
                    <h6 class="mb-1 fw-bold">
                        <i class="bi bi-check-circle-fill text-success me-1"></i>
                        OTP Sent Successfully
                    </h6>
                    <p class="mb-0 small text-muted">
                        We've sent a 6-digit verification code to your registered email address. 
                        The code will expire in 10 minutes.
                    </p>
                </div>
            </div>
            
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="bi bi-exclamation-triangle-fill me-2"></i>
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <c:if test="${not empty success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    <i class="bi bi-check-circle-fill me-2"></i>
                    ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
            
            <form id="otpForm" action="<%= request.getContextPath() %>/auth" method="post" style="display: none;">
                <input type="hidden" name="action" value="verifyOtp">
                <div class="mb-4">
                    <label class="form-label fw-bold">
                        <i class="bi bi-key-fill me-2"></i>Enter 6-digit OTP
                    </label>
                    <input type="text" class="form-control" id="otpInput" 
                           name="otp" maxlength="6" pattern="[0-9]{6}" 
                           placeholder="• • • • • •" required autocomplete="off">
                </div>
                <button type="submit" class="btn-verify" id="verifyBtn">
                    <i class="bi bi-check-circle me-2"></i>Verify & Continue
                </button>
            </form>
            
            <div id="otpDigitsContainer">
                <label class="form-label fw-bold mb-3">
                    <i class="bi bi-key-fill me-2"></i>Enter 6-digit OTP
                </label>
                <div class="otp-input-group">
                    <input type="text" class="otp-digit" id="digit1" maxlength="1" pattern="[0-9]" inputmode="numeric" autofocus>
                    <input type="text" class="otp-digit" id="digit2" maxlength="1" pattern="[0-9]" inputmode="numeric">
                    <input type="text" class="otp-digit" id="digit3" maxlength="1" pattern="[0-9]" inputmode="numeric">
                    <input type="text" class="otp-digit" id="digit4" maxlength="1" pattern="[0-9]" inputmode="numeric">
                    <input type="text" class="otp-digit" id="digit5" maxlength="1" pattern="[0-9]" inputmode="numeric">
                    <input type="text" class="otp-digit" id="digit6" maxlength="1" pattern="[0-9]" inputmode="numeric">
                </div>
            </div>
            
            <div class="d-grid gap-2 mt-4">
                <button type="button" class="btn-verify" id="verifyDigitsBtn" onclick="submitOTPFromDigits()">
                    <i class="bi bi-check-circle me-2"></i>Verify & Continue
                </button>
                
                <div class="row g-2">
                    <div class="col-6">
                        <a href="<%= request.getContextPath() %>/jsp/auth/login.jsp" class="btn btn-outline w-100">
                            <i class="bi bi-arrow-left me-2"></i>Back to Login
                        </a>
                    </div>
                    <div class="col-6">
                        <button type="button" class="btn-resend w-100" onclick="resendOTP()" id="resendBtn">
                            <i class="bi bi-arrow-clockwise me-2"></i>Resend OTP
                        </button>
                    </div>
                </div>
            </div>
            
            <div id="resendMessage" class="text-center mt-3 small text-muted" style="display: none;">
                <i class="bi bi-hourglass-split me-1"></i>
                You can request another OTP in <span id="resendTimer">30</span> seconds
            </div>
            
          
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        var contextPath = '<%= request.getContextPath() %>';
        var countdown = 10 * 60;
        var countdownElement = document.getElementById('countdownTimer');
        var timerInterval;
        
        function updateCountdown() {
            if (!countdownElement) return;
            
            var minutes = Math.floor(countdown / 60);
            var seconds = countdown % 60;
            var secondsStr = seconds < 10 ? '0' + seconds : seconds;
            
            countdownElement.innerHTML = '<i class="bi bi-clock"></i> Expires in: ' + minutes + ':' + secondsStr;
            countdownElement.style.color = '';
            countdownElement.classList.remove('timer-warning');
            
            if (countdown <= 60) {
                countdownElement.classList.add('timer-warning');
            }
            
            if (countdown <= 0) {
                clearInterval(timerInterval);
                countdownElement.innerHTML = '<i class="bi bi-clock"></i> OTP Expired';
                countdownElement.style.color = '#dc3545';
                countdownElement.classList.remove('timer-warning');
                
                for (var i = 1; i <= 6; i++) {
                    var digit = document.getElementById('digit' + i);
                    if (digit) digit.disabled = true;
                }
                
                var verifyBtn = document.getElementById('verifyDigitsBtn');
                if (verifyBtn) {
                    verifyBtn.disabled = true;
                    verifyBtn.innerHTML = '<i class="bi bi-clock-history me-2"></i>OTP Expired';
                }
            }
            
            countdown--;
        }
        
        timerInterval = setInterval(updateCountdown, 1000);
        updateCountdown();
        
        function showLoading() {
            document.getElementById('loadingOverlay').style.display = 'flex';
        }
        
        function hideLoading() {
            document.getElementById('loadingOverlay').style.display = 'none';
        }
        
        document.addEventListener('DOMContentLoaded', function() {
            var digits = [];
            for (var i = 1; i <= 6; i++) {
                digits.push(document.getElementById('digit' + i));
            }
            
            if (digits[0]) {
                digits[0].focus();
            }
            
            for (var i = 0; i < digits.length; i++) {
                (function(index) {
                    var digit = digits[index];
                    if (!digit) return;
                    
                    digit.addEventListener('input', function(e) {
                        var value = e.target.value;
                        
                        if (value && !/^[0-9]$/.test(value)) {
                            e.target.value = '';
                            return;
                        }
                        
                        if (value) {
                            e.target.classList.add('filled');
                            if (index < digits.length - 1) {
                                digits[index + 1].focus();
                            } else {
                                submitOTPFromDigits();
                            }
                        } else {
                            e.target.classList.remove('filled');
                        }
                    });
                    
                    digit.addEventListener('keydown', function(e) {
                        if (e.key === 'Backspace' && !e.target.value) {
                            if (index > 0) {
                                digits[index - 1].focus();
                            }
                        }
                    });
                    
                    digit.addEventListener('paste', function(e) {
                        e.preventDefault();
                        var pastedText = (e.clipboardData || window.clipboardData).getData('text');
                        var otp = pastedText.replace(/\D/g, '');
                        
                        if (otp.length >= 6) {
                            for (var j = 0; j < 6; j++) {
                                if (j < digits.length) {
                                    digits[j].value = otp.charAt(j);
                                    digits[j].classList.add('filled');
                                }
                            }
                            submitOTPFromDigits();
                        }
                    });
                })(i);
            }
            
            window.addEventListener('pageshow', function(event) {
                if (event.persisted) {
                    hideLoading();
                    var resendBtn = document.getElementById('resendBtn');
                    if (resendBtn) {
                        resendBtn.disabled = false;
                        resendBtn.innerHTML = '<i class="bi bi-arrow-clockwise me-2"></i>Resend OTP';
                    }
                    document.getElementById('resendMessage').style.display = 'none';
                }
            });
            
            setTimeout(function() {
                var alerts = document.querySelectorAll('.alert');
                for (var i = 0; i < alerts.length; i++) {
                    if (alerts[i]) {
                        var bsAlert = new bootstrap.Alert(alerts[i]);
                        bsAlert.close();
                    }
                }
            }, 5000);
        });
        
        function submitOTPFromDigits() {
            var otp = '';
            for (var i = 1; i <= 6; i++) {
                var digit = document.getElementById('digit' + i);
                if (digit && digit.value) {
                    otp += digit.value;
                } else {
                    otp += '';
                }
            }
            
            if (otp.length === 6) {
                showLoading();
                
                var verifyBtn = document.getElementById('verifyDigitsBtn');
                verifyBtn.disabled = true;
                verifyBtn.innerHTML = '<span class="spinner"></span>Verifying...';
                
                var form = document.createElement('form');
                form.method = 'POST';
                form.action = contextPath + '/auth';
                
                var actionInput = document.createElement('input');
                actionInput.type = 'hidden';
                actionInput.name = 'action';
                actionInput.value = 'verifyOtp';
                
                var otpInput = document.createElement('input');
                otpInput.type = 'hidden';
                otpInput.name = 'otp';
                otpInput.value = otp;
                
                form.appendChild(actionInput);
                form.appendChild(otpInput);
                document.body.appendChild(form);
                
                form.submit();
            } else {
                alert('Please enter all 6 digits of the OTP');
            }
        }
        
        function resendOTP() {
            var btn = document.getElementById('resendBtn');
            btn.disabled = true;
            btn.innerHTML = '<span class="spinner"></span>Sending...';
            
            var resendMessage = document.getElementById('resendMessage');
            resendMessage.style.display = 'block';
            var resendTimer = 30;
            
            var timerInterval = setInterval(function() {
                resendTimer--;
                document.getElementById('resendTimer').innerHTML = resendTimer;
                
                if (resendTimer <= 0) {
                    clearInterval(timerInterval);
                    resendMessage.style.display = 'none';
                    btn.disabled = false;
                    btn.innerHTML = '<i class="bi bi-arrow-clockwise me-2"></i>Resend OTP';
                }
            }, 1000);
            
            var xhr = new XMLHttpRequest();
            xhr.open('POST', contextPath + '/auth', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    if (xhr.status === 200) {
                        location.reload();
                    } else {
                        alert('Failed to resend OTP. Please try again.');
                        clearInterval(timerInterval);
                        resendMessage.style.display = 'none';
                        btn.disabled = false;
                        btn.innerHTML = '<i class="bi bi-arrow-clockwise me-2"></i>Resend OTP';
                    }
                }
            };
            xhr.send('action=resendOtp');
        }
        
        function showAlert(message, type) {
            var alertHtml = '<div class="alert alert-' + type + ' alert-dismissible fade show" role="alert">' +
                '<i class="bi bi-' + (type === 'success' ? 'check-circle' : 'exclamation-triangle') + '-fill me-2"></i>' +
                message +
                '<button type="button" class="btn-close" data-bs-dismiss="alert"></button>' +
                '</div>';
            
            var otpBody = document.querySelector('.otp-body');
            otpBody.insertAdjacentHTML('afterbegin', alertHtml);
            
            setTimeout(function() {
                var alerts = document.querySelectorAll('.alert');
                for (var i = 0; i < alerts.length; i++) {
                    var alert = alerts[i];
                    if (alert) {
                        var bsAlert = new bootstrap.Alert(alert);
                        bsAlert.close();
                    }
                }
            }, 5000);
        }
    </script>
</body>
</html>