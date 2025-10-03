#!/bin/bash
# 전체 실습 SQL을 순차적으로 실행하는 쉘 스크립트

MYSQL_CMD="mysql -u root -pP@ssw0rd"

echo "[1단계] 테스트 테이블 생성 및 초기 데이터 삽입"
MYSQL_CMD < 01_create_test_table.sql

echo "[2단계] 현재 auto_increment 값 확인"
MYSQL_CMD < 02_check_auto_increment.sql

echo "[3단계] truncate 이후 상태 확인"
MYSQL_CMD < 03_truncate_table.sql
MYSQL_CMD < 04_insert_after_truncate.sql

echo "[4단계] delete 이후 상태 확인"
MYSQL_CMD < 05_delete_and_insert.sql

echo "[5단계] 전체 정리"
MYSQL_CMD < 06_cleanup.sql
