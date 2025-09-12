#!/bin/bash
# 혼합 전략 복구 예제
# 사용법: ./07_hybrid_restore.sh ./backup_strategy/hybrid/schema_xxxxx/demo_db_schema.sql ./backup_strategy/hybrid/data_xxxxx

SCHEMA_FILE=$1
DATA_DIR=$2
DATADIR=/var/lib/mysql

if [ ! -f "$SCHEMA_FILE" ]; then
  echo "에러: 스키마 파일($SCHEMA_FILE) 없음"
  exit 1
fi

if [ ! -d "$DATA_DIR" ]; then
  echo "에러: 데이터 백업 디렉토리($DATA_DIR) 없음"
  exit 1
fi

echo "[Hybrid] MySQL 서비스 중지"
systemctl stop mysql

echo "[Hybrid] 기존 데이터 삭제"
rm -rf $DATADIR/*

echo "[Hybrid] 데이터 복원 (xtrabackup)"
xtrabackup --copy-back --target-dir=$DATA_DIR
chown -R mysql:mysql $DATADIR

echo "[Hybrid] MySQL 서비스 시작"
systemctl start mysql

echo "[Hybrid] 스키마 복원 (mysqldump)"
mysql -uroot -p < $SCHEMA_FILE

echo "[완료] Hybrid 복구 완료"
