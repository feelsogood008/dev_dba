
USE demo_db;

-- email 기준 중복 탐지
SELECT email, COUNT(*) AS cnt
FROM customers
GROUP BY email
HAVING COUNT(*) > 1;

-- (보조) name+phone 기준 중복 탐지
SELECT name, phone, COUNT(*) AS cnt
FROM customers
GROUP BY name, phone
HAVING COUNT(*) > 1;


