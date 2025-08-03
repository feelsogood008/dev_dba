#!/bin/bash

echo "[undo 로그 상태를 1초 간격으로 30회 확인합니다.]"

for i in {1..30}
do
  echo "[$i 회차]"
  mysql -u root -pP@ssw0rd -e "
    SELECT NAME, STATE, TRX_ID, UNDO_NO 
    FROM information_schema.innodb_trx 
    WHERE TRX_STARTED IS NOT NULL;
  "
  sleep 1
done
