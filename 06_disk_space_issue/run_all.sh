#!/bin/bash
# 전체 실습 SQL을 순차적으로 실행하는 쉘 스크립트


echo "[1단계] logs 테이블 및 archive 테이블 생성"
mysql -u root -p demo_db < 01_create_logs_tables.sql

echo "[2단계] 더미 데이터 대량 삽입"
mysql -u root -p demo_db < 02_insert_massive_data.sql

echo "[3단계] 디스크 사용량 확인"
bash 03_check_disk_usage.sh

echo "[4단계] 오래된 데이터 archive 테이블로 이동"
mysql -u root -p demo_db < 04_archive_old_data.sql

echo "[5단계] archive 테이블 덤프 후 압축"
bash 05_export_and_compress.sh

echo "[6단계] 오래된 바이너리 로그 삭제"
mysql -u root -p demo_db < 06_purge_binlogs.sql

echo "[7단계] 정리 (테이블 및 자원 제거)"
mysql -u root -p demo_db < 07_cleanup.sql
