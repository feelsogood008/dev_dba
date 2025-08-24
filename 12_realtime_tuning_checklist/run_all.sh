#!/bin/bash
MYSQL_USER="root"
MYSQL_PWD="P@ssw0rd"


echo "[1] 부하 발생 시작"
./01_generate_load.sh &
LOAD_PID=$!
sleep 5

echo "[2] 현재 실행 중인 쿼리 확인"
mysql -u$MYSQL_USER -p$MYSQL_PWD < 02_show_processlist.sql

echo "[3] 락 상태 확인"
mysql -u$MYSQL_USER -p$MYSQL_PWD < 03_check_locks.sql

echo "[4] InnoDB 상태 확인"
mysql -u$MYSQL_USER -p$MYSQL_PWD < 04_check_innodb_status.sql

wait $LOAD_PID
