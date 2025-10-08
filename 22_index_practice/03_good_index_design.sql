USE demo_db;


-- 불필요한 인덱스 제거 후 꼭 필요한 것만
DROP INDEX idx_customers_name ON customers;
DROP INDEX idx_customers_gender ON customers;

DROP INDEX idx_orders_product_id ON orders;
DROP INDEX idx_orders_amount ON orders;
DROP INDEX idx_orders_status ON orders;

-- 꼭 필요한 인덱스만 유지
CREATE INDEX idx_orders_customer_created ON orders(customer_id, created_at);
