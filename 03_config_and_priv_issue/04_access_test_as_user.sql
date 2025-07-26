-- svc_api 계정으로 실행 시도
USE demo_db;

-- legacy_users 테이블 접근 (성공)
SELECT * FROM legacy_users;

-- new_payments 테이블 접근 (권한이 없으면 실패)
SELECT * FROM new_payments;

-- recent_payments 뷰 접근 (권한이 없으면 실패)
SELECT * FROM recent_payments;

-- 저장 프로시저 호출 (권한이 없으면 실패)
CALL get_user_email(1);
