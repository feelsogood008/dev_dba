#!/bin/bash

echo "[undo 로그 상태를 1초 간격으로 30회 확인합니다.]"

for i in {1..30}
do
  echo "[$i 회차]"
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
  sleep 1
done
