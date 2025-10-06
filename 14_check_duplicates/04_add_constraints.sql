USE demo_db;

-- email 컬럼에 UNIQUE 제약 추가
ALTER TABLE customers
ADD CONSTRAINT uq_customers_email UNIQUE (email);


INSERT INTO customers (name, email, phone) VALUES('Alice', 'alice@example.com', '010-1111-2222');
