#!/bin/bash
FULLBACKUP_FILE_NAME=$1
DB_NAME="demo_db"
MYSQL_USER="root"
MYSQL_PWD="P@ssw0rd"

FILTERED_SQL="binlog_filtered.sql"

if [ -z "$FULLBACKUP_FILE_NAME" ]; then
  echo "사용법: $0 <FULLBACKUP_FILE_NAME>"
  exit 1
fi

if [ ! -f "$FILTERED_SQL" ]; then
  echo "[에러] $FILTERED_SQL 파일이 없습니다. 먼저 04_extract_binlog.sh 실행하세요."
  exit 1
fi

# demo_db 삭제 후 풀백업 파일에서 복구하기
echo "demo_db 삭제"
mysql -u$MYSQL_USER -p"$MYSQL_PWD" -e "DROP DATABASE IF EXISTS $DB_NAME;"

echo "[풀백업 적용] full_backup_xxxx.sql → ${DB_NAME}"
mysql -u$MYSQL_USER -p"$MYSQL_PWD" $DB_NAME < $FULLBACKUP_FILE_NAME


echo "[적용] $FILTERED_SQL → $DB_NAME"
mysql -u$MYSQL_USER -p$MYSQL_PWD $DB_NAME < $FILTERED_SQL
echo "[완료] binlog 적용 완료"
