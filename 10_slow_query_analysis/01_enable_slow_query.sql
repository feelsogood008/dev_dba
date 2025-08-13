
-- slow query log 활성화
SET GLOBAL slow_query_log = 'ON';

-- 로그 파일 위치 지정 (환경에 맞게 수정)
SET GLOBAL slow_query_log_file = '/var/lib/mysql/mysql-slow.log';

-- 0.5초 이상 걸린 쿼리부터 기록
SET GLOBAL long_query_time = 0.5;

-- 슬로우 로그에 비인덱스 SELECT도 포함
SET GLOBAL log_queries_not_using_indexes = 1;

-- 현재 설정 확인
SHOW VARIABLES LIKE '%slow_query%';
SHOW VARIABLES LIKE '%long_query_time%';
SHOW VARIABLES LIKE '%log_queries_not_using_indexes%';

