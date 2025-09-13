

USE demo_db;


-- =========================================
-- 21장 EXPLAIN 실습 쿼리 모음
-- =========================================

-- 1) 편향된 조건 조회: active 고객 찾기
-- 인덱스가 있지만 값 분포가 80%라서 효율이 떨어짐
EXPLAIN SELECT * FROM customers WHERE status = 'active';

-- 2) 희소 조건 조회: blocked 고객 찾기
-- 인덱스 효율이 극대화됨 (5%만 존재)
EXPLAIN SELECT * FROM customers WHERE status = 'blocked';

-- 3) 최근 30일 주문 조회
-- created_at 인덱스를 활용한 range scan 가능
EXPLAIN SELECT * 
FROM orders 
WHERE created_at >= NOW() - INTERVAL 30 DAY;

-- 4) 오래된 주문 조회
-- 분포가 넓어 인덱스 selectivity가 낮을 수 있음
EXPLAIN SELECT * 
FROM orders 
WHERE created_at < NOW() - INTERVAL 300 DAY;

-- 5) 가장 자주 사용되는 값 조회: paid 주문
-- 데이터의 70%가 paid라 인덱스 효과가 적음
EXPLAIN SELECT * FROM orders WHERE status = 'paid';

-- 6) 자주 쓰이지 않는 값 조회: cancelled 주문
-- 2%만 존재 → 인덱스 효율적
EXPLAIN SELECT * FROM orders WHERE status = 'cancelled';

-- 7) 고객 + 주문 JOIN (고객별 최근 주문 5건)
-- customer_id 인덱스 확인 포인트
EXPLAIN
SELECT o.* 
FROM orders o
JOIN customers c ON c.id = o.customer_id
WHERE c.status = 'active'
ORDER BY o.created_at DESC
LIMIT 5;

-- 8) 특정 고객 이메일로 주문 찾기
-- email 인덱스를 타고 orders 조인 → 효율적
EXPLAIN
SELECT o.*
FROM orders o
JOIN customers c ON c.id = o.customer_id
WHERE c.email = 'user_123@example.com';

-- 9) 특정 기간 + 특정 상태 결합 조회
-- 복합 조건 → 인덱스 조합 여부 확인
EXPLAIN
SELECT *
FROM orders
WHERE status = 'paid'
  AND created_at >= NOW() - INTERVAL 7 DAY;

-- 10) 전체 고객의 주문 수 집계
-- COUNT + JOIN → group by 성능 분석
EXPLAIN
SELECT c.status, COUNT(o.id) AS order_count
FROM customers c
LEFT JOIN orders o ON c.id = o.customer_id
GROUP BY c.status;

-- =========================================
-- 실행 후 성능 차이 비교 팁
-- =========================================
-- SHOW WARNINGS;       -- 실행계획 추가 설명
-- SELECT FOUND_ROWS(); -- 결과 건수 비교
