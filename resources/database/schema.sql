-- MySQL Database Schema for Secure File Sharing System

CREATE DATABASE IF NOT EXISTS securefileshare;
USE securefileshare;

-- Users table
CREATE TABLE users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role ENUM('USER', 'ADMIN') DEFAULT 'USER',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP NULL,
    trusted_devices TEXT,
    trusted_ips TEXT
);

-- OTP table for MFA
CREATE TABLE otp_store (
    otp_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    otp_code VARCHAR(6) NOT NULL,
    generated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP,
    is_used BOOLEAN DEFAULT FALSE,
    purpose VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_otp_user (user_id),
    INDEX idx_otp_expiry (expires_at)
);

-- File metadata table
CREATE TABLE file_metadata (
    file_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    original_filename VARCHAR(255) NOT NULL,
    stored_filename VARCHAR(255) NOT NULL,
    file_hash VARCHAR(64) NOT NULL,
    file_size BIGINT NOT NULL,
    file_type VARCHAR(100),
    description TEXT,
    encryption_key TEXT,
    iv VARCHAR(24) NOT NULL,
    salt VARCHAR(24),
    cloud_file_id VARCHAR(255),
    cloudme_path VARCHAR(500),
    is_sensitive BOOLEAN DEFAULT FALSE,
    is_encrypted BOOLEAN DEFAULT TRUE,
    is_deleted BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP NULL,
    access_expiry TIMESTAMP NULL,
    upload_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    access_count INT DEFAULT 0,
    download_count INT DEFAULT 0,
    max_downloads INT DEFAULT -1,
    sha256_hash VARCHAR(64),
    sha256_encrypted_hash VARCHAR(64),
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_file_user (user_id),
    INDEX idx_file_expiry (access_expiry)
);

-- File versions table
CREATE TABLE file_versions (
    version_id INT PRIMARY KEY AUTO_INCREMENT,
    file_id INT,
    version_number INT NOT NULL,
    version_data LONGBLOB,
    comment VARCHAR(255),
    created_by INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    file_size BIGINT,
    is_current BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (file_id) REFERENCES file_metadata(file_id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- File shares table
CREATE TABLE file_shares (
    share_id VARCHAR(50) PRIMARY KEY,
    file_id INT,
    shared_by_user_id INT,
    shared_with_email VARCHAR(100),
    permission ENUM('VIEW', 'DOWNLOAD', 'EDIT') DEFAULT 'VIEW',
    share_token VARCHAR(100) UNIQUE,
    share_password_hash VARCHAR(255),
    expiry_date TIMESTAMP NULL,
    max_downloads INT DEFAULT 0,
    download_count INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    is_active BOOLEAN DEFAULT TRUE,
    last_accessed TIMESTAMP NULL,
    FOREIGN KEY (file_id) REFERENCES file_metadata(file_id) ON DELETE CASCADE,
    FOREIGN KEY (shared_by_user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    INDEX idx_share_token (share_token)
);

-- Access logs table
CREATE TABLE access_logs (
    log_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    file_id INT,
    action_type VARCHAR(20),
    description TEXT,
    ip_address VARCHAR(45),
    status VARCHAR(20),
    access_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE SET NULL,
    FOREIGN KEY (file_id) REFERENCES file_metadata(file_id) ON DELETE SET NULL,
    INDEX idx_log_user (user_id),
    INDEX idx_log_file (file_id),
    INDEX idx_log_time (access_time)
);

-- Trash items table
CREATE TABLE trash_items (
    trash_id INT PRIMARY KEY AUTO_INCREMENT,
    file_id INT,
    original_filename VARCHAR(255) NOT NULL,
    file_size BIGINT,
    deleted_by INT,
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    cloud_file_id VARCHAR(255),
    FOREIGN KEY (file_id) REFERENCES file_metadata(file_id) ON DELETE CASCADE,
    FOREIGN KEY (deleted_by) REFERENCES users(user_id) ON DELETE SET NULL
);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, email, password_hash, first_name, last_name, role) 
VALUES ('admin', 'admin@securefileshare.com', 
        '$2a$10$N9qo8uLOickgx2ZMRZoMye.K/.Kv9Qr7f6Z.Bp8K4VvJ4i6YdJQlW',
        'System', 'Administrator', 'ADMIN');