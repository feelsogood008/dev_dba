-- 테스트 DB/테이블 생성 및 초기 데이터 삽입

CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;



DROP TABLE IF EXISTS products;
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    price DECIMAL(10,2)
) ENGINE=InnoDB;



INSERT INTO products (name, price) VALUES
('Keyboard', 50.00),
('Mouse', 25.00),
('Monitor', 200.00),
('Laptop', 1200.00);


-- 초기 데이터 
SELECT * FROM products;
