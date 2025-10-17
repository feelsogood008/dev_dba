
#!/bin/bash
# xtrabackup 특정 DB 백업
# 사용법: ./03_full_backup_xtrabackup.sh <DB_NAME>

DB_NAME=$1
BACKUP_DIR=./backup_strategy/xtrabackup_full/full_$(date +"%Y%m%d_%H%M%S")

# 입력 인자 확인
if [ -z "$DB_NAME" ]; then
  echo "사용법: $0 <DB_NAME>"
  echo "예:    ./03_full_backup_xtrabackup.sh demo_db"
  exit 1
fi

mkdir -p "$BACKUP_DIR"

echo "[xtrabackup 전략] ${DB_NAME} 데이터베이스 전체 백업 시작..."
xtrabackup --backup \
  --user=root \
  --password=비밀번호 \
  --target-dir="$BACKUP_DIR" \
  --databases="$DB_NAME" 

echo "[완료] 디렉토리: $BACKUP_DIR"
