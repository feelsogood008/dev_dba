-- 인덱스 적용 후 동일한 쿼리 실행
EXPLAIN SELECT post_id, title, created_at
FROM board_posts
WHERE category_id = 3
ORDER BY created_at DESC
LIMIT 20 \G;
