
USE demo_db;


-- 약 30여만 건 정도를 6개월 분포로 생성
-- created_at: 최근 240일 범위 분산, level/service 다양화
INSERT INTO log_events_raw (created_at, level, service, message, ctx)
SELECT
  NOW() - INTERVAL (n % 240) DAY - INTERVAL (n % 86400) SECOND AS created_at,
  ELT(1 + (n % 4), 'DEBUG','INFO','WARN','ERROR') AS level,
  CONCAT('svc_', 1 + (n % 20)) AS service,
  CONCAT('event_', n, ' happened') AS message,
  JSON_OBJECT('req_id', UUID(), 'user', 1 + (n % 100000))
FROM util_numbers
WHERE n <= 500000;

-- 동일 데이터를 파티션 테이블에도 적재(분포 동일)
INSERT INTO log_events_part (created_at, level, service, message, ctx)
SELECT
  NOW() - INTERVAL (n % 240) DAY - INTERVAL (n % 86400) SECOND,
  ELT(1 + (n % 4), 'DEBUG','INFO','WARN','ERROR'),
  CONCAT('svc_', 1 + (n % 20)),
  CONCAT('event_', n, ' happened'),
  JSON_OBJECT('req_id', UUID(), 'user', 1 + (n % 100000))
FROM util_numbers
WHERE n <= 500000;

-- 통계 확인
SELECT 'raw_count' AS t, COUNT(*) FROM log_events_raw
UNION ALL
SELECT 'part_count', COUNT(*) FROM log_events_part;



