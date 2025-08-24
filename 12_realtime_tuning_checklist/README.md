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




---


## 🛠️ 실행 방법

1. 테스트 환경에서 디렉토리로 이동:

   ```bash
   cd 12_realtime_tuning_checklist
   cd 12_realtime_tuning_checklist
chmod +x 00_prepare_sysbench.sh 01_generate_load.sh check_slow_queries.sh run_all.sh







