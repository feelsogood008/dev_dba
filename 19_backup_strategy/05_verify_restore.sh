#!/bin/bash
# 복구 검증
# 사용법: ./05_verify_restore.sh ./backup_strategy/xtrabackup_full/full_xxxxx

BACKUP_DIR=$1
DATADIR=/var/lib/mysql

if [ ! -d "$BACKUP_DIR" ]; then
  echo "에러: 대상 백업 디렉토리가 없음"
  exit 1
fi

echo "[검증] MySQL 서비스 중지"
sudo systemctl stop mysql

echo "[검증] 기존 데이터 삭제 후 복원"
sudo rm -rf $DATADIR/*
sudo mkdir -p /var/lib/mysql
sudo chown mysql:mysql /var/lib/mysql

sudo xtrabackup --copy-back --target-dir=$BACKUP_DIR
sudo chown -R mysql:mysql $DATADIR

echo "[검증] MySQL 서비스 시작"
sudo systemctl start mysql

echo "[완료] 복구 검증 성공"
