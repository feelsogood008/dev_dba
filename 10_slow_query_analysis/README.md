# 10장) 서비스가 죽었는데 원인을 모를 때 – slow query 로그 분석

## 📌 실습 목적
이 장에서는 MySQL의 Slow Query Log를 활성화하고, `pt-query-digest`를 사용하여 느린 쿼리를 분석하는 방법을 배웁니다.  
실제 운영 환경에서 서비스 장애나 성능 저하의 원인을 빠르게 파악할 수 있도록 돕는 것이 목표입니다.

---

## 📂 구성 파일

| 파일명 | 설명 |
|--------|------|
| 01_enable_slow_log.sql | slow query log 설정 |
| 02_generate_slow_queries.sql | 테스트용 느린 쿼리 생성 |
| 03_cleanup.sql | 리소스 정리,slow query log 비활성화 |
| analyze_with_ptqd.sh | pt-query-digest로 분석 |
| run_all.sh | 전체 실행 스크립트 |


---


## 🛠️ 실행 방법

1. 테스트 환경에서 디렉토리로 이동:
   ```bash
   cd 10_slow_query_analysis
   chmod +x analyze_with_ptqd.sh run_all.sh


2. 



