-- 테스트용 DB 및 서비스 계정 생성
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE USER 'svc_api'@'localhost' IDENTIFIED BY 'svc_pass';

-- 일부 기본 권한만 부여 (초기 상태: SELECT만 가능)
GRANT SELECT ON demo_db.legacy_users TO 'svc_api'@'localhost';
FLUSH PRIVILEGES;


