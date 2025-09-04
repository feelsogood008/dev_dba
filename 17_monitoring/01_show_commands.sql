-- 1) 현재 연결 수, 커넥션 실패율 확인
SHOW STATUS LIKE 'Threads_connected';
SHOW STATUS LIKE 'Aborted_connects';

-- 2) 슬로우 쿼리 비율 확인
SHOW GLOBAL STATUS LIKE 'Slow_queries';
SHOW GLOBAL STATUS LIKE 'Questions';   -- 전체 쿼리 수
-- 비율 계산: Slow_queries / Questions * 100

-- 3) InnoDB 버퍼풀 효율
SHOW GLOBAL STATUS LIKE 'Innodb_buffer_pool_read%';
-- Innodb_buffer_pool_read_requests vs Innodb_buffer_pool_reads (miss 비율 계산)

-- 4) 잠금 대기 현황
SHOW ENGINE INNODB STATUS \G   -- Deadlock, lock wait 상황 확인
