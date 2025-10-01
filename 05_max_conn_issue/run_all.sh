#!/bin/bash
# 전체 실습 SQL을 순차적으로 실행하는 쉘 스크립트

MYSQL_CMD="mysql -u root -pP@ssw0rd"

echo "[1단계] 초기화 및 설정 확인"
$MYSQL_CMD < 01_init_and_config.sql

echo "[2단계] max_connections 초과 재현 (Python)"
python3 02_open_many_connections.py

echo "[3단계] max_connections 상향 조정"
$MYSQL_CMD < 03_adjust_max_connections.sql

echo "[4단계] 커넥션 풀 사용 테스트"
python3 04_use_connection_pool.py

echo "[5단계] 정리"
$MYSQL_CMD < 05_cleanup.sql
