#!/bin/bash

echo "[1단계] 테스트 테이블 생성 및 초기 데이터 삽입"
mysql -u root -p < 01_create_test_table.sql

echo "[2단계] 현재 auto_increment 값 확인"
mysql -u root -p < 02_check_auto_increment.sql

echo "[3단계] truncate 이후 상태 확인"
mysql -u root -p < 03_truncate_table.sql
mysql -u root -p < 04_insert_after_truncate.sql

echo "[4단계] delete 이후 상태 확인"
mysql -u root -p < 05_delete_and_insert.sql

echo "[5단계] 전체 정리"
mysql -u root -p < 06_cleanup.sql
