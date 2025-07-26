-- 현재 서비스 계정 권한 확인
SHOW GRANTS FOR 'svc_api'@'%';

-- 정보 스키마로도 확인
SELECT * FROM information_schema.SCHEMA_PRIVILEGES 
WHERE GRANTEE LIKE "'svc_api'%";
