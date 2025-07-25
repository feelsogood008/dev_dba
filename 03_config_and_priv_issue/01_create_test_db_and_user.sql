-- 테스트용 DB 및 서비스 계정 생성
CREATE DATABASE demo_db;

CREATE USER 'svc_api'@'localhost' IDENTIFIED BY 'svc_pass';

-- 일부 기본 권한만 부여 (초기 상태: SELECT만 가능)
GRANT SELECT ON demo_db.legacy_users TO 'svc_api'@'localhost';
FLUSH PRIVILEGES;


