
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;


-- 1) 분리된 스키마
CREATE SCHEMA IF NOT EXISTS logs;
USE logs;

-- 2) 비교용: 비파티션 로그 테이블(문제 유발용)
DROP TABLE IF EXISTS log_events_raw;
CREATE TABLE log_events_raw (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  created_at DATETIME NOT NULL,
  level ENUM('DEBUG','INFO','WARN','ERROR') NOT NULL,
  service VARCHAR(50) NOT NULL,
  message VARCHAR(255) NOT NULL,
  ctx JSON,
  PRIMARY KEY (id),
  KEY idx_created_at (created_at),
  KEY idx_service_created (service, created_at)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

-- 3) 권장: 월별 파티션 로그 테이블
DROP TABLE IF EXISTS log_events_part;
CREATE TABLE log_events_part (
  id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  created_at DATETIME NOT NULL,
  level ENUM('DEBUG','INFO','WARN','ERROR') NOT NULL,
  service VARCHAR(50) NOT NULL,
  message VARCHAR(255) NOT NULL,
  ctx JSON,
  PRIMARY KEY (id, created_at),           -- 파티션 키 포함
  KEY idx_created_at (created_at),
  KEY idx_service_created (service, created_at)
)
PARTITION BY RANGE COLUMNS (created_at) (
  PARTITION p202501 VALUES LESS THAN ('2025-02-01'),
  PARTITION p202502 VALUES LESS THAN ('2025-03-01'),
  PARTITION p202503 VALUES LESS THAN ('2025-04-01'),
  PARTITION p202504 VALUES LESS THAN ('2025-05-01'),
  PARTITION p202505 VALUES LESS THAN ('2025-06-01'),
  PARTITION p202506 VALUES LESS THAN ('2025-07-01'),
  PARTITION p202507 VALUES LESS THAN ('2025-08-01'),
  PARTITION p202508 VALUES LESS THAN ('2025-09-01'),
  PARTITION pMAX    VALUES LESS THAN (MAXVALUE)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

-- 4) 유틸: 숫자 생성 테이블(빠른 대량 INSERT용)
DROP TABLE IF EXISTS util_numbers;
CREATE TABLE util_numbers (n INT NOT NULL PRIMARY KEY AUTO_INCREMENT) ENGINE=InnoDB;

-- 시드 1개
INSERT INTO util_numbers VALUES (NULL);
-- 2
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 4
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 8
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 16
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 32
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 64
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 128
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 256
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 512
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 1024
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 2048
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 4096
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 8192
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 16384
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 32768
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 65536
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 131072
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 262144
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;
-- 524288
INSERT INTO util_numbers (n) SELECT NULL FROM util_numbers;

-- 이제 util_numbers에는 약 52만여 행 존재
