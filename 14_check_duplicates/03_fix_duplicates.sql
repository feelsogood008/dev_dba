USE demo_db;



DELETE FROM customers
WHERE id NOT IN (
    SELECT id FROM (
        SELECT id
        FROM (
            SELECT id,
                   ROW_NUMBER() OVER (PARTITION BY email ORDER BY created_at) AS rn
            FROM customers
        ) t
        WHERE rn = 1
    ) x
);


-- 삭제 후 확인
SELECT * FROM customers;

