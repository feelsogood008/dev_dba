#!/bin/bash
# 전체 실습 SQL을 순차적으로 실행하는 쉘 스크립트

MYSQL_CMD="mysql -u root -pP@ssw0rd"


echo "[1단계] 테이블 생성 및 데이터 입력"
$MYSQL_CMD < 01_init_and_data.sql

echo "[2단계] 인덱스 없이 느린 쿼리 실행"
$MYSQL_CMD < 02_run_slow_query.sql

echo "[3단계] 인덱스 생성"
$MYSQL_CMD < 03_create_index.sql

echo "[4단계] 인덱스 적용 후 빠른 쿼리 실행"
$MYSQL_CMD < 04_run_fast_query.sql

echo "[5단계] 정리"
$MYSQL_CMD < 05_cleanup.sql
