USE demo_db;



-- 분리 전: 배송 상태 조회
SELECT id, customer_id, delivery_status
FROM orders
WHERE delivery_status = 'PREPARING';


-- 분리 후: JOIN 또는 개별 테이블 조회
SELECT o.id, o.customer_id, s.delivery_status
FROM new_orders o
JOIN order_shipments s ON o.id = s.order_id
WHERE s.delivery_status = 'PREPARING';

