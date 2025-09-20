
USE demo_db;


-- 1. 세션1: 긴 트랜잭션 실행
START TRANSACTION;
SELECT * FROM orders WHERE status = 'pending' FOR UPDATE;
-- 이 상태에서 세션을 잠시 유지 (LOCK 상태 유지)


-- 현재 락 상태 확인
SELECT * FROM performance_schema.metadata_locks;
SELECT * FROM performance_schema.data_locks;
SELECT * FROM performance_schema.data_lock_waits;



-- 2. 세션2: DDL 시도 (메타데이터 락 발생)
-- ALTER TABLE orders ADD COLUMN test_col INT;


