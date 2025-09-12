#!/bin/bash
# 특정 테이블만 백업하는 전략
# 사용법: ./02_logical_partial_backup.sh demo_db

DB_NAME=$1
BACKUP_DIR=./backup_strategy/mysqldump_partial
DATE=$(date +"%Y%m%d_%H%M%S")

mkdir -p $BACKUP_DIR

echo "[mysqldump 전략] ${DB_NAME} 일부 테이블만 백업 (logs 제외)"
mysqldump -uroot -p $DB_NAME --ignore-table=${DB_NAME}.logs \
  > $BACKUP_DIR/${DB_NAME}_partial_${DATE}.sql

echo "[완료] 파일: $BACKUP_DIR/${DB_NAME}_partial_${DATE}.sql"
