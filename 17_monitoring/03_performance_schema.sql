-- 1) 사용자별 실행된 쿼리 시간 TOP 10
SELECT 
    USER, 
    EVENT_NAME, 
    SUM_TIMER_WAIT/1000000000000 AS total_sec, 
    COUNT_STAR AS total_exec_count
FROM performance_schema.events_statements_summary_by_user_by_event_name
WHERE EVENT_NAME LIKE 'statement/sql/%'
ORDER BY SUM_TIMER_WAIT DESC
LIMIT 10;



-- 2) 잠금 경합이 가장 심한 테이블 TOP 10
SELECT object_schema, object_name,
       count_star AS lock_count, sum_timer_wait/1000000000 AS wait_ms
FROM performance_schema.table_lock_waits_summary_by_table
ORDER BY wait_ms DESC
LIMIT 10;



-- 3) 파일 I/O 상위 10개
SELECT file_name, count_read, count_write,
       (sum_timer_read+sum_timer_write)/1000000000 AS io_time_ms
FROM performance_schema.file_summary_by_instance
ORDER BY io_time_ms DESC
LIMIT 10;



-- 4) 쿼리 실행 시간 분포
SELECT 
  DIGEST_TEXT AS query,
  COUNT_STAR AS exec_count,
  ROUND(AVG_TIMER_WAIT / 1000000, 2) AS avg_ms,
  ROUND(MAX_TIMER_WAIT / 1000000, 2) AS max_ms
FROM performance_schema.events_statements_summary_by_digest
ORDER BY AVG_TIMER_WAIT DESC
LIMIT 10;
