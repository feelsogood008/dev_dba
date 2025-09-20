
USE demo_db;


-- 세션3: DDL 시도
ALTER TABLE orders ADD COLUMN last_updated TIMESTAMP NULL
    ALGORITHM=INPLACE,
    LOCK=NONE;


-- 현재 락 상태 확인
SELECT * FROM performance_schema.metadata_locks;
SELECT * FROM performance_schema.data_locks;
SELECT * FROM performance_schema.data_lock_waits;
