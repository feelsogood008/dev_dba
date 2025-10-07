USE demo_db;



-- God Table의 인덱스 난잡 예시
ALTER TABLE orders2
  ADD INDEX idx_order_date(order_date),
  ADD INDEX idx_payment_status(payment_status),
  ADD INDEX idx_delivery_status(delivery_status),
  ADD INDEX idx_customer_status(customer_id, status);

ANALYZE TABLE orders2;

-- [문제 상황 1] : 주문 조회시 order_date + status 조합 사용
EXPLAIN SELECT id, customer_id, order_date, status
FROM orders2
WHERE status = 'PAID'
ORDER BY order_date DESC
LIMIT 10;

-- [문제 상황 2] : 결제 조회시 payment_status + payment_date 사용
EXPLAIN SELECT id, payment_status, payment_date
FROM orders2
WHERE payment_status = 'PENDING'
ORDER BY payment_date DESC
LIMIT 10;

-- [문제 상황 3] : 배송 조회시 delivery_status + shipping_date 사용
EXPLAIN SELECT id, delivery_status, shipping_date
FROM orders2
WHERE delivery_status = 'PREPARING'
ORDER BY shipping_date DESC
LIMIT 10;

-- 각 쿼리마다 필요한 인덱스가 다르므로 인덱스가 난잡하게 늘어남
-- 인덱스 수가 많아지면 INSERT/UPDATE/DELETE 시 불필요한 인덱스 갱신 비용 증가




