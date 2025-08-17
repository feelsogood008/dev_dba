#!/bin/bash
BINLOG_FILE=$1
START_TIME=$2
END_TIME=$3

RAW_SQL="binlog_extracted.sql"
FILTERED_SQL="binlog_filtered.sql"

if [ -z "$BINLOG_FILE" ] || [ -z "$START_TIME" ] || [ -z "$END_TIME" ]; then
  echo "사용법: $0 <BINLOG_FILE> <START_TIME> <END_TIME>"
  exit 1
fi

echo "[1] binlog 추출"
mysqlbinlog \
  --start-datetime="$START_TIME" \
  --stop-datetime="$END_TIME" \
  --verbose \
  $BINLOG_FILE > $RAW_SQL

echo "[2] DELETE / UPDATE / CREATE TABLE 필터링"
awk 'BEGIN{skip=0}
     /DELETE /{skip=1}
     /UPDATE /{skip=1}
     /CREATE TABLE/{skip=1}
     /^# at/{skip=0}
     skip==0 {print}' $RAW_SQL > $FILTERED_SQL

echo "[완료] 필터링된 SQL → $FILTERED_SQL"


echo "[적용] binlog_filtered.sql → ${DB_NAME}"
mysql -u root -p"${MYSQL_PWD}" ${DB_NAME} < <(
  grep -v "CREATE TABLE" binlog_filtered.sql
)
