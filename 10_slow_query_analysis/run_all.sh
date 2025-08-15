#!/bin/bash
MYSQL_CMD="mysql -uroot -pP@ssw0rd"

echo "[1] slow query log 활성화"
$MYSQL_CMD < 01_enable_slow_query.sql

echo "[2-1] 느린 쿼리 발생"
$MYSQL_CMD < 02_generate_slow_queries.sql

echo "[2-2] 느린 쿼리 발생"
$MYSQL_CMD < 02_generate_slow_queries2.sql

echo "[3] pt-query-digest 분석"
bash analyze_with_ptqd.sh

echo "[4] 정리"
$MYSQL_CMD < 03_cleanup.sql
