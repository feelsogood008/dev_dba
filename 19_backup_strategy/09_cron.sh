#!/bin/bash
# 09_cron.sh
# 환경 초기화
source /etc/profile
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
export HOME=/home/tester

# 절대경로 지정
BASE_DIR="/home/tester/dev_dba/19_backup_strategy/backup_strategy/hybrid_cron/full_$(date +%Y%m%d_%H%M%S)"         

DB_NAME="demo_db"
DATE=$(date +"%Y%m%d_%H%M%S")
SCHEMA_DIR=$BASE_DIR/schema_$DATE
DATA_DIR=$BASE_DIR/data_$DATE

# Slack Webhook URL (실제 값으로 교체)
SLACK_WEBHOOK_URL="https://hooks.slack.com/services/xxx/yyy/zzz"

# Slack 메시지 전송 함수
send_slack() {
    MESSAGE="$1"
    # curl 실행
    /usr/bin/curl -s -X POST -H 'Content-type: application/json' --data "{\"text\":\"${MESSAGE}\"}" ${SLACK_WEBHOOK_URL} >/dev/null 2>>./slack_error.log
}

mkdir -p $SCHEMA_DIR $DATA_DIR

echo "[Hybrid-Auto] $(date) - 스키마(DDL) 백업 시작"
bash -c "mysqldump -uroot -pP@ssw0rd --no-data --routines --triggers --events ${DB_NAME} > ${SCHEMA_DIR}/${DB_NAME}_schema.sql"

if [ $? -ne 0 ]; then
    send_slack ":x: [백업 실패] 스키마 덤프 실패 - $DB_NAME @ $(date)"
    exit 1
fi

echo "[Hybrid-Auto] $(date) - 데이터(물리적) 백업 시작"
/usr/bin/xtrabackup --backup --user=root --password=P@ssw0rd --target-dir=$DATA_DIR

if [ $? -ne 0 ]; then
    send_slack ":x: [백업 실패] 데이터 백업 실패 - $DB_NAME @ $(date)"
    exit 1
fi


# 보관 정책: 7일 이상 된 백업은 삭제
find $BASE_DIR -type d -mtime +7 -exec rm -rf {} \; 2>/dev/null

send_slack ":white_check_mark: [백업 완료] $DB_NAME @ $(date)\n- 스키마: $SCHEMA_DIR/${DB_NAME}_schema.sql\n- 데이터 : $DATA_DIR"

echo "[Hybrid-Auto] $(date) - 백업 및 정리 완료"
