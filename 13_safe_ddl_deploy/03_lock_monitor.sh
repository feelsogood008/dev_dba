#!/bin/bash

DB_USER="root"
DB_PASS="P@ssw0rd"
DB_NAME="demo_db"

stop_script() {
    echo "중지 요청됨, 락 모니터링 스크립트를 종료합니다."
    exit 0
}
trap stop_script SIGINT

while true; do
    CUR_TIME=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$CUR_TIME] metadata_locks:"
    mysql -u$DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM performance_schema.metadata_locks WHERE OBJECT_NAME='orders';"
    echo "[$CUR_TIME] data_locks:"
    mysql -u$DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM performance_schema.data_locks WHERE OBJECT_NAME='orders';"
    echo "[$CUR_TIME] data_lock_waits:"
    mysql -u$DB_USER -p$DB_PASS $DB_NAME -e "SELECT * FROM performance_schema.data_lock_waits;"
    echo "---"
    sleep 1
done
