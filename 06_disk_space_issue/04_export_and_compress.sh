#!/bin/bash
# logs_archive 테이블 덤프 후 압축 저장

echo "[📦] logs_archive 테이블 덤프 중..."
mysqldump -u root -p demo_db logs_archive > logs_archive.sql

echo "[📦] gzip 압축 중..."
gzip logs_archive.sql
