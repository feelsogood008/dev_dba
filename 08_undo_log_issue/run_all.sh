#!/bin/bash

echo "[모니터링] 현재 undo 로그 상태 확인 (반복 모니터링)"
echo "별도 콘솔창에서 check_undo_log_loop.sh 를 실행하세요"

echo "[환경설정값 변경] undo 설정값 조정"
echo " 파일 참고"

echo "[1단계] 초기화 및 설정 확인"
mysql -u root -p < 01_create_table.sql

echo "[2단계] 테이블에 대용량 데이터 삽입 (Python 스크립트)"
python3 02_insert_bulk_data.py

echo "[3단계] 대량 삭제 쿼리 실행"
python3 03_delete_many_rows.py

echo "[4단계] 환경 정리"
mysql -u root -p < 04_cleanup.sql
