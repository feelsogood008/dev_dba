

-- 쿼리 실행 시간 확인
SHOW PROFILES;

-- 인덱스 사용 현황
SHOW INDEX FROM orders;

-- 핸들러 통계 (풀스캔 발생 여부 확인)
SHOW GLOBAL STATUS LIKE 'Handler_read%';

-- InnoDB 상태 확인 (잠금, 버퍼 풀 등)
SHOW ENGINE INNODB STATUS\G

-- Performance Schema: IO, CPU, Waits 측정
SELECT * FROM performance_schema.events_statements_summary_by_digest
ORDER BY SUM_TIMER_WAIT DESC LIMIT 10;

-- 인덱스 사용 안 된 쿼리 모니터링
SELECT OBJECT_SCHEMA, OBJECT_NAME, INDEX_NAME, COUNT_STAR
FROM performance_schema.table_io_waits_summary_by_index_usage
WHERE INDEX_NAME IS NULL OR COUNT_STAR > 0;
