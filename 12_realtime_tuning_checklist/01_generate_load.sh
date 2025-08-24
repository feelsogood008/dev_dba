#!/bin/bash
# sysbench를 이용해 DB 부하 테스트
sysbench \
  --db-driver=mysql \
  --mysql-user=root \
  --mysql-password=P@ssw0rd \
  --mysql-db=demo_db \
  --table-size=1000000 \
  --threads=50 \
  --time=60 \
  oltp_read_write run
