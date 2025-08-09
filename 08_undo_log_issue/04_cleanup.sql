USE demo_db;


DROP TABLE IF EXISTS user_activity;
DROP TABLE IF EXISTS seq_1_to_10000;

-- 종료 후 세션 종료
-- (설정 변경한 것이 있다면 수동 복원 필요)

-- undo 로그가 쌓이는 정도를 확인 (SHOW ENGINE)
SHOW ENGINE INNODB STATUS\G



