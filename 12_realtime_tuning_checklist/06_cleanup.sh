#!/bin/bash
# sysbench 정리 및 DB삭제

MYSQL_USER="root"
MYSQL_PWD="P@ssw0rd"
MYSQL_DB="demo_db"


echo "[1] sysbench 벤치마크 데이터정리"
sysbench \
  --db-driver=mysql \
  --mysql-user=$MYSQL_USER \
  --mysql-password=$MYSQL_PWD \
  --mysql-db=$MYSQL_DB \
  --table-size=1000000 \
  --tables=5 \
  oltp_read_write cleanup


echo "[2] 테스트 DB 삭제"
mysql -u$MYSQL_USER -p$MYSQL_PWD -e "DROP DATABASE $MYSQL_DB;"

