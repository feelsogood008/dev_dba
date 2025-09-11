#!/bin/bash
LOG_FILE="/var/log/mysql/slow.log"

echo "[mysqldumpslow 분석]"
mysqldumpslow -s c -t 10 $LOG_FILE
