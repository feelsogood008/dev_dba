# 13장) 배포 후 오류 발생 – DDL 변경을 안전하게 적용하는 법


## 📌 실습 목적
운영 환경에서 무심코 실행한 DDL이 서비스 중단으로 이어질 수 있는 이유를 이해하고,  
MySQL의 Online DDL을 활용하여 서비스 중단 없이 스키마를 변경하는 방법을 실습합니다.


---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_create_tables_insert_date.sql | 테이블 생성 및 데이터 입력 |
| 02_blocking_query.sql | 일반적인 컬럼 변경 |
| 03_online_ddl_example.sql | 온라인 컬럼 변경 |
| 04_cleanup.sql | 락 상태 확인 |


---


## ▶ 실행 방법
```bash
chmod +x run_all.sh
./run_all.sh
