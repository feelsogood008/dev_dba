

CREATE DATABASE IF NOT EXISTS demo_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;


USE demo_db;


-- 테스트 테이블 생성
DROP TABLE IF EXISTS slow_test;
CREATE TABLE slow_test (
    id INT PRIMARY KEY AUTO_INCREMENT,
    data TEXT
);

-- 100만 건 데이터 삽입
INSERT INTO slow_test (data)
SELECT REPEAT('x', 1000)
FROM information_schema.tables a,
     information_schema.tables b
LIMIT 1000000;


-- 인덱스 없이 느린 쿼리 유도
SELECT * FROM slow_test WHERE data LIKE '%zzz%';


-- 불필요한 FULL SCAN
SELECT COUNT(*) FROM slow_test WHERE id > 0 ORDER BY data;
