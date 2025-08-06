#!/bin/bash

echo "[1단계] 초기화 및 설정 확인"
mysql -u root -p < 01_init_environment.sql

echo "[2단계] 테이블에 대용량 데이터 삽입 (Python 스크립트)"
python3 02_insert_bulk_data.py

echo "[3단계] 현재 undo 로그 상태 확인 (반복 모니터링)"
echo "이 단계는 루프 실행입니다. Ctrl+C 로 수동 중단하세요."
bash 03_check_undo_log_loop.sh

echo "[4단계] 대량 삭제 쿼리 실행"
mysql -u root -p < 04_delete_many_rows.sql

echo "[5단계] undo 설정값 조정 시도"
mysql -u root -p < 05_adjust_undo_settings.sql

echo "[6단계] 환경 정리"
mysql -u root -p < 06_cleanup.sql
