#!/bin/bash
MYSQL_CMD="mysql -uroot -pP@ssw0rd"

echo "[1단계] 테이블 생성과 데이터 입력"
$MYSQL_CMD < 01_create_table_insert_data.sql

echo "[2단계] GROUP BY / COUNT 로 중복 탐지"
$MYSQL_CMD < 02_find_duplicates.sql

echo "[3단계] ROW_NUMBER() 활용하여 중복 제거"
$MYSQL_CMD < 03_fix_duplicates.sql

echo "[4단계] UNIQUE 제약 조건 추가"
$MYSQL_CMD < 04_add_constraints.sql

echo "[5단계] 정리"
$MYSQL_CMD < 05_cleanup.sql
