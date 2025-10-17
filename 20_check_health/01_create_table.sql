-- 20_check_health.sql
-- 점검 데이터 저장용 DB와 테이블 생성

CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;

CREATE TABLE IF NOT EXISTS check_history (
  id            BIGINT AUTO_INCREMENT PRIMARY KEY,
  check_time    DATETIME NOT NULL,
  threads_conn  INT NOT NULL,
  slow_queries  BIGINT NOT NULL,
  top_table     VARCHAR(200),
  top_table_mb  INT,
  no_index_cnt  INT
);

-- 확인용 샘플 조회
SELECT * FROM check_history ORDER BY id DESC LIMIT 5;

