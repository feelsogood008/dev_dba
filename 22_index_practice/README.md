# 22장) 인덱스를 너무 많이 만든다 OR 안 만든다

## 📌 실습 목적
- 과도한 인덱스가 INSERT/UPDATE 성능을 저하시키는 것을 확인한다.
- 적절한 인덱스 설계 시 SELECT와 DML 성능 균형이 맞춰지는 것을 체험한다.
- Performance Schema와 SHOW STATUS 등을 통해 DB 부하를 측정한다.



---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_create_table_insert_data.sql | 테이블 생성과 데이터 입력 |
| 02_bad_index_design.sql | 잘못된 인덱스 설계 |
| 03_good_index_design.sql | 좋은 인덱스 설계 |
| 04_load_test.sql | 부하 테스트 |
| 05_monitoring_queries.sql | 모리터링 쿼리 |
| README.md | 실습 가이드 문서 |



