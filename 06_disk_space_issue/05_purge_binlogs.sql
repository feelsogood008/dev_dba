-- 오래된 바이너리 로그 제거 (주의: replication 환경에서는 신중하게 사용)

PURGE BINARY LOGS BEFORE NOW() - INTERVAL 7 DAY;
