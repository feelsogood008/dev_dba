-- 운영 서버 권한 누락 복구
GRANT SELECT, EXECUTE ON demo_db.* TO 'svc_api'@'%';
FLUSH PRIVILEGES;

-- 재확인
SHOW GRANTS FOR 'svc_api'@'%';

-- legacy_users 테이블 접근 (성공 예상)
SELECT * FROM legacy_users;

-- new_payments 테이블 접근 (성공 예상)
SELECT * FROM new_payments;

-- recent_payments 뷰 접근 (성공 예상)
SELECT * FROM recent_payments;
