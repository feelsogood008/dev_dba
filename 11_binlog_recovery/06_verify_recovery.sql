USE demo_db;


SELECT '복원 후 데이터 개수' AS step, COUNT(*) AS total_rows
FROM customers;

SELECT * FROM customers ORDER BY id LIMIT 10;


