#!/bin/bash
# 혼합 백업 전략 예제
# 스키마: mysqldump
# 데이터: xtrabackup
# 사용법: ./06_hybrid_backup.sh demo_db

DB_NAME=$1
DATE=$(date +"%Y%m%d_%H%M%S")

BASE_DIR=./backup_strategy/hybrid
SCHEMA_DIR=$BASE_DIR/schema_$DATE
DATA_DIR=$BASE_DIR/data_$DATE

mkdir -p $SCHEMA_DIR $DATA_DIR

echo "[Hybrid] 1. 스키마(DDL) 백업 (mysqldump)"
mysqldump -uroot -p --no-data --routines --triggers --events $DB_NAME \
  > $SCHEMA_DIR/${DB_NAME}_schema.sql

echo "[Hybrid] 2. 데이터(물리적) 백업 (xtrabackup)"
xtrabackup --backup --user=root --password=비밀번호 \
  --target-dir=$DATA_DIR

echo "[완료] 스키마: $SCHEMA_DIR/${DB_NAME}_schema.sql"
echo "[완료] 데이터: $DATA_DIR"
