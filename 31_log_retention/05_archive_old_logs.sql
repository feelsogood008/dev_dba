
USE demo_db;


-- 180일 이전 로그를 아카이브 테이블로 이동 (비파티션 예시)
CREATE TABLE IF NOT EXISTS log_events_archive LIKE log_events_raw;

-- 배치 크기 작게(예: 50k) 진행 권장. 여기선 데모로 한 번에 옮김.
INSERT INTO log_events_archive (created_at, level, service, message, ctx)
SELECT created_at, level, service, message, ctx
FROM log_events_raw
WHERE created_at < NOW() - INTERVAL 180 DAY;

-- 원본에서 제거(주의: 실제 운영은 파티션 DROP을 우선 고려)
DELETE FROM log_events_raw
WHERE created_at < NOW() - INTERVAL 180 DAY;

