#!/bin/bash

# 세션2 에서 실행

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
    mysql -u$DB_USER -p$DB_PASS $DB_NAME -e "SELECT ml.OBJECT_TYPE, ml.OBJECT_SCHEMA, ml.OBJECT_NAME, ml.LOCK_TYPE, ml.LOCK_STATUS, t.PROCESSLIST_ID, t.PROCESSLIST_USER, t.PROCESSLIST_INFO FROM performance_schema.metadata_locks ml JOIN performance_schema.threads t ON ml.OWNER_THREAD_ID = t.THREAD_ID WHERE ml.OBJECT_NAME = 'orders';"    
    echo "---"
    sleep 1
done
