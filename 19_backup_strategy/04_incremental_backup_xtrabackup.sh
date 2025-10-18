#!/bin/bash
# xtrabackup 증분 백업
# 사용법: ./04_incremental_backup_xtrabackup.sh ./backup_strategy/xtrabackup_full/full_xxxxx

BASE_DIR=$1
INC_DIR=./backup_strategy/xtrabackup_inc/inc_$(date +"%Y%m%d_%H%M%S")

if [ ! -d "$BASE_DIR" ]; then
  echo "에러: 전체 백업 디렉토리($BASE_DIR) 없음"
  exit 1
fi

mkdir -p $INC_DIR

echo "[xtrabackup 전략] 증분 백업 시작..."
sudo xtrabackup --backup --user=root --password=P@ssw0rd \
  --target-dir=$INC_DIR --incremental-basedir=$BASE_DIR

echo "[완료] 디렉토리: $INC_DIR"
