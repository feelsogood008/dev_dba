#!/bin/bash
MYSQL_USER="root"
MYSQL_PWD="P@ssw0rd"

echo "[1] 초기 데이터 입력"
mysql -u$MYSQL_USER -p$MYSQL_PWD < 01_create_table_insert_data.sql


echo "[2] 풀백업 생성"
BACKUP_FILE="full_backup_$(date +%Y%m%d_%H%M%S).sql"

mysqldump -u $MYSQL_USER -p$MYSQL_PASS \
  --databases demo_db \
  --single-transaction \
  --source-data=2 \
  > $BACKUP_FILE

echo "풀백업 생성 완료: $BACKUP_FILE"


echo "[3] binlog 생성용 업데이트 실행"
mysql -u$MYSQL_USER -p$MYSQL_PWD demo_db -e "UPDATE customers SET email = CONCAT(email, '.kr') WHERE id <= 50;"
