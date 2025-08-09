-- demo_db 생성 및 환경 확인
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;


DROP TABLE IF EXISTS user_activity;
DROP TABLE IF EXISTS test_table;

CREATE TABLE user_activity (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    action_type VARCHAR(50),
    action_time DATETIME,
    description TEXT
) ENGINE=InnoDB;


CREATE TABLE test_table (
	a int not null auto_increment primary key, 
	b varchar(256) default (UUID()), c varchar(256) default (UUID()), d varchar(256) default (UUID()),
	e varchar(256) default (UUID()), f varchar(256) default (UUID()), g varchar(256) default (UUID()),
	h varchar(256) default (UUID()), i varchar(256) default (UUID()), j varchar(256) default (UUID()),
	k varchar(256) default (UUID()), l varchar(256) default (UUID()), m varchar(256) default (UUID()),
	n varchar(256) default (UUID()), o varchar(256) default (UUID()), p varchar(256) default (UUID()),
	q varchar(256) default (UUID()), r varchar(256) default (UUID()), s varchar(256) default (UUID()),
	t varchar(256) default (UUID()), u varchar(256) default (UUID()), v varchar(256) default (UUID()),
	x varchar(256) default (UUID()), y varchar(256) default (UUID()), z varchar(256) default (UUID())		
);


DELIMITER $$
    DROP PROCEDURE IF EXISTS insert_bulk_data;
	CREATE PROCEDURE insert_bulk_data ()
	BEGIN
		DECLARE X INT;
		SET X=1;
		WHILE X <= 1000000 DO
			INSERT INTO test_table() values();
		SET X=X+1;
		END WHILE;
	END$$
DELIMITER ;
-- CALL insert_bulk_data();
-- SELECT count(*) FROM test_table;



-- 현재 활성 트랜잭션 확인
SELECT * FROM information_schema.innodb_trx;

-- undo 로그가 쌓이는 정도를 확인 (SHOW ENGINE)
SHOW ENGINE INNODB STATUS\G



-- 관련 환경변수 확인
SHOW VARIABLES LIKE 'innodb_undo_log_truncate';
SHOW VARIABLES LIKE 'innodb_max_undo_log_size';

-- 주의: 실제 운영 환경에서는 아래 설정 변경 시 재시작이 필요할 수 있음
-- 본 실습에서는 설정 확인 및 이해만 진행


