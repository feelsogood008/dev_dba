
USE demo_db;

SELECT SYSDATE() AS '데이터 삭제(실수)전 시간' FROM DUAL;

DELETE FROM customers WHERE id <= 30;

