#!/bin/bash
# 디스크 사용량 확인 스크립트

echo "[🔍] MySQL 데이터 디렉토리 사용량 확인:"
sudo du -sh /var/lib/mysql

echo "[🔍] 현재 디스크 사용 현황:"
df -h
