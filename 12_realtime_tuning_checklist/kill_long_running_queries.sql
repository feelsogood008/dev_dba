SELECT CONCAT('KILL ', id, ';')
FROM information_schema.processlist
WHERE time > 30
  AND command != 'Sleep';
