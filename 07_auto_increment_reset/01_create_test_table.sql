-- demo_db 생성 및 환경 확인
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;


CREATE TABLE IF NOT EXISTS user_test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

INSERT INTO user_test (name) VALUES ('홍길동'), ('이순신'), ('강감찬');
