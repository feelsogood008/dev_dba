# 17장) 기본 모니터링 도구 - SHOW,INFORMATION_SCHEMA,PERFORMANCE_SCHEMA

## 📌 실습 목적
- MySQL 내장 모니터링 도구를 직접 사용해본다.
- SHOW, INFORMATION_SCHEMA, performance_schema 각각의 특성을 이해한다.


---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_show_commands.sql | 빠른 현황 체크 |
| 02_information_schema.sql | 메타데이터 분석 |
| 03_performance_schema.sql | 실시간/이벤트 추적 |


---

## 🛠️ 실행 방법

mysql -u root -p demo_db < 01_show_commands.sql \n
mysql -u root -p demo_db < 02_information_schema.sql
mysql -u root -p demo_db < 03_performance_schema.sql
