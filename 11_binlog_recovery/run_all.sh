#!/bin/bash
MYSQL_USER="root"
MYSQL_PWD="P@ssw0rd"

echo "[1] 테이블 생성과 초기 데이터 입력"
bash ./02_generate_binlog.sh

echo "[2] DELETE 사고 상황 시뮬레이션"
mysql -u$MYSQL_USER -p$MYSQL_PWD < 03_accidental_delete.sql 

echo "[3] binlog 추출 + DELETE 필터링"
bash ./04_extract_binlog.sh

echo "[4] 필터링된 binlog 적용"
bash ./05_apply_binlog.sh

echo "[5] 복구 후 데이터 확인"
mysql -u$MYSQL_USER -p$MYSQL_PWD < 06_verify_recovery.sql

echo "[6] 사용 리소스 삭제"
mysql -u$MYSQL_USER -p$MYSQL_PWD < 07_cleanup.sql

