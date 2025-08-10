-- 04_detect_uncommitted.sql
-- information_schema를 사용하여 현재 진행중인 트랜잭션(미커밋)을 확인
-- trx_mysql_thread_id로 MySQL 쓰레드 id를 얻을 수 있어 (KILL 대상)

USE demo_db;


SELECT
  trx.trx_id,
  trx.trx_started,
  TIMESTAMPDIFF(SECOND, trx.trx_started, NOW()) AS duration_seconds,
  trx.trx_state,
  trx.trx_query,
  trx.trx_mysql_thread_id
FROM information_schema.innodb_trx trx
ORDER BY duration_seconds DESC;


-- 추가로 현재 프로세스 목록도 같이 보면 편하다
SELECT * FROM information_schema.processlist WHERE COMMAND != 'Sleep' OR TIME > 0 ORDER BY TIME DESC LIMIT 20;
