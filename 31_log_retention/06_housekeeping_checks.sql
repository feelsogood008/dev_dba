
USE demo_db;


-- 1) 스키마별 테이블 용량
SELECT table_schema, table_name,
       ROUND((data_length+index_length)/1024/1024, 2) AS size_mb,
       table_rows
FROM information_schema.tables
WHERE table_schema='logs'
ORDER BY size_mb DESC;

-- 2) 파티션 목록과 각 파티션 건수 대략(통계)
SELECT partition_name, table_rows, 
       ROUND((data_length+index_length)/1024/1024,2) AS size_mb
FROM information_schema.partitions
WHERE table_name='log_events_part'
ORDER BY partition_ordinal_position;

-- 3) 최근 7일 ERROR 카운트
SELECT DATE(created_at) d, COUNT(*) cnt
FROM log_events_part
WHERE created_at >= NOW() - INTERVAL 7 DAY AND level='ERROR'
GROUP BY DATE(created_at)
ORDER BY d DESC;

-- 4) 인덱스 점검
SHOW INDEX FROM log_events_part;

-- 5) 이벤트 스케줄러 상태
SHOW PROCESSLIST;
SHOW VARIABLES LIKE 'event_scheduler';
SHOW EVENTS FROM logs;


