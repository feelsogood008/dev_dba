
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

-- E) 재귀 CTE 깊이 여유 확보
SET SESSION cte_max_recursion_depth = 500005;

-- F) lt_users: 50,000명 생성 (id = 1..50000)
WITH RECURSIVE u AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM u WHERE n < 50000
)
INSERT INTO lt_users (id, name, email, created_at, status)
SELECT
  n                                        AS id,
  CONCAT('user_', n)                       AS name,
  CONCAT('user_', n, '@example.com')       AS email,
  FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()) - (n % 864000)) AS created_at, -- 최근 10일 분포
  CASE
    WHEN n % 13 = 0 THEN 'blocked'
    WHEN n % 7  = 0 THEN 'dormant'
    ELSE 'active'
  END                                       AS status
FROM u;
COMMIT;

-- G) large_table: 500,000행 생성 (n=1..500000)
WITH RECURSIVE seq AS (
  SELECT 1 AS n
  UNION ALL
  SELECT n + 1 FROM seq WHERE n < 500000
)
INSERT INTO large_table
(user_id, category_id, title, content, created_at, status, amount, email, ip, view_count)
SELECT
  ((n - 1) % 50000) + 1                          AS user_id,          -- lt_users 5만명과 조인 가능
  ((n - 1) % 100) + 1                            AS category_id,      -- 100개 카테고리
  CONCAT('Title ', n, CASE WHEN n % 97 = 0 THEN ' special sale' ELSE '' END) AS title,
  RPAD(CONCAT('lorem ', n, ' ipsum '), 256, 'x') AS content,          -- LIKE 대상
  FROM_UNIXTIME(UNIX_TIMESTAMP(NOW()) - (n % 2592000)) AS created_at, -- 최근 30일
  CASE
    WHEN n % 10 = 0 THEN 'archived'
    WHEN n % 3  = 0 THEN 'pending'
    ELSE 'active'
  END                                             AS status,
  ROUND((n % 100000) / 100.0, 2)                  AS amount,          -- 0.00 ~ 999.99
  CONCAT('user', ((n - 1) % 50000) + 1, '@example', (n % 10), '.com') AS email,
  CONCAT(n % 255, '.', (n*3) % 255, '.', (n*7) % 255, '.', (n*11) % 255) AS ip,
  (n % 10000)                                     AS view_count
FROM seq;
COMMIT;

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

