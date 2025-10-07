USE demo_db;

-- [상황] 배송 상태만 업데이트하고 싶은데
-- 테이블에 여러 인덱스가 있어서 모두 갱신되어 불필요한 락(Lock)이 증가한다.

-- 세션 1 (트랜잭션 시작)
START TRANSACTION;
UPDATE orders2
SET delivery_status = 'delivering'
WHERE id = 1;

-- 세션 2 (동시에 실행)
START TRANSACTION;
UPDATE orders2
SET payment_status = 'paid'
WHERE id = 1;

-- InnoDB에서는 같은 row에 대해 다른 컬럼을 업데이트해도 인덱스 갱신 때문에 
-- 레코드락(Lock) 과 인덱스락(Lock)이 충돌하면서 잠금 경합이 발생한다.

