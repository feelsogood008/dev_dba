#!/bin/bash
# 전체 mysqldump 백업 전략 예제
# 사용법: ./01_full_backup_mysqldump.sh demo_db

DB_NAME=$1
BACKUP_DIR=./backup_strategy/mysqldump_full
DATE=$(date +"%Y%m%d_%H%M%S")

mkdir -p $BACKUP_DIR

echo "[mysqldump 전략] ${DB_NAME} 전체 백업 수행..."
mysqldump -uroot -p --single-transaction --routines --triggers \
  $DB_NAME > $BACKUP_DIR/${DB_NAME}_full_${DATE}.sql

echo "[완료] 파일: $BACKUP_DIR/${DB_NAME}_full_${DATE}.sql"
