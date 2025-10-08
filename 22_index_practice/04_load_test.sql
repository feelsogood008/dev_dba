
USE demo_db;

SET PROFILING = 1;

-- SELECT 성능 비교
EXPLAIN SELECT * FROM orders WHERE customer_id = 12345 ORDER BY created_at DESC LIMIT 10;

EXPLAIN SELECT customer_id, COUNT(*) 
FROM orders 
WHERE status = 'PAID' 
GROUP BY customer_id 
ORDER BY COUNT(*) DESC LIMIT 10;


-- INSERT 성능 비교 (실제 부하 관찰용)
INSERT INTO orders (customer_id, product_id, amount, status)
SELECT FLOOR(RAND() * 100000) + 1,
       FLOOR(RAND() * 1000) + 1,
       ROUND(RAND() * 100, 2),
       'NEW'
FROM (
    SELECT @rownum := @rownum + 1 AS n
    FROM information_schema.tables a, information_schema.tables b, (SELECT @rownum := 0) r
    LIMIT 50000
) t;


SHOW PROFILES;


