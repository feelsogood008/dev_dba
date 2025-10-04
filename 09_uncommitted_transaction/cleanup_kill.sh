#!/bin/bash
# cleanup_kill.sh
# information_schema.innodb_trx에서 trx_mysql_thread_id를 조회해 KILL로 트랜잭션 강제 종료

MYSQL_USER="root"
# 보안: 환경에 따라 비밀번호 자동화하면 안 됨.
# MYSQL_PWD 환경변수 사용시 주의
MYSQL_OPTS="-u${MYSQL_USER} -pP@ssw0rd"

echo "[INFO] 열린 트랜잭션의 쓰레드 ID를 조회합니다..."
THREADS=$(mysql ${MYSQL_OPTS} -N -e "SELECT trx_mysql_thread_id FROM information_schema.innodb_trx WHERE trx_mysql_thread_id IS NOT NULL;")

if [ -z "$THREADS" ]; then
  echo "[INFO] 현재 종료할 트랜잭션이 없습니다."
else
  echo "[INFO] 종료 대상 thread ids:"
  echo "$THREADS"
  for t in $THREADS; do
    echo "[KILL] KILL ${t}"
    mysql ${MYSQL_OPTS} -e "KILL ${t};"
  done
fi

echo "[INFO] 트랜잭션 종료 후 DB 정리 가능(수동)."
