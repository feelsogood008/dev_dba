#!/bin/bash
MYSQL="mysql -u root -pYOURPASSWORD testdb"
LOGFILE="count_benchmark.log"

echo "===== COUNT(*) 성능 비교 시작 =====" > $LOGFILE
date >> $LOGFILE

echo -e "\n--- 데이터 준비 ---" >> $LOGFILE
$MYSQL < 25_create_data.sql >> $LOGFILE 2>&1

echo -e "\n--- 성능 비교 실행 ---" >> $LOGFILE
$MYSQL < 25_count_test.sql >> $LOGFILE 2>&1

echo -e "\n===== COUNT(*) 성능 비교 종료 =====" >> $LOGFILE
date >> $LOGFILE
