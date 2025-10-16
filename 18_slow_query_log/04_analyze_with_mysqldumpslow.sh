#!/bin/bash
# 로그파일의 경로를 적절하게 수정한다.
LOG_FILE="/var/log/mysql/mysql-slow.log"

echo "[mysqldumpslow 분석]"
# 쿼리 실행 빈도(count) 기준 정렬로 상위 10개
mysqldumpslow -s c -t 10 $LOG_FILE

# 쿼리 실행 시간(query time) 기준 정렬로 상위 10개
# mysqldumpslow -s t -t 10 $LOG_FILE

