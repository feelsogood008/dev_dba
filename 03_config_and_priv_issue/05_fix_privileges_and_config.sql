-- 운영 서버 권한 누락 복구
GRANT SELECT, EXECUTE ON demo_db.* TO 'svc_api'@'%';
FLUSH PRIVILEGES;

-- 재확인
SHOW GRANTS FOR 'svc_api'@'%';
