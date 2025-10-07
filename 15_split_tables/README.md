# 15장) 하나의 테이블에 모든 기능이 몰린 경우 – 테이블 분리 기준


## 📌 실습 목적
- “God Table” 문제점을 이해한다.
- 단일 테이블을 도메인별 테이블로 분리하는 기준을 학습한다.
- 분리 전후 쿼리 차이를 비교한다.
- 하나의 테이블에서 서로 다른 조회 패턴을 처리할 때 인덱스가 난잡해지는 문제를 확인한다.
- 컬럼 업데이트 시 테이블 전체 인덱스 갱신으로 인한 잠금 경합 문제를 실습한다.


---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_create_table_insert_data1.sql | 테이블 생성 및 데이터 입력 |
| 02_split_schema.sql | 주문/결제/배송 테이블로 분리 |
| 03_example_queries.sql | 테이블 분리 전후 쿼리 비교 |
| 04_create_table_insert_data2.sql | 모든 기능을 한 테이블에 몰아넣은 경우 |
| 05_index_conflict_example.sql | 인덱스 난잡 예시 |
| 06_lock_contention_example.sql | 잠금 경합 예시 |
| 07_cleanup.sql | 리소스 정리 |



---


