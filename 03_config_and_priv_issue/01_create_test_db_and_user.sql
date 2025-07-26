-- 테스트용 DB 및 서비스 계정 생성
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER 'svc_api'@'localhost' IDENTIFIED BY 'P@ssw0rd';



