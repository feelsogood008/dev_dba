# 13장) 배포 후 오류 발생 – DDL 변경을 안전하게 적용하는 법


## 📌 실습 목적
운영 환경에서 무심코 실행한 DDL이 서비스 중단으로 이어질 수 있는 이유를 이해하고,  
MySQL의 Online DDL을 활용하여 서비스 중단 없이 스키마를 변경하는 방법을 실습한다.


---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_create_tables_insert_date.sql | 테이블 생성 및 데이터 입력 |
| 02_dml.sh | 주기적 업데이트 실행 |
| 03_lock_monitor.sh | 주기적 락발생 여부 확인 |
| 04_online_ddl_example.sql | 온라인 DDL 예시 |
| 05_cleanup.sql | 리소스 정리 |
  		 # 테스트 테이블 정리

---


## 🛠️ 실행 방법
```bash
chmod +x 02_dml.sh 03_lock_monitor.sh
./02_dml.sh


