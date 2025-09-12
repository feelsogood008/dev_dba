#!/bin/bash
# 08_hybrid_cron.sh
# 혼합 백업 전략 자동화 (cron 실행용 + Slack 알림 포함)

DB_NAME="demo_db"
DATE=$(date +"%Y%m%d_%H%M%S")

BASE_DIR=/var/backups/mysql/hybrid
SCHEMA_DIR=$BASE_DIR/schema_$DATE
DATA_DIR=$BASE_DIR/data_$DATE

# Slack Webhook URL (실제 값으로 교체 필요)
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/XXXXX/XXXXX/XXXXXXXX"

send_slack() {
    local message="$1"
    curl -X POST -H 'Content-type: application/json' \
        --data "{\"text\":\"$message\"}" $SLACK_WEBHOOK_URL >/dev/null 2>&1
}

mkdir -p $SCHEMA_DIR $DATA_DIR

echo "[Hybrid-Auto] $(date) - 스키마(DDL) 백업 시작"
mysqldump -uroot -p비밀번호 --no-data --routines --triggers --events $DB_NAME \
  > $SCHEMA_DIR/${DB_NAME}_schema.sql

if [ $? -ne 0 ]; then
    send_slack ":x: [백업 실패] 스키마 덤프 실패 - $DB_NAME @ $(date)"
    exit 1
fi

echo "[Hybrid-Auto] $(date) - 데이터(물리적) 백업 시작"
xtrabackup --backup --user=root --password=비밀번호 \
  --target-dir=$DATA_DIR

if [ $? -ne 0 ]; then
    send_slack ":x: [백업 실패] 데이터 백업 실패 - $DB_NAME @ $(date)"
    exit 1
fi

# 보관 정책: 7일 이상 된 백업은 삭제
find $BASE_DIR -type d -mtime +7 -exec rm -rf {} \; 2>/dev/null

send_slack ":white_check_mark: [백업 완료] $DB_NAME @ $(date)\n- 스키마: $SCHEMA_DIR/${DB_NAME}_schema.sql\n- 데이터 : $DATA_DIR"
echo "[Hybrid-Auto] $(date) - 백업 및 정리 완료"
