USE demo_db;

-- 100만 건의 더미 데이터를 입력
-- (10000건 * 100회 → 빠르게 입력되도록 루프 형태로 작성)
DELIMITER $$

DROP PROCEDURE IF EXISTS insert_dummy_activity;
CREATE PROCEDURE insert_dummy_activity()
BEGIN
    DECLARE i INT DEFAULT 0;
    WHILE i < 100 DO
        INSERT INTO user_activity (user_id, action_type, action_time, description)
        SELECT 
            FLOOR(RAND() * 10000),
            ELT(FLOOR(1 + (RAND() * 4)), 'LOGIN', 'LOGOUT', 'CLICK', 'VIEW'),
            NOW(),
            RPAD('test action', 100, '#')
        FROM seq_1_to_10000;
        SET i = i + 1;
    END WHILE;
END$$

DELIMITER ;


-- 유틸용 시퀀스 테이블 생성 (1~10000)
DROP TABLE IF EXISTS seq_1_to_10000;

CREATE TABLE seq_1_to_10000 (n INT PRIMARY KEY);

INSERT INTO seq_1_to_10000 (n)
SELECT a.N + b.N * 10 + 1
FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
      UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a,
     (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 
      UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b;

CALL insert_dummy_activity();



-- 데이터 입력 후 건수 확인
SELECT COUNT(*) FROM user_activity;


-- 현재 활성 트랜잭션 확인
SELECT * FROM information_schema.innodb_trx;


-- undo 로그가 쌓이는 정도를 확인 (SHOW ENGINE)
SHOW ENGINE INNODB STATUS\G
