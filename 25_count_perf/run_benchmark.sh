#!/bin/bash
MYSQL="mysql -u root -pP@ssw0rd demo_db"
LOGFILE="count_benchmark.log"

echo "===== COUNT(*) 성능 비교 시작 =====" > $LOGFILE
date >> $LOGFILE

echo -e "\n--- 성능 비교 실행 ---" >> $LOGFILE
$MYSQL < 02_count_test.sql >> $LOGFILE 2>&1

echo -e "\n===== COUNT(*) 성능 비교 종료 =====" >> $LOGFILE
date >> $LOGFILE
