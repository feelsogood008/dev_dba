
USE demo_db;


-- 오래된 로그를 아카이브 테이블로 이동

CREATE TABLE logs_archive LIKE logs;


-- 주기적으로 수행되도록 배치 작업을 활용한다.
INSERT INTO logs_archive
SELECT * FROM logs
WHERE created_at < NOW() - INTERVAL 30 DAY;

DELETE FROM logs
WHERE created_at < NOW() - INTERVAL 30 DAY;
