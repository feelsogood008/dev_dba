#!/bin/bash
# check_health.sh : MySQL 주기 점검 자동화 + 변화량 추적 + 알림

DB_USER="root"
DB_PASS="P@ssw0rd"
DB_NAME="demo_db"
MONITOR_DB="demo_db"
DATE=$(date +"%Y-%m-%d %H:%M:%S")

# Slack Webhook URL (사전 발급 필요)
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXX/YYY/ZZZ"

# 점검값 수집
threads_conn=$(mysql -u$DB_USER -p$DB_PASS -Nse "SHOW STATUS LIKE 'Threads_connected';" | awk '{print $2}')
slow_queries=$(mysql -u$DB_USER -p$DB_PASS -Nse "SHOW GLOBAL STATUS LIKE 'Slow_queries';" | awk '{print $2}')
read top_table top_table_mb <<< $(mysql -u$DB_USER -p$DB_PASS -Nse "
  SELECT CONCAT(table_schema,'.',table_name),
         ROUND((data_length+index_length)/1024/1024)
  FROM information_schema.tables
  WHERE table_schema NOT IN ('mysql','performance_schema','information_schema','sys')
  ORDER BY (data_length+index_length) DESC LIMIT 1;")
no_index_cnt=$(mysql -u$DB_USER -p$DB_PASS -Nse "
  SELECT COUNT(*) 
  FROM information_schema.tables t
  WHERE NOT EXISTS (
      SELECT 1 FROM information_schema.statistics s
      WHERE t.table_schema=s.table_schema AND t.table_name=s.table_name
  )
  AND t.table_schema NOT IN ('mysql','performance_schema','information_schema','sys');")

# 결과 저장
mysql -u$DB_USER -p$DB_PASS $MONITOR_DB -e "
INSERT INTO check_history (check_time, threads_conn, slow_queries, top_table, top_table_mb, no_index_cnt)
VALUES ('$DATE', $threads_conn, $slow_queries, '$top_table', $top_table_mb, $no_index_cnt);
"

# 직전 데이터와 비교 (변화량 계산)
read prev_threads prev_slow prev_mb prev_noidx <<< $(mysql -u$DB_USER -p$DB_PASS -Nse "
  SELECT threads_conn, slow_queries, top_table_mb, no_index_cnt
  FROM check_history
  ORDER BY id DESC LIMIT 1 OFFSET 1;" $MONITOR_DB)

delta_threads=$((threads_conn - prev_threads))
delta_slow=$((slow_queries - prev_slow))
delta_mb=$((top_table_mb - prev_mb))
delta_noidx=$((no_index_cnt - prev_noidx))

# 임계값 체크
ALERT_MSG=""
[ $delta_threads -gt 100 ] && ALERT_MSG+="🚨 연결 수 급증: +$delta_threads\n"
[ $delta_slow -gt 500 ] && ALERT_MSG+="🚨 슬로우 쿼리 급증: +$delta_slow\n"
[ $delta_mb -gt 100 ] && ALERT_MSG+="🚨 테이블크기 증가: +${delta_mb}MB ($top_table)\n"
[ $delta_noidx -gt 0 ] && ALERT_MSG+="🚨 인덱스없는 테이블 증가: +$delta_noidx\n"

# 알림 전송
if [ -n "$ALERT_MSG" ]; then
    # Slack 알림
    curl -X POST -H 'Content-type: application/json' \
      --data "{\"text\":\"[MySQL Alert] $DATE\n$ALERT_MSG\"}" \
      $SLACK_WEBHOOK_URL

    # 이메일 알림
    echo -e "$ALERT_MSG" | mail -s "[MySQL Alert] $DATE" admin@example.com
fi
