# 12장) 실수로 데이터를 지웠다 – 백업과 binlog를 활용한 복원 전략

## 📌 실습 목적
- sysbench를 이용해 MySQL에 대량 부하를 발생시킨다.
- 실시간으로 실행 중인 쿼리, 락 상태, InnoDB 엔진 상태, slow query 로그를 확인한다.
- 응급 인덱스 생성 및 오래 걸리는 쿼리 종료 방법을 실습한다.


---


## 📂 구성 파일

| 파일명 | 설명 |
|--------|------|
| 00_prepare_sysbench.sh | sysbench 설치 및 테스트 데이터 준비 |
| 01_generate_load.sh | 대량 부하 발생 (sysbench) |
| 02_show_processlist.sql | 현재 실행 쿼리 확인 |
| 03_check_locks.sql | 락 상태 확인 |
| 04_check_innodb_status.sql | InnoDB 상태 확인 |
| check_slow_queries.sh | slow query 로그 실시간 확인 |
| enable_emergency_index.sql | 긴급 인덱스 생성 예시 |
| kill_long_running_queries.sql | 오래 걸리는 쿼리 종료 |
| cpu_check.sh | DB서버 cpu(%) 확인 |
| cleanup.sh | 사용 리소스 정리 |



---


## 🛠️ 실행 방법

1. 테스트 환경에서 디렉토리로 이동:

```bash
cd 12_realtime_tuning_checklist
chmod +x 00_prepare_sysbench.sh 01_generate_load.sh check_slow_queries.sh run_all.sh









