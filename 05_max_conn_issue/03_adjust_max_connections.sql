-- max_connections 값 일시 변경 (세션에서만 유효)
SET GLOBAL max_connections = 300;

-- 변경된 값 확인
SHOW VARIABLES LIKE 'max_connections';
