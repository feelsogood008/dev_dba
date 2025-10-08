USE demo_db;



-- 과도한 인덱스 생성 (모든 컬럼 인덱스)
CREATE INDEX idx_customers_name ON customers(name);
CREATE INDEX idx_customers_email ON customers(email);
CREATE INDEX idx_customers_gender ON customers(gender);
CREATE INDEX idx_customers_created_at ON customers(created_at);

CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_product_id ON orders(product_id);
CREATE INDEX idx_orders_amount ON orders(amount);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at);


-- 불필요한 중복 인덱스
CREATE INDEX idx_orders_customer_product ON orders(customer_id, product_id);
CREATE INDEX idx_orders_customer_created_at ON orders(customer_id, created_at);
