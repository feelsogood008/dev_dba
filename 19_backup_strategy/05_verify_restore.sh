#!/bin/bash
# 복구 검증 (풀백업 파일을 이용한 복원)
# 사용법: ./05_verify_restore.sh ./backup_strategy/xtrabackup_full/full_xxxxx

BACKUP_DIR=$1
DATADIR=/var/lib/mysql

if [ ! -d "$BACKUP_DIR" ]; then
  echo "에러: 대상 백업 디렉토리가 없음"
  exit 1
fi


echo "[백업 준비] prepare(redo 로그 적용)"
sudo xtrabackup --prepare --target-dir=$BACKUP_DIR

echo "[검증] MySQL 서비스 중지"
sudo systemctl stop mysql

echo "[검증] 기존 데이터 삭제 후 복원"
sudo rm -rf $DATADIR/* 
sudo xtrabackup --copy-back --target-dir=$BACKUP_DIR --datadir=$DATADIR
sudo chown -R mysql:mysql $DATADIR

# xtrabackup: Can't create/write to file '/var/log/mysql/mysql-bin.000xxx' (OS errno 17 - File exists) 와 같은
# 에러 발생시에는 sudo xtrabackup --no-defaults --copy-back --target-dir=$BACKUP_DIR --datadir=$DATADIR 처럼
# --no-defaults 옵션을 추가한다.

echo "[검증] MySQL 서비스 시작"
sudo systemctl start mysql

echo "[완료] 복구 검증 성공"
