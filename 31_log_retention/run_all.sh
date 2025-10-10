
#!/usr/bin/env bash
set -euo pipefail

MYSQL="mysql -u root -pP@ssw0rd"

echo "[1단계] 스키마/테이블/유틸 생성"
$MYSQL < 01_create_log_tables.sql

echo "[2단계] 대량 로그 적재"
$MYSQL < 02_insert_logs.sql

echo "[3단계] 프루닝 효과/실행계획 비교"
$MYSQL < 03_run_queries.sql

echo "[4단계] 보존 정책 자동화 이벤트 생성"
$MYSQL < 04_create_retention_event.sql

echo "[5단계] 아카이브 예시(비파티션 테이블 기준)"
$MYSQL < 05_archive_old_logs.sql

echo "[6단계] 하우스키핑 점검 쿼리"
$MYSQL < 06_housekeeping_checks.sql

echo "[7단계] 정리"
$MYSQL < 07_cleanup.sql
