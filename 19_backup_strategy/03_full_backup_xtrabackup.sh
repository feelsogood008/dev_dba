#!/bin/bash
# xtrabackup 전체 백업
# 사용법: ./03_full_backup_xtrabackup.sh

BACKUP_DIR=./backup_strategy/xtrabackup_full/full_$(date +"%Y%m%d_%H%M%S")

mkdir -p $BACKUP_DIR

echo "[xtrabackup 전략] 전체 백업 시작..."
xtrabackup --backup --user=root --password=비밀번호 \
  --target-dir=$BACKUP_DIR

echo "[완료] 디렉토리: $BACKUP_DIR"
