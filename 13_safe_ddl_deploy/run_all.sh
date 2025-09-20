#!/bin/bash
MYSQL_CMD="mysql -u root -pP@ssword"

echo "[1단계] 테스트 테이블 생성"
$MYSQL_CMD < 01_create_tables_insert_date.sql

echo "[2단계] DDL 락 대기 상황 재현"
echo "세션1에서 긴 SELECT ... FOR UPDATE 실행 후 세션2에서 ALTER TABLE 실행 (02_blocking_query.sql)"

echo "[3단계] 온라인 DDL 예시 실행"
$MYSQL_CMD < 03_online_ddl_example.sql

echo "[4단계] 정리"
$MYSQL_CMD < 04_cleanup.sql

