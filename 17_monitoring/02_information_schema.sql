-- 1) 외래키 없는 테이블 찾기 (데이터 무결성 관리 확인)
SELECT table_schema, table_name
FROM information_schema.tables t
WHERE t.table_schema = 'demo_db'
  AND t.table_type = 'BASE TABLE'
  AND NOT EXISTS (
    SELECT 1
    FROM information_schema.key_column_usage k
    WHERE t.table_name = k.table_name
      AND t.table_schema = k.table_schema
      AND k.referenced_table_name IS NOT NULL
  );

-- 2) 인덱스 없는 테이블 찾기 (풀스캔 위험)
SELECT table_schema, table_name
FROM information_schema.tables t
WHERE t.table_schema = 'demo_db'
  AND t.table_type = 'BASE TABLE'
  AND NOT EXISTS (
    SELECT 1
    FROM information_schema.statistics s
    WHERE t.table_schema = s.table_schema
      AND t.table_name = s.table_name
  );


-- 3) 테이블/인덱스 용량 순위
SELECT table_schema, table_name,
       ROUND((data_length+index_length)/1024/1024, 2) AS size_mb
FROM information_schema.tables
WHERE table_schema = 'demo_db'
ORDER BY size_mb DESC
LIMIT 10;



-- 4) AUTO_INCREMENT 임계치 임박 테이블
SELECT
    t.table_schema,
    t.table_name,
    t.auto_increment,
    c.data_type,
    CASE
      WHEN c.data_type = 'tinyint'  AND c.column_type LIKE '%unsigned%' THEN 255
      WHEN c.data_type = 'tinyint'  THEN 127
      WHEN c.data_type = 'smallint' AND c.column_type LIKE '%unsigned%' THEN 65535
      WHEN c.data_type = 'smallint' THEN 32767
      WHEN c.data_type = 'mediumint' AND c.column_type LIKE '%unsigned%' THEN 16777215
      WHEN c.data_type = 'mediumint' THEN 8388607
      WHEN c.data_type = 'int'      AND c.column_type LIKE '%unsigned%' THEN 4294967295
      WHEN c.data_type = 'int'      THEN 2147483647
      WHEN c.data_type = 'bigint'   AND c.column_type LIKE '%unsigned%' THEN 18446744073709551615
      WHEN c.data_type = 'bigint'   THEN 9223372036854775807
      ELSE NULL
    END AS max_value
FROM information_schema.tables t
JOIN information_schema.columns c
  ON t.table_schema = c.table_schema
  AND t.table_name = c.table_name
WHERE t.table_schema = 'demo_db'
  AND c.extra = 'auto_increment';
  