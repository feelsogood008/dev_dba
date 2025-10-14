#!/bin/bash
# 로그파일의 경로를 적절하게 수정한다.
LOG_FILE="/var/log/mysql/slow.log"

echo "[mysqldumpslow 분석]"
mysqldumpslow -s c -t 10 $LOG_FILE
