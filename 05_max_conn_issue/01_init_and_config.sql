-- demo_db 생성 및 환경 확인
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;

-- 현재 max_connections 값 확인
SHOW VARIABLES LIKE 'max_connections';

-- 테스트용 사용자 생성
CREATE USER IF NOT EXISTS 'conn_test'@'%' IDENTIFIED BY 'P@ssw0rd';
GRANT ALL PRIVILEGES ON demo_db.* TO 'conn_test'@'%';
FLUSH PRIVILEGES;
