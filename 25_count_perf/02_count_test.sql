

USE demo_db;


-- 로그 출력을 보기 위해 타이밍 활성화
SET profiling = 1;

-- 1) 전체 COUNT
SELECT '1) Full COUNT(*)' AS test_case;
SELECT COUNT(*) FROM orders;
SHOW PROFILES;

-- 2) 조건 COUNT (인덱스 없음)
SELECT '2) COUNT(*) WHERE amount > 500 (no index)' AS test_case;
SELECT COUNT(*) FROM orders WHERE amount > 500;
SHOW PROFILES;

-- 실행계획 확인
EXPLAIN SELECT COUNT(*) FROM orders WHERE amount > 500;

-- 3) 인덱스 추가 후 COUNT
ALTER TABLE orders ADD INDEX idx_amount (amount);

SELECT '3) COUNT(*) WHERE amount > 500 (with index)' AS test_case;
SELECT COUNT(*) FROM orders WHERE amount > 500;
SHOW PROFILES;

-- 실행계획 확인
EXPLAIN SELECT COUNT(*) FROM orders WHERE amount > 500;

-- 4) 근사치 조회
SELECT '4) SHOW TABLE STATUS 근사치' AS test_case;
SHOW TABLE STATUS LIKE 'orders'\G

