-- demo_db 생성 및 환경 확인
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;

DROP TABLE IF EXISTS user_activity;

CREATE TABLE user_activity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    action_type VARCHAR(50),
    action_time DATETIME,
    description TEXT
) ENGINE=InnoDB;


-- 현재 활성 트랜잭션 확인
SELECT * FROM information_schema.innodb_trx;

-- undo 로그가 쌓이는 정도를 확인 (SHOW ENGINE)
SHOW ENGINE INNODB STATUS\G



-- 관련 환경변수 확인
SHOW VARIABLES LIKE 'innodb_undo_log_truncate';
SHOW VARIABLES LIKE 'innodb_max_undo_log_size';

-- 주의: 실제 운영 환경에서는 아래 설정 변경 시 재시작이 필요할 수 있음
-- 본 실습에서는 설정 확인 및 이해만 진행



