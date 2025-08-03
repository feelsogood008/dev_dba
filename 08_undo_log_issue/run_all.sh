#!/bin/bash

echo "[1단계] 테이블 생성, undo 설정 확인"
mysql -u root -p < 01_create_table.sql

echo "[2단계] 더미 데이터 입력 (100만 건)"
mysql -u root -p < 02_insert_bulk_data.sql

echo "[3단계] undo 설정 조정"

# 사용자 입력 받기
read -p "설정할 innodb_max_undo_log_size 값 (예: 209715200): " UNDO_SIZE

# SQL에 변수 넘기면서 실행
mysql -u root -p -e "SET @undo_log_size=$UNDO_SIZE; SOURCE 03_adjust_undo_settings.sql;"

echo "[4단계] 대량 DELETE 실행"
mysql -u root -p < 04_delete_many_rows.sql

echo "[5단계] 정리"
mysql -u root -p < 05_cleanup.sql
