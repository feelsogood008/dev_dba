USE demo_db;

-- 트랜잭션 내에서 대량 삭제를 수행하여 undo log를 발생시킴
START TRANSACTION;

DELETE FROM undo_test;

-- COMMIT 지연시켜 undo log가 계속 남도록
-- COMMIT;
