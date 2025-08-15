
USE demo_db;



-- A) 기존 테이블 정리
DROP TABLE IF EXISTS large_table;
DROP TABLE IF EXISTS lt_users;

-- B) 조인/NOT IN 테스트용 보조 테이블 (5만 유저)
CREATE TABLE lt_users (
  id           INT UNSIGNED NOT NULL PRIMARY KEY,
  name         VARCHAR(100) NOT NULL,
  email        VARCHAR(120) NOT NULL,
  created_at   DATETIME NOT NULL,
  status       VARCHAR(20) NOT NULL    -- active / blocked / dormant 등
) ENGINE=InnoDB;

-- C) 메인 대용량 테이블 (50만 행)
CREATE TABLE large_table (
  id           BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  user_id      INT UNSIGNED NOT NULL,          -- JOIN/집계/서브쿼리용
  category_id  INT UNSIGNED NOT NULL,          -- 필터
  title        VARCHAR(200) NOT NULL,          -- LIKE
  content      TEXT NOT NULL,                  -- LIKE
  created_at   DATETIME NOT NULL,              -- 필터/정렬/함수
  status       VARCHAR(20) NOT NULL,           -- 필터
  amount       DECIMAL(10,2) NOT NULL,         -- 집계/범위
  email        VARCHAR(120) NOT NULL,          -- DISTINCT/조건
  ip           VARCHAR(45)  NOT NULL,          -- DISTINCT/조건
  view_count   INT UNSIGNED NOT NULL,          -- 집계/정렬
  PRIMARY KEY (id)
) ENGINE=InnoDB ROW_FORMAT=DYNAMIC;

-- D) 세션 성능 옵션(입력 가속. 끝나면 원복)
SET @old_unique_checks      := @@SESSION.unique_checks;
SET @old_foreign_key_checks := @@SESSION.foreign_key_checks;
SET @old_autocommit         := @@SESSION.autocommit;

SET SESSION unique_checks = 0;
SET SESSION foreign_key_checks = 0;
SET SESSION autocommit = 0;

INSERT INTO lt_users (id, name, email, created_at, status)
SELECT
    ROW_NUMBER() OVER () AS id,
    CONCAT('user_', ROW_NUMBER() OVER ()) AS name,
    CONCAT('user_', ROW_NUMBER() OVER (), '@example.com') AS email,
    FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()) - (ROW_NUMBER() OVER () % 864000)) AS created_at, -- 최근 10일 분포
    CASE
        WHEN (ROW_NUMBER() OVER () % 13) = 0 THEN 'blocked'
        WHEN (ROW_NUMBER() OVER () % 7)  = 0 THEN 'dormant'
        ELSE 'active'
    END AS status
FROM information_schema.tables t1
JOIN information_schema.tables t2
LIMIT 50000;

INSERT INTO large_table (
    user_id, category_id, title, content, created_at, status, amount, email, ip, view_count
)
SELECT
    FLOOR(1 + (ROW_NUMBER() OVER () % 50000)) AS user_id, -- 5만 명의 유저
    FLOOR(1 + (ROW_NUMBER() OVER () % 50)) AS category_id, -- 50개 카테고리
    CONCAT('Product ', ROW_NUMBER() OVER ()) AS title, -- 상품명
    CONCAT('Lorem ipsum dolor sit amet ', ROW_NUMBER() OVER ()) AS content, -- 본문
    FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()) - (ROW_NUMBER() OVER () % 31536000)) AS created_at, -- 최근 1년 분포
    CASE
        WHEN (ROW_NUMBER() OVER () % 9) = 0 THEN 'pending'
        WHEN (ROW_NUMBER() OVER () % 5) = 0 THEN 'inactive'
        ELSE 'active'
    END AS status,
    ROUND(RAND() * 1000, 2) AS amount, -- 랜덤 금액
    CONCAT('user', ROW_NUMBER() OVER (), '@example.com') AS email, -- 이메일
    CONCAT('192.168.', FLOOR(RAND() * 256), '.', FLOOR(RAND() * 256)) AS ip, -- 랜덤 IP
    FLOOR(RAND() * 10000) AS view_count -- 랜덤 조회수
FROM information_schema.tables t1
JOIN information_schema.tables t2
LIMIT 500000;


-- H) 세션 옵션 원복
SET SESSION unique_checks      = @old_unique_checks;
SET SESSION foreign_key_checks = @old_foreign_key_checks;
SET SESSION autocommit         = @old_autocommit;

-- I) 통계 갱신(선택)
ANALYZE TABLE large_table;
ANALYZE TABLE lt_users;




-- 1) 필터 + 정렬 + LIMIT
-- 특정 카테고리의 active 상태 데이터 최신순 50개
SELECT *
FROM large_table
WHERE category_id = 42
  AND status = 'active'
ORDER BY created_at DESC
LIMIT 50;

-- 2) LIKE (전방/후방 와일드카드)
-- 제목에 'sale' 포함, 내용에 'ipsum' 포함
SELECT id, title, content
FROM large_table
WHERE title LIKE '%sale%'
   OR content LIKE '%ipsum%';

-- 3) 함수 적용 필터
-- 2025-08-01 날짜에 생성된 데이터
SELECT *
FROM large_table
WHERE DATE(created_at) = '2025-08-01';

-- 4) GROUP BY / 집계
-- user_id별 amount 합계 상위 10명
SELECT user_id, SUM(amount) AS total_amount
FROM large_table
GROUP BY user_id
ORDER BY total_amount DESC
LIMIT 10;

-- 5) DISTINCT
-- active 상태의 고유 이메일 목록
SELECT DISTINCT email
FROM large_table
WHERE status = 'active';

-- 6) 서브쿼리 NOT IN
-- blocked 상태의 유저를 제외한 데이터
SELECT *
FROM large_table
WHERE user_id NOT IN (
    SELECT id FROM lt_users WHERE status = 'blocked'
);

-- 7) JOIN
-- active 상태의 유저 데이터
SELECT p.*
FROM large_table p
JOIN lt_users u ON p.user_id = u.id
WHERE u.status = 'active';

-- 8) ORDER BY RAND()
-- 임의의 20개 데이터
SELECT *
FROM large_table
ORDER BY RAND()
LIMIT 20;

-- 9) 범위 조건 / 혼합
-- pending 상태이면서 amount가 100~200 사이
SELECT *
FROM large_table
WHERE status = 'pending'
  AND amount BETWEEN 100 AND 200;

-- 10) 큰 OFFSET
-- 최신순 20만 건 이후의 50개
SELECT *
FROM large_table
ORDER BY created_at DESC
LIMIT 50 OFFSET 200000;

