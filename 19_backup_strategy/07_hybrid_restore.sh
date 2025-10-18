#!/bin/bash
# 혼합 전략 복구 예제
# 사용법: ./07_hybrid_restore.sh ./backup_strategy/hybrid/schema_xxxxx/demo_db_schema.sql ./backup_strategy/hybrid/data_xxxxx

SCHEMA_FILE=$1
BACKUP_DIR=$2
DATADIR=/var/lib/mysql

if [ ! -f "$SCHEMA_FILE" ]; then
  echo "에러: 스키마 파일($SCHEMA_FILE) 없음"
  exit 1
fi

if [ ! -d "$BACKUP_DIR" ]; then
  echo "에러: 데이터 백업 디렉토리($BACKUP_DIR) 없음"
  exit 1
fi

echo "[Hybrid] 백업준비(prepare)"
sudo xtrabackup --prepare --target-dir=$BACKUP_DIR

echo "[Hybrid] MySQL 서비스 중지"
sudo systemctl stop mysql

echo "[Hybrid] 기존 데이터 삭제"
sudo rm -rf $DATADIR/*

echo "[Hybrid] 데이터 복원 (xtrabackup)"
sudo xtrabackup --copy-back --target-dir=$BACKUP_DIR
sudo chown -R mysql:mysql $DATADIR

echo "[Hybrid] MySQL 서비스 시작"
sudo systemctl start mysql

echo "[Hybrid] 스키마 복원 (mysqldump)"
sudo mysql -uroot -pP@ssw0rd < $SCHEMA_FILE

echo "[완료] Hybrid 복구 완료"
