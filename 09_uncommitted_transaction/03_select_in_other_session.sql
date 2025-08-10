-- 03_select_in_other_session.sql
-- 다른 세션(커밋을 하지 않은 세션이 있는 상태)에서 데이터 조회 (변경 전 상태가 보여야 함)

USE demo_db;


SELECT 'other-session view: Keyboard 가격 50.00 이 그대로 나옴' AS note;
SELECT * FROM products ORDER BY id;
