
USE demo_db;

DROP TABLE IF EXISTS orders2;

-- 주문/결제/배송이 모두 들어간 테이블 (God Table)
CREATE TABLE orders2 (
  id BIGINT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  order_date DATETIME NOT NULL,
  total_amount DECIMAL(10,2) NOT NULL,
  status VARCHAR(20) NOT NULL,
  -- 결제 관련
  payment_method VARCHAR(20),
  payment_date   DATETIME,
  payment_status VARCHAR(20),
  -- 배송 관련
  shipping_address VARCHAR(200),
  shipping_date    DATETIME,
  delivery_status  VARCHAR(20)
) ENGINE=InnoDB;




-- 샘플 데이터 입력
INSERT INTO orders2
(customer_id, order_date, total_amount, status,
 payment_method, payment_date, payment_status,
 shipping_address, shipping_date, delivery_status)
SELECT
  FLOOR(1 + RAND()*1000),          -- 고객 ID
  NOW() - INTERVAL (RAND()*365) DAY,
  ROUND(RAND()*500,2),
  ELT(FLOOR(1+RAND()*3), 'ordered','paid','shipped'),
  ELT(FLOOR(1+RAND()*3), 'card','bank','cash'),
  NOW() - INTERVAL (RAND()*30) DAY,
  ELT(FLOOR(1+RAND()*3), 'paid','pending','failed'),
  CONCAT('Seoul-', FLOOR(RAND()*100)),
  NOW() - INTERVAL (RAND()*10) DAY,
  ELT(FLOOR(1+RAND()*3), 'preparing','delivering','done')
FROM
  (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
   UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) t1,
  (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
   UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) t2,
  (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4 UNION ALL SELECT 5
   UNION ALL SELECT 6 UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL SELECT 10) t3;



