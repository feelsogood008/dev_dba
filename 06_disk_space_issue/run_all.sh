#!/bin/bash
# 전체 실습 SQL을 순차적으로 실행하는 쉘 스크립트

MYSQL_CMD="mysql -u root -pP@ssw0rd"

echo "[1단계] logs 테이블 및 archive 테이블 생성"
$MYSQL_CMD < 01_insert_massive_data.sql

echo "[2단계] 디스크 사용량 확인"
bash 02_check_disk_usage.sh

echo "[3단계] 오래된 데이터 archive 테이블로 이동"
$MYSQL_CMD < 03_archive_old_data.sql

echo "[4단계] logs_archive 테이블 덤프 후 압축 저장"
bash 04_export_and_compress.sh

echo "[5단계] 오래된 바이너리 로그 삭제"
$MYSQL_CMD < 05_purge_binlogs.sql

echo "[6단계] 정리 (테이블 및 자원 제거)"
$MYSQL_CMD < 06_cleanup.sql
