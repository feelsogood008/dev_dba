USE demo_db;

-- 인덱스 없이 느린 쿼리 실행
EXPLAIN ANALYZE 
SELECT post_id, title, created_at
FROM board_posts
WHERE category_id = 3
ORDER BY created_at DESC
LIMIT 20 \G;
