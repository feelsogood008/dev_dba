#!/bin/bash
# 전체 실습 SQL을 순차적으로 실행하는 쉘 스크립트

echo "[1단계] 테이블 생성 및 데이터 입력"
mysql -u root -p < 01_init_and_data.sql

echo "[2단계] 인덱스 없이 느린 쿼리 실행"
mysql -u root -p demo_db < 02_run_slow_query.sql

echo "[3단계] 인덱스 생성"
mysql -u root -p demo_db < 03_create_index.sql

echo "[4단계] 인덱스 적용 후 빠른 쿼리 실행"
mysql -u root -p demo_db < 04_run_fast_query.sql

echo "[5단계] 정리"
mysql -u root -p demo_db < 05_cleanup.sql