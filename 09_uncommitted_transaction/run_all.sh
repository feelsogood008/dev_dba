#!/bin/bash
# run_all.sh - 전체 실습 진행 스크립트


MYSQL_CMD="mysql -u root -pP@ssw0rd"

echo "[1단계] 테스트 DB & 테이블 생성"
$MYSQL_CMD < 01_create_table.sql

echo
echo "[2단계] 트랜잭션(커밋하지 않음) 실행 - 백그라운드에서 실행"
# 백그라운드에서 실행: 이 클라이언트는 내부에서 SLEEP(300)을 실행하므로 트랜잭션이 열려 있는 상태 유지
nohup stdbuf -oL $MYSQL_CMD < 02_open_transaction.sql > txn_open.log 2>&1 &
TXN_CLIENT_PID=$!
echo "백그라운드 mysql client PID: ${TXN_CLIENT_PID}"
echo "로그: txn_open.log"
sleep 2

echo
echo "[3단계] 다른 세션에서 데이터 확인 (변경이 보이지 않아야 함)"
$MYSQL_CMD < 03_select_in_other_session.sql

echo
echo "[4단계] 현재 미커밋 트랜잭션 탐지"
$MYSQL_CMD < 04_detect_uncommitted.sql

echo
echo "===== 다음 단계 안내 ====="
echo "위에서 미커밋 트랜잭션이 보였다면, 이제 두 가지 중 하나를 선택한다"
echo "  A) 트랜잭션을 강제 종료(ROLLBACK)하려면 cleanup_kill.sh 를 실행"
echo "     -> ./cleanup_kill.sh  (비밀번호 입력 필요)"
echo "  B) 트랜잭션이 끝나기를 기다리거나, 백그라운드 클라이언트를 수동으로 확인/종료"
echo
echo "실습을 마치고 DB를 삭제하려면 05_cleanup.sql을 실행한다."
echo "mysql -u root -p < 05_cleanup.sql"

echo
echo "run_all.sh 종료"
