
#!/bin/bash
MYSQL_USER="root"
MYSQL_PWD="P@ssw0rd"


echo "[1] 슬로우쿼리 로그 활성화"
mysql -u$MYSQL_USER -p$MYSQL_PWD < 01_enable_slow_log.sql

echo "[2] 느린 쿼리 실행"
mysql -u$MYSQL_USER -p$MYSQL_PWD < 02_generate_slow_queries.sql

echo "[3] mysqldumpslow 분석"
./03_analyze_with_mysqldumpslow.sh

echo "[4] pt-query-digest 분석"
./04_analyze_with_pt_digest.sh
