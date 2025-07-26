
CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;

-- board_posts 테이블 생성
CREATE TABLE IF NOT EXISTS board_posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    category_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 대량의 게시글 데이터 입력 (범주 구분이 되도록 category_id 다양화)
INSERT INTO board_posts (title, content, category_id, created_at)
SELECT
    CONCAT('Post Title ', seq),
    CONCAT('Sample content for post ', seq),
    FLOOR(1 + RAND() * 5),  -- category_id: 1~5 랜덤
    DATE_SUB(NOW(), INTERVAL FLOOR(RAND() * 365) DAY)
FROM (
    SELECT @rownum := @rownum + 1 AS seq
    FROM information_schema.columns a,
         information_schema.columns b,
         (SELECT @rownum := 0) r
    LIMIT 5000000
) temp;
