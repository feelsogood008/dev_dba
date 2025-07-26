-- 성능 개선을 위한 인덱스 생성
CREATE INDEX idx_category_created_at
ON board_posts (category_id, created_at);
