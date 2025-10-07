
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE demo_db;


DROP TABLE IF EXISTS customers;


CREATE TABLE customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  created_at DATETIME NOT NULL DEFAULT NOW()
) ENGINE=InnoDB;



INSERT INTO customers (name, email, phone) VALUES
('Alice', 'alice@example.com', '010-1111-2222'),
('Bob', 'bob@example.com', '010-3333-4444'),
('Charlie', 'charlie@example.com', '010-5555-6666'),
-- 중복 삽입
('Alice', 'alice@example.com', '010-1111-2222'),
('Bob', 'bob@example.com', '010-3333-4444'),
('Alice', 'alice@example.com', '010-1111-2222');




