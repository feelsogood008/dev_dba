#!/bin/bash

DB_USER="root"
DB_PASS="P@ssw0rd"
DB_NAME="demo_db"
STATUS_VAL="completed"

stop_script() {
    echo "중지 요청됨, 스크립트를 종료합니다."
    exit 0
}
trap stop_script SIGINT

while true; do
    RAND_ID=$(( ( RANDOM % 1000000 ) + 1 ))
    START_TIME=$(date +%s%N)
    mysql -u$DB_USER -p$DB_PASS $DB_NAME -e "UPDATE orders SET status='$STATUS_VAL' WHERE id=$RAND_ID;"
    END_TIME=$(date +%s%N)
    ELAPSED_MS=$(( ($END_TIME - $START_TIME) / 1000000 ))
    echo "UPDATE id=$RAND_ID 실행 시간: ${ELAPSED_MS} ms"
    sleep 1
done
