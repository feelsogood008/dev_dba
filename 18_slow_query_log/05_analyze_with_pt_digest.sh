#!/bin/bash
# 로그파일의 경로를 적절하게 수정한다.
LOG_FILE="/var/log/mysql/slow.log"

echo "[pt-query-digest 분석]"
pt-query-digest $LOG_FILE > slow_digest_report.txt
echo "보고서: slow_digest_report.txt"
