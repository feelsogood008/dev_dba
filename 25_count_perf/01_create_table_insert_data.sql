
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
SELECT FLOOR(1 + RAND()*10000),
       CURDATE() - INTERVAL (RAND()*365) DAY,
       RAND()*1000
FROM information_schema.tables t1,
     information_schema.tables t2
LIMIT 1000000;


