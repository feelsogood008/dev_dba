#!/bin/bash
# ---------------------------------------------------------------------------
# MySQL InnoDB Lock Monitoring Script (0.5 sec interval)
# ---------------------------------------------------------------------------
# 파일명: lock_monitor.sh
# 설명 : InnoDB 레코드 락/인덱스 락 경합을 0.5초 단위로 모니터링
# 사용법: ./lock_monitor.sh [DB_USER] [DB_PASS] [DB_NAME] [OUTPUT_FILE(optional)]
# 예시 : ./lock_monitor.sh root P@ssw0rd demo_db lock_log.txt
# ---------------------------------------------------------------------------

USER=$1
PASS=$2
DB=$3
OUTFILE=$4

if [ -z "$USER" ] || [ -z "$PASS" ] || [ -z "$DB" ]; then
  echo "Usage: $0 [DB_USER] [DB_PASS] [DB_NAME] [OUTPUT_FILE(optional)]"
  exit 1
fi

INTERVAL=0.5  # 모니터링 주기(초)
MYSQL_CMD="mysql -u${USER} -p${PASS} -D ${DB} -N -e"

QUERY="
SELECT
  NOW() AS ts,
  r.trx_id AS waiting_trx,
  r.trx_mysql_thread_id AS waiting_thread,
  LEFT(r.trx_query, 80) AS waiting_query,
  b.trx_id AS blocking_trx,
  b.trx_mysql_thread_id AS blocking_thread,
  p.object_schema,
  p.object_name,
  p.lock_type,
  p.lock_mode,
  p.lock_status
FROM performance_schema.data_locks p
JOIN information_schema.innodb_trx r
  ON p.engine_transaction_id = r.trx_id
LEFT JOIN information_schema.innodb_trx b
  ON r.trx_id != b.trx_id
WHERE p.lock_status = 'WAITING'
ORDER BY ts DESC;
"

echo "🔍 Lock Monitoring started (interval: ${INTERVAL}s)"
echo "Press [Ctrl+C] to stop."

while true; do
  OUTPUT=$($MYSQL_CMD "$QUERY")

  if [ -n "$OUTPUT" ]; then
    echo "--------------------------------------------"
    echo "$(date '+%Y-%m-%d %H:%M:%S.%3N') - Detected lock wait:"
    echo "$OUTPUT"
    echo ""
    # 로그 파일 지정 시 저장
    if [ -n "$OUTFILE" ]; then
      echo "$(date '+%Y-%m-%d %H:%M:%S.%3N')" >> "$OUTFILE"
      echo "$OUTPUT" >> "$OUTFILE"
      echo "" >> "$OUTFILE"
    fi
  fi

  sleep $INTERVAL
done
