USE demo_db;

DROP TABLE IF EXISTS undo_test;
CREATE TABLE undo_test (
    id INT AUTO_INCREMENT PRIMARY KEY,
    data VARCHAR(255)
) ENGINE=InnoDB;

-- 대량 삽입을 하나의 트랜잭션 안에서 수행
START TRANSACTION;

-- 약 500,000건의 데이터 삽입 (undo log 사용량을 높임)
SET @i = 0;
WHILE @i < 500000 DO
  INSERT INTO undo_test (data) VALUES (REPEAT('x', 200));
  SET @i = @i + 1;
END WHILE;

-- 커밋을 지연시켜 undo log가 계속 쌓이도록 유도
-- COMMIT; -- 일단 보류 (수동으로 확인 후 커밋하거나 실패 유도)


