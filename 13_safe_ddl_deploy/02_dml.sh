#!/bin/bash

# 세션 1에서 실행

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

    # 1) UPDATE와 CONNECTION_ID()를 함께 실행, 결과(연결 id)를 변수로 받음
    PROCESSLIST_ID=$(mysql -u$DB_USER -p$DB_PASS $DB_NAME -N -e \
        "UPDATE orders SET status='$STATUS_VAL' WHERE id=$RAND_ID; SELECT CONNECTION_ID();")

    END_TIME=$(date +%s%N)
    ELAPSED_MS=$(( ($END_TIME - $START_TIME) / 1000000 ))

    # 2) 해당 연결의 thread 정보 조회
    THREAD_INFO=$(mysql -u$DB_USER -p$DB_PASS $DB_NAME -e \
        "SELECT PROCESSLIST_ID, THREAD_ID, NAME, TYPE FROM performance_schema.threads WHERE PROCESSLIST_ID=$PROCESSLIST_ID\G")

    echo "UPDATE id=$RAND_ID 실행 시간: ${ELAPSED_MS} ms (PROCESSLIST_ID: $PROCESSLIST_ID)"
    echo "$THREAD_INFO"
    sleep 1
done
