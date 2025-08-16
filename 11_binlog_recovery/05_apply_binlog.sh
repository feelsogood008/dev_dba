#!/bin/bash
DB_NAME=$1
MYSQL_USER="root"
MYSQL_PWD="P@ssw0rd"

FILTERED_SQL="binlog_filtered.sql"

if [ -z "$DB_NAME" ]; then
  echo "사용법: $0 <DB_NAME>"
  exit 1
fi

if [ ! -f "$FILTERED_SQL" ]; then
  echo "[에러] $FILTERED_SQL 파일이 없습니다. 먼저 04_extract_binlog.sh 실행하세요."
  exit 1
fi



echo "[적용] $FILTERED_SQL → $DB_NAME"
mysql -u$MYSQL_USER -p$MYSQL_PWD $DB_NAME < $FILTERED_SQL
echo "[완료] binlog 적용 완료"
