# 21장) 쿼리 성능은 EXPLAIN을 안 보면 모른다


## 📌 실습 목적

1. **편향 데이터 분포**
   - status='active' (80%) → 인덱스 효율 낮음
   - status='blocked' (5%) → 인덱스 효율 높음
   - → 같은 인덱스라도 값 분포에 따라 실행계획이 달라짐

2. **날짜 조건**
   - 최근 30일 (50%)은 range scan 적합
   - 오래된 데이터는 full scan 가능성 높음

3. **조인 + 필터**
   - 고객 이메일 기반 주문 조회 시 `customers.email` 인덱스 활용
   - 고객 상태(status) 조건은 selectivity에 따라 효율 달라짐

4. **집계**
   - `COUNT`, `GROUP BY` 쿼리는 인덱스보다 풀 스캔 후 해시/임시 테이블을 쓸 가능성이 있음



---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_create_table_insert_data.sql | 테이블 생성과 데이터 입력 |
| 02_queries.sql | EXPLAIN 실습 쿼리 모음 |
| README.md | 실습 가이드 문서 |



---


## 🛠️ 실행 방법

```bash
mysql -u root -p demo_db < 21_queries.sql
