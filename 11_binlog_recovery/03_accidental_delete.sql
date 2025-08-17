
USE demo_db;

SELECT SYSDATE() AS '데이터 삭제(실수)전 시간' FROM DUAL;

DELETE FROM customers WHERE id <= 30;

SELECT '삭제 후 데이터 개수' AS step, COUNT(*) AS total_rows, SYSDATE() AS '현재시간'
FROM customers;
