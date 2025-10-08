

CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



USE demo_db;



-- =========================================
-- EXPLAIN 실습용: 편향적 데이터 분포 생성
-- =========================================

DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;

-- 고객 테이블
CREATE TABLE customers (
  id         INT UNSIGNED NOT NULL AUTO_INCREMENT,
  name       VARCHAR(100) NOT NULL,
  email      VARCHAR(150) NOT NULL,
  status     ENUM('active','inactive','blocked') NOT NULL,
  created_at DATETIME NOT NULL,
  PRIMARY KEY (id),
  KEY idx_status (status),
  KEY idx_email (email)
) ENGINE=InnoDB;

-- 주문 테이블
CREATE TABLE orders (
  id          BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  customer_id INT UNSIGNED NOT NULL,
  title       VARCHAR(200) NOT NULL,
  amount      DECIMAL(10,2) NOT NULL,
  created_at  DATETIME NOT NULL,
  status      ENUM('pending','paid','shipped','cancelled') NOT NULL,
  PRIMARY KEY (id),
  KEY idx_customer (customer_id),
  KEY idx_created (created_at),
  CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id)
    REFERENCES customers(id)
    ON DELETE CASCADE
) ENGINE=InnoDB;

-- =========================================
-- 고객 데이터: 100,000명
-- 80% active, 15% inactive, 5% blocked
-- =========================================
INSERT INTO customers (name, email, status, created_at)
SELECT 
  CONCAT('user_', n) AS name,
  CONCAT('user_', n, '@example.com') AS email,
  CASE 
    WHEN n % 20 = 0 THEN 'blocked'   -- 5%
    WHEN n % 6  = 0 THEN 'inactive'  -- 15%
    ELSE 'active'                    -- 80%
  END AS status,
  NOW() - INTERVAL (n % 1000) DAY
FROM (
  SELECT @rownum := @rownum + 1 AS n
  FROM information_schema.tables t1, 
       information_schema.tables t2,
       (SELECT @rownum := 0) r
  LIMIT 100000
) seq;

-- =========================================
-- 주문 데이터: 약 2,000,000건
-- 최근 30일 : 50%, 나머지 1년 분산
-- 상태 분포: paid 70%, shipped 20%, pending 8%, cancelled 2%
-- =========================================
INSERT INTO orders (customer_id, title, amount, created_at, status)
SELECT 
  FLOOR(1 + (RAND() * 100000)) AS customer_id,
  CONCAT('Order_', n) AS title,
  ROUND(RAND() * 500, 2) AS amount,
  CASE 
    WHEN n % 2 = 0 
      THEN NOW() - INTERVAL (RAND() * 30) DAY    -- 최근 30일
    ELSE NOW() - INTERVAL (RAND() * 365) DAY     -- 1년 이내
  END AS created_at,
  CASE 
    WHEN n % 50 = 0 THEN 'cancelled'   -- 2%
    WHEN n % 12 = 0 THEN 'pending'     -- 8%
    WHEN n % 5  = 0 THEN 'shipped'     -- 20%
    ELSE 'paid'                        -- 70%
  END AS status
FROM (
  SELECT @rownum2 := @rownum2 + 1 AS n
  FROM information_schema.tables t1,
       information_schema.tables t2,
       information_schema.tables t3,
       (SELECT @rownum2 := 0) r
  LIMIT 2000000
) seq2;

COMMIT;

-- =========================================
-- 데이터 확인
-- =========================================
SELECT status, COUNT(*) FROM customers GROUP BY status;
SELECT status, COUNT(*) FROM orders GROUP BY status;

ANALYZE TABLE orders;
ANALYZE TABLE customers;



