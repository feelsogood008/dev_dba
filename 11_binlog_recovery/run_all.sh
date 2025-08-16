#!/bin/bash
MYSQL_USER="root"
MYSQL_PWD="P@ssw0rd"

echo "=== [1] 테이블 생성 ==="
mysql -u$MYSQL_USER -p$MYSQL_PWD < 01_create_test_table.sql

echo "=== [2] 초기 데이터 입력 ==="
mysql -u$MYSQL_USER -p$MYSQL_PWD < 02_insert_test_data.sql

echo "=== [3] binlog 생성용 데이터 변경 ==="
./04_generate_binlog.sh

echo "=== [4] 사고 상황 (DELETE 실행) ==="
mysql -u$MYSQL_USER -p$MYSQL_PWD < 05_accidental_delete.sql

echo "=== [5] binlog 파일 확인 ==="
mysql -u$MYSQL_USER -p$MYSQL_PWD -e "SHOW BINARY LOGS;"

echo "=== [6] binlog 추출 및 필터링 ==="
# 예시: binlog 파일 이름과 시간은 실습 상황에 맞게 수정
./06_extract_binlog.sh mysql-bin.000001 "2025-08-14 00:00:00" "2025-08-14 23:59:59"

echo "=== [7] 필터링된 binlog 적용 ==="
./07_apply_binlog.sh recovery_test
