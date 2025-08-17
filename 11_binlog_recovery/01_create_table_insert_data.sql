CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;


CREATE TABLE customers (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50),
    email VARCHAR(100),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);



INSERT INTO customers (name, email)
SELECT CONCAT('User', seq), CONCAT('user', seq, '@example.com')
FROM (
    SELECT @rownum := @rownum + 1 AS seq
    FROM information_schema.tables t1,
         information_schema.tables t2,
         (SELECT @rownum := 0) r
    LIMIT 100
) a;


SELECT '삭제 전 데이터 개수' AS step, COUNT(*) AS total_rows, SYSDATE() AS '현재시간'
FROM customers;

SELECT * FROM customers ORDER BY id LIMIT 10;

