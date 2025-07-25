-- svc_api 계정으로 실행 시도
USE demo_db;

-- 기존 테이블 접근 (성공 예상)
SELECT * FROM legacy_users;

-- 신규 테이블 접근 (실패 예상)
SELECT * FROM new_payments;

-- 뷰 접근 (실패 예상)
SELECT * FROM recent_payments;

-- 저장 프로시저 호출 (실패 예상)
CALL get_user_email(1);
