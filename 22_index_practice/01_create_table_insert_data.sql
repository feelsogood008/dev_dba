CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;


DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS customers;


-- 고객 테이블
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(200) UNIQUE,
    gender CHAR(1),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 주문 테이블
CREATE TABLE orders (
    order_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);



-- 고객 10만 명 삽입
INSERT INTO customers (name, email, gender)
SELECT 
    CONCAT('User_', n),
    CONCAT('user', n, '@test.com'),
    IF(RAND() > 0.5, 'M', 'F')
FROM (
    SELECT @rownum := @rownum + 1 AS n
    FROM information_schema.tables a, information_schema.tables b, (SELECT @rownum := 0) r
    LIMIT 100000
) t;

-- 주문 100만 건 삽입
INSERT INTO orders (customer_id, product_id, amount, status)
SELECT 
    FLOOR(RAND() * 100000) + 1,    -- 랜덤 고객 ID
    FLOOR(RAND() * 1000) + 1,      -- 랜덤 상품
    ROUND(RAND() * 100, 2),        -- 주문 금액
    ELT(FLOOR(RAND()*3)+1, 'NEW', 'PAID', 'CANCEL') -- 상태
FROM (
    SELECT @rownum := @rownum + 1 AS n
    FROM information_schema.tables a, information_schema.tables b, (SELECT @rownum := 0) r
    LIMIT 1000000
) t;
