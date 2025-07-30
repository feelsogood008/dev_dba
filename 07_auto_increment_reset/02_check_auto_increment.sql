
USE demo_db;



SELECT AUTO_INCREMENT 
FROM information_schema.TABLES 
WHERE TABLE_SCHEMA = 'demo_db' 
  AND TABLE_NAME = 'user_test';
