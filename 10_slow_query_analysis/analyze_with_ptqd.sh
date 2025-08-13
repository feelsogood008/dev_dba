#!/bin/bash
SLOW_LOG="/var/lib/mysql/mysql-slow.log"

if ! command -v pt-query-digest &> /dev/null; then
    echo "pt-query-digest가 설치되어 있지 않습니다."
    echo "설치 방법: sudo apt install percona-toolkit"
    exit 1
fi

echo "[info-1] Slow query 로그 분석 시작..."
pt-query-digest $SLOW_LOG > slow_report.txt
echo "[info-2] 분석 완료: slow_report.txt 확인"
