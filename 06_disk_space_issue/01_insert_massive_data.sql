
-- demo_db 생성 및 환경 확인
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE demo_db;

-- 대량 데이터 삽입을 위한 로그 테이블 생성
CREATE TABLE logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    log_type VARCHAR(50),
    message TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;


-- logs 테이블에 대용량 더미 데이터 삽입 (1백만 건)
INSERT INTO logs (log_type, message)
SELECT 
    CASE 
        WHEN RAND() < 0.5 THEN 'INFO' 
        ELSE 'ERROR' 
    END,
    REPEAT('Sample log message. ', 10)
FROM information_schema.columns AS a,
     information_schema.columns AS b
LIMIT 1000000;

