USE demo_db;


-- 대량 삭제 (undo log가 비대해지는 원인)
DELETE FROM user_activity
WHERE user_id < 50000;
