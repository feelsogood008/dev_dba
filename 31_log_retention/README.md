# 31장) 로그성 테이블을 정리하지 않는다



## 📌 실습 목적
- 로그성 데이터의 "무한 누적"이 왜 성능/운영을 망치는지 체감한다.
- 비파티션 vs 월별 파티션의 실행계획과 I/O 차이를 비교한다.
- 보존 정책(드롭 파티션)과 아카이브를 자동화하는 패턴을 익힌다.



---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_create_log_tables.sql | 비파티션/월파티션 테이블 생성 |
| 02_insert_logs.sql | 30여만 건 로그를 비파티션/파티션 테이블에 각각 적재 |
| 03_run_queries.sql | 최근 N일 조회/집계 쿼리, EXPLAIN PARTITIONS 비교 |
| 04_create_retention_event.sql | 이벤트 스케줄러로 월 파티션 자동 정리/미리 생성 |
| 05_archive_old_logs.sql | 오래된 로그를 별도 아카이브 테이블로 이동(예시) |
| 06_housekeeping_checks.sql | 용량/파티션/인덱스/이벤트 상태 점검 |
| 07_cleanup.sql | 리소스 정리 |
| run_all.sh | 순차 실행 스크립트 |



---


## 🛠️ 실행 방법
```bash
chmod +x run_all.sh
./run_all.sh


