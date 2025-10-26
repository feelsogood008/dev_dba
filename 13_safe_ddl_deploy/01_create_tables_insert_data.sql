
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;



USE demo_db;


CREATE TABLE seq_1_to_1000 (
    seq INT PRIMARY KEY
);

INSERT INTO seq_1_to_1000 (seq)
SELECT a.N + b.N*10 + c.N*100 + 1 AS num
FROM (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 
      UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 
      UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) a
CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 
            UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 
            UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) b
CROSS JOIN (SELECT 0 AS N UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 
            UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 
            UNION ALL SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9) c
WHERE a.N + b.N*10 + c.N*100 + 1 <= 1000;


SELECT COUNT(*) AS "seq_1_to_1000 건수" FROM seq_1_to_1000;


-- truncate table seq_1_to_100000
CREATE TABLE seq_1_to_100000 (
    seq INT PRIMARY KEY
);

INSERT INTO seq_1_to_100000 (seq)
SELECT (t1.seq - 1) * 1000 + t2.seq AS seq
FROM (SELECT seq FROM seq_1_to_1000 WHERE seq <= 100 ORDER BY seq) t1
CROSS JOIN seq_1_to_1000 t2
ORDER BY seq;


SELECT COUNT(*) AS "seq_1_to_100000 건수" FROM seq_1_to_100000;


-- truncate table seq_1_to_1000000
CREATE TABLE seq_1_to_1000000 (
    seq INT PRIMARY KEY
);

INSERT INTO seq_1_to_1000000 (seq)
SELECT (t1.seq - 1) * 1000 + t2.seq AS seq
FROM seq_1_to_1000 t1
CROSS JOIN seq_1_to_1000 t2
ORDER BY seq;

SELECT COUNT(*) AS "seq_1_to_1000000 건수" FROM seq_1_to_1000000;


-- truncate table users
CREATE TABLE users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(100)
);

-- users 100,000명 삽입
INSERT INTO users (name, email)
SELECT CONCAT('user', seq), CONCAT('user', seq, '@example.com')
FROM seq_1_to_100000;


-- 

CREATE TABLE orders (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT,
    order_date DATETIME,
    status VARCHAR(20),
    INDEX idx_user_id(user_id)
);

-- orders 5,000,000건 삽입
INSERT INTO orders (user_id, order_date, status)
SELECT FLOOR(1 + RAND()*100000), NOW(), 'pending'
FROM seq_1_to_1000000;

INSERT INTO orders (user_id, order_date, status)
SELECT FLOOR(1 + RAND()*100000), NOW(), 'pending'
FROM seq_1_to_1000000;

INSERT INTO orders (user_id, order_date, status)
SELECT FLOOR(1 + RAND()*100000), NOW(), 'pending'
FROM seq_1_to_1000000;

INSERT INTO orders (user_id, order_date, status)
SELECT FLOOR(1 + RAND()*100000), NOW(), 'pending'
FROM seq_1_to_1000000;

INSERT INTO orders (user_id, order_date, status)
SELECT FLOOR(1 + RAND()*100000), NOW(), 'pending'
FROM seq_1_to_1000000;


SELECT COUNT(*) FROM users;   -- 100,000
SELECT COUNT(*) FROM orders;  -- 5,000,000


