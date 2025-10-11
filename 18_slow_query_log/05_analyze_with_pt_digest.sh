#!/bin/bash
LOG_FILE="/var/log/mysql/slow.log"

echo "[pt-query-digest 분석]"
pt-query-digest $LOG_FILE > slow_digest_report.txt
echo "보고서: slow_digest_report.txt"
