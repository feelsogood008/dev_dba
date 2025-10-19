#!/bin/bash
# 08_hybrid_cron.sh
# 혼합 백업 전략 자동화 (cron 실행용 + Slack 알림 포함)

DB_NAME="demo_db"
DATE=$(date +"%Y%m%d_%H%M%S")

BASE_DIR=./backup_strategy/hybrid_cron
SCHEMA_DIR=$BASE_DIR/schema_$DATE
DATA_DIR=$BASE_DIR/data_$DATE

# Slack Webhook URL (실제 값으로 교체)
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/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"

send_slack() {
    local message="$1"

    # 이스케이프 처리: 큰따옴표와 백슬래시가 포함된 메시지 대응
    local payload
    payload=$(printf '{"text":"%s"}' "$message")

    # curl 실행 (에러 로그는 /tmp 로 보냄)
    /usr/bin/curl -s -X POST -H 'Content-type: application/json' \
        --data "$payload" "$SLACK_WEBHOOK_URL" >/dev/null 2>>/tmp/slack_error.log
}


sudo mkdir -p $SCHEMA_DIR $DATA_DIR

echo "[Hybrid-Auto] $(date) - 스키마(DDL) 백업 시작"
# mysqldump -uroot -pP@ssw0rd --no-data --routines --triggers --events $DB_NAME > $SCHEMA_DIR/${DB_NAME}_schema.sql

sudo bash -c "mysqldump -uroot -pP@ssw0rd --no-data --routines --triggers --events ${DB_NAME} > ${SCHEMA_DIR}/${DB_NAME}_schema.sql"


if [ $? -ne 0 ]; then
    send_slack ":x: [백업 실패] 스키마 덤프 실패 - $DB_NAME @ $(date)"
    exit 1
fi

echo "[Hybrid-Auto] $(date) - 데이터(물리적) 백업 시작"
sudo xtrabackup --backup --user=root --password=P@ssw0rd \
  --target-dir=$DATA_DIR

if [ $? -ne 0 ]; then
    send_slack ":x: [백업 실패] 데이터 백업 실패 - $DB_NAME @ $(date)"
    exit 1
fi

# 보관 정책: 7일 이상 된 백업은 삭제
sudo find $BASE_DIR -type d -mtime +7 -exec rm -rf {} \; 2>/dev/null

send_slack ":white_check_mark: [백업 완료] $DB_NAME @ $(date)\n- 스키마: $SCHEMA_DIR/${DB_NAME}_schema.sql\n- 데이터 : $DATA_DIR"

echo "[Hybrid-Auto] $(date) - 백업 및 정리 완료"
