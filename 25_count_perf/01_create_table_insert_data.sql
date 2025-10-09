
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;



DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  order_date DATE,
  amount DECIMAL(10,2),
  INDEX idx_customer (customer_id)
);

-- 100만 건 데이터 삽입 (랜덤)
INSERT INTO orders (customer_id, order_date, amount)
WITH RECURSIVE seq AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM seq WHERE n < 1000000
)
SELECT 
    FLOOR(RAND() * 100000) + 1 AS customer_id,    -- 랜덤 고객 ID
    CURDATE() - INTERVAL (RAND()*365) DAY,       -- 랜덤 일자
    ROUND(RAND() * 100, 2) AS order_amount       -- 주문 금액
FROM seq;


SELECT COUNT(*) FROM orders;

ANALYZE TABLE orders;

