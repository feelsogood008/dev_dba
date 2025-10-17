#!/bin/bash
# 특정 테이블만 백업하는 전략
# 사용법: ./02_logical_partial_backup.sh demo_db table1 [table2 table3 ...]

DB_NAME=$1
shift  # DB_NAME 인자를 제거하고 나머지는 테이블 이름으로 사용
TABLES=$@
BACKUP_DIR=./backup_strategy/mysqldump_partial
DATE=$(date +"%Y%m%d_%H%M%S")

# 입력 인자 확인
if [ -z "$DB_NAME" ] || [ -z "$TABLES" ]; then
  echo "사용법: $0 <DB_NAME> <TABLE_NAME ...>"
  echo "예:    ./02_logical_partial_backup.sh demo_db users orders"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

echo "[mysqldump 전략] ${DB_NAME} 데이터베이스의 테이블만 백업 중..."
mysqldump -uroot -p "$DB_NAME" $TABLES > "$BACKUP_DIR/${DB_NAME}_partial_${DATE}.sql"

echo "[완료] 파일: $BACKUP_DIR/${DB_NAME}_partial_${DATE}.sql"
