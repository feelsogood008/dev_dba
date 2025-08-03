#!/bin/bash

echo "[undo 로그 상태를 2초 간격으로 100회 확인합니다.]"
trap "echo '루프 중단됨'; exit" SIGINT

for i in {1..100}
do
  echo "[$i 회차] undo 로그 모니터링 중... (중단하려면 Ctrl+C)"
  mysql -u root -pP@ssw0rd -e "
      SELECT 
          trx.trx_id AS trx_id,
          trx.trx_started AS trx_start_time,
          TIMESTAMPDIFF(SECOND, trx.trx_started, NOW()) AS trx_duration_sec,
          trx.trx_state,
          trx.trx_query AS last_query,
          p.id AS process_id,
          p.user AS user,
          p.host AS host,
          p.command,
          p.time AS thread_time,
          p.info AS current_sql
      FROM information_schema.innodb_trx trx
      JOIN information_schema.processlist p
          ON trx.trx_mysql_thread_id = p.id
      ORDER BY trx_duration_sec DESC;
  "
  sleep 2
done
