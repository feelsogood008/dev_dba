#!/bin/bash
# sysbench 설치 및 테스트 테이블 준비

MYSQL_USER="root"
MYSQL_PWD="P@ssw0rd"
MYSQL_DB="demo_db"

echo "[1] sysbench 설치"
sudo apt-get update
sudo apt-get install -y sysbench

echo "[2] 테스트 DB 생성"
mysql -u$MYSQL_USER -p$MYSQL_PWD -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB;"

echo "[3] sysbench 데이터 로드"
sysbench \
  --db-driver=mysql \
  --mysql-user=$MYSQL_USER \
  --mysql-password=$MYSQL_PWD \
  --mysql-db=$MYSQL_DB \
  --table-size=1000000 \
  --tables=5 \
  oltp_read_write prepare

