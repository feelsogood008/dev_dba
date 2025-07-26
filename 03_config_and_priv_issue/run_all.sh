#!/bin/bash
# 3장 실습: 권한 및 설정 누락 문제 재현 자동 실행 스크립트

echo "[1단계] 테스트 DB 및 서비스 계정 생성"
mysql -u root -p < 01_create_test_db_and_user.sql 

echo "[2단계] 테이블, 뷰, 프로시저 생성 (관리자)"
mysql -u root -p demo_db < 02_create_objects_as_admin.sql

echo "[3단계] 현재 계정 권한 확인"
mysql -u root -p < 03_check_user_privileges.sql

echo "[4단계] 서비스 계정으로 접근 테스트, new_payments 테이블 접근 실패"
mysql -u svc_api -p'P@ssw0rd' demo_db < 04_access_test_as_user.sql

echo "[5단계] 권한 보완 및 재확인"
mysql -u root -p < 05_fix_privileges_and_config.sql

echo "[5-1단계] svc_api 서비스 계정으로 다시 접근 테스트"
mysql -u svc_api -p'P@ssw0rd' demo_db < 04_access_test_as_user.sql

echo "[6단계] 정리"
mysql -u root -p < 06_cleanup.sql
