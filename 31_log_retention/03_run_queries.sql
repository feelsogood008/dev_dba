
USE demo_db;


-- 1) 최근 7일 조회(비파티션) - 인덱스 없거나 비효율 시 풀스캔 위험
EXPLAIN SELECT COUNT(*) 
FROM log_events_raw 
WHERE created_at >= NOW() - INTERVAL 7 DAY;

-- 2) 최근 7일 조회(파티션) - PARTITIONS 열 확인
EXPLAIN SELECT COUNT(*) 
FROM log_events_part
WHERE created_at >= NOW() - INTERVAL 7 DAY;

-- 3) 서비스별 최근 1일 ERROR 카운트(비파티션 vs 파티션)
EXPLAIN SELECT service, COUNT(*) 
FROM log_events_raw
WHERE created_at >= NOW() - INTERVAL 1 DAY AND level='ERROR'
GROUP BY service;

EXPLAIN SELECT service, COUNT(*) 
FROM log_events_part
WHERE created_at >= NOW() - INTERVAL 1 DAY AND level='ERROR'
GROUP BY service;

-- 4) 범위+정렬: 최근 3일 특정 서비스
EXPLAIN SELECT * 
FROM log_events_raw
WHERE service='svc_7' AND created_at >= NOW() - INTERVAL 3 DAY
ORDER BY created_at DESC LIMIT 200;

EXPLAIN SELECT * 
FROM log_events_part
WHERE service='svc_7' AND created_at >= NOW() - INTERVAL 3 DAY
ORDER BY created_at DESC LIMIT 200;

