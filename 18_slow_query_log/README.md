# 18장) 슬로우쿼리 로그 설정과 활용법


## 📌 실습 목적
- MySQL 슬로우쿼리 로그 설정 및 활성화 방법 학습
- 다양한 형태의 느린 쿼리 생성
- mysqldumpslow / pt-query-digest 를 활용한 로그 분석 방법 익히기


---


## 📂 구성 파일
| 파일명  | 설명 |
|--------|------|
| 01_enable_slow_log.sql | 슬로우쿼리 로그 활성화 |
| 02_generate_slow_queries.sql | 느린 쿼리 10개 실행 |
| 03_analyze_with_mysqldumpslow.sh | mysqldumpslow 분석 |
| 04_analyze_with_pt_digest.sh | pt-query-digest 분석 |
| 05_cleanup.sql | 전체 실행 스크립트 |
| run_all.sh | 전체 실행 스크립트 |


---


## 🛠️ 실행 방법

```bash
./run_all.sh
