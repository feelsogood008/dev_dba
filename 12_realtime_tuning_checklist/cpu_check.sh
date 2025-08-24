#!/bin/bash

DURATION=300  # 5분 (초 단위)
INTERVAL=5    # 5초 간격

START_TIME=$(date +%s)
END_TIME=$((START_TIME + DURATION))

while [ $(date +%s) -lt $END_TIME ]; do
  CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/")
  CPU_USAGE=$(awk "BEGIN {print 100 - $CPU_IDLE}")
  echo "$(date '+%Y-%m-%d %H:%M:%S') CPU Usage: $CPU_USAGE%"
  sleep $INTERVAL
done

echo "CPU 모니터링 종료 (5분 경과)"
