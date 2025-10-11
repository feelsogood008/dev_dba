USE demo_db;

-- 큰 테이블 생성 (large_table은 50만건 이상)
-- 이미 생성되었다고 가정

-- 1. WHERE + ORDER BY + LIMIT
SELECT * FROM large_table
 WHERE category_id = 10 AND status='active'
 ORDER BY created_at DESC
 LIMIT 50;

-- 2. LIKE 검색
SELECT * FROM large_table WHERE title LIKE '%sale%';

-- 3. 함수 기반 검색
SELECT * FROM large_table WHERE DATE(created_at) = '2025-08-01';

-- 4. GROUP BY + SUM
SELECT user_id, SUM(amount) 
FROM large_table 
GROUP BY user_id 
ORDER BY SUM(amount) DESC 
LIMIT 10;

-- 5. DISTINCT
SELECT DISTINCT email 
FROM large_table 
WHERE status='active';

-- 6. 서브쿼리 NOT IN
SELECT * 
FROM large_table 
WHERE user_id NOT IN (
  SELECT id FROM lt_users WHERE status='blocked'
);

-- 7. JOIN
SELECT p.*, u.name
FROM large_table p
JOIN lt_users u ON p.user_id = u.id
WHERE u.status='active';

-- 8. ORDER BY RAND()
SELECT * FROM large_table ORDER BY RAND() LIMIT 20;

-- 9. 범위 검색
SELECT * FROM large_table 
WHERE status='pending' AND amount BETWEEN 100 AND 200;

-- 10. 큰 OFFSET
SELECT * FROM large_table 
ORDER BY created_at DESC 
LIMIT 50 OFFSET 200000;
