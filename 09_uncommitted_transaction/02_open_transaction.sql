-- 02_open_transaction.sql
-- 트랜잭션을 시작하고 UPDATE 실행한 뒤 COMMIT 하지 않고 SLEEP으로 연결을 유지
-- (mysql 클라이언트로 실행하면 SLEEP 동안 세션이 열려 있어 트랜잭션이 미커밋 상태로 유지됨)

USE demo_db;


-- 트랜잭션 시작
START TRANSACTION;

-- 특정 레코드(예시: id=1)의 price 변경
UPDATE products SET price = price * 1.10 WHERE id = 1;

-- 변경값을 같은 세션에서 바로 확인
SELECT "inside-transaction (before commit): Keyboard Price is 55.00" AS note;
SELECT * FROM products WHERE id = 1;

-- 세션을 유지하기 위해 의도적으로 SLEEP 실행 (여기서 COMMIT 하지 않음)
-- SLEEP 시간을 충분히 길게 잡아 모니터링 가능하게 함 (예: 300초)
SELECT SLEEP(300);
-- 세션이 종료되면 (클라이언트 종료 등) 이 트랜잭션은 자동으로 ROLLBACK 됨


