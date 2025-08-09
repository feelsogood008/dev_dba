#!/bin/bash

# 1초마다 InnoDB 트랜잭션 정보 및 Undo 상태를 확인
# 중간에 Ctrl+C로 종료 가능

INTERVAL=2
echo "[INFO] Undo 로그 상태를 $INTERVAL 초마다 확인합니다. 중지하려면 Ctrl+C 를 누르세요."

while true
do
    echo "========== $(date '+%Y-%m-%d %H:%M:%S') =========="

    echo "[현재 실행 중인 트랜잭션 (information_schema.innodb_trx)]"
    mysql -u root -pP@ssw0rd -e "
        SELECT trx_id, trx_started, trx_state, trx_query
        FROM information_schema.innodb_trx
        WHERE trx_started IS NOT NULL \G
    "

    echo ""

    echo "[UNDO 파일 크기 (information_schema.innodb_tablespaces)]"
    mysql -u root -pP@ssw0rd -e "
       SELECT NAME, FILE_SIZE, ALLOCATED_SIZE 
       FROM information_schema.innodb_tablespaces 
       WHERE NAME LIKE 'innodb_undo%' \G
    "

    echo ""
        
    echo "[SHOW ENGINE INNODB STATUS 결과 요약]"
    mysql -u root -pP@ssw0rd -e "SHOW ENGINE INNODB STATUS\G" | \
        grep -A 20 "TRANSACTIONS" | grep -E "History list length|Purge done|Trx id counter"

    echo ""
    sleep $INTERVAL
done
