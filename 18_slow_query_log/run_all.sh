
#!/bin/bash
MYSQL_CMD="mysql -u root -pP@ssw0rd"


echo "[1단계] 슬로우쿼리 로그 활성화"
$MYSQL_CMD < 01_enable_slow_log.sql

echo "[2단계] 테이블 생성과 데이터 입력"
$MYSQL_CMD < 02_create_tables_insert_data.sql

echo "[3단계] 다양한 형태의 느린 쿼리 실행"
$MYSQL_CMD < 03_generate_slow_queries.sql

echo "[4단계] mysqldumpslow 분석"
bash ./04_analyze_with_mysqldumpslow.sh

echo "[5단계] pt-query-digest 분석"
bash ./05_analyze_with_pt_digest.sh

echo "[6단계] 리소스 정리"
$MYSQL_CMD < 06_cleanup.sql

