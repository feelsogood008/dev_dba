USE demo_db;


-- =========================================
-- 테이블 생성
-- =========================================

DROP TABLE IF EXISTS large_table;
DROP TABLE IF EXISTS lt_users;

-- 사용자 테이블 (JOIN, 서브쿼리 대상)
CREATE TABLE lt_users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(200),
    status ENUM('active', 'inactive', 'blocked') DEFAULT 'active',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 대용량 데이터 테이블
CREATE TABLE large_table (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NOT NULL,
    category_id INT UNSIGNED NOT NULL,
    title VARCHAR(255) NOT NULL,
    status ENUM('active', 'pending', 'disabled') DEFAULT 'active',
    amount DECIMAL(10,2) DEFAULT 0.00,
    email VARCHAR(200),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_large_table_user FOREIGN KEY (user_id) REFERENCES lt_users(id)
        ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =========================================
-- 더미 데이터 삽입
-- =========================================

-- 사용자 데이터 생성
INSERT INTO lt_users (name, email, status)
SELECT CONCAT('User_', n), CONCAT('user', n, '@example.com'),
       ELT(FLOOR(1 + RAND()*3), 'active','inactive','blocked')
FROM (
    SELECT @rownum := @rownum + 1 AS n
    FROM (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) t1,
         (SELECT 0 UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL SELECT 4) t2,
         (SELECT @rownum:=0) r
) temp;


-- truncate table orders
SET @@SESSION.cte_max_recursion_depth = 1000000;

-- 메인 테이블 데이터
-- 100만 건 데이터 삽입 (랜덤)
INSERT INTO large_table (user_id, category_id, title, status, amount, email, created_at)
WITH RECURSIVE seq AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM seq WHERE n < 1000000
)    
SELECT 
    FLOOR(1 + RAND() * 25),  -- user_id
    FLOOR(1 + RAND() * 20),  -- category_id
    CONCAT('Product sale item #', n),
    ELT(FLOOR(1 + RAND()*3), 'active','pending','disabled'),
    ROUND(RAND() * 500, 2),
    CONCAT('buyer', n, '@mail.com'),
    NOW() - INTERVAL FLOOR(RAND()*365) DAY
FROM seq;



-- =========================================
-- 인덱스 생성 스크립트 (분리 관리)
-- =========================================

-- lt_users
-- CREATE INDEX idx_users_status ON lt_users (status);
-- CREATE INDEX idx_users_created ON lt_users (created_at);

-- large_table
-- CREATE INDEX idx_large_category_status ON large_table (category_id, status);
-- CREATE INDEX idx_large_created ON large_table (created_at);
-- CREATE INDEX idx_large_title ON large_table (title(100));
-- CREATE INDEX idx_large_user ON large_table (user_id);
-- CREATE INDEX idx_large_status ON large_table (status);
