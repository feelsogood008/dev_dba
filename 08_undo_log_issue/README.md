# 08_undo_log_issue


## ✅ 실습 목적

InnoDB 환경에서 `DELETE` 문이 비정상적으로 오래 걸리는 현상을 재현한다.  
undo log가 비정상적으로 누적될 경우, 트랜잭션 지연 및 디스크 공간 이슈가 발생할 수 있음을 체험한다.  
undo 관련 설정(innodb_undo_log_truncate 등)의 영향을 실습을 통해 이해한다.


---


## 📁 구성 파일

- 01_create_table.sql: 실습용 테이블 생성
- 02_insert_bulk_data.sql: 100만 건 더미 데이터 삽입
- 03_check_undo_log.sql: undo 상태 및 트랜잭션 확인 쿼리
- 04_delete_many_rows.sql: 대량 DELETE 문 실행
- 05_adjust_undo_settings.sql: undo 설정 확인/조정
- 06_cleanup.sql: 실습 환경 정리
- run_all.sh: 전체 실습 실행 스크립트


---


## 🛠️ 실행 방법

- 만일 -bash: ./run_all.sh: /bin/bash^M: bad interpreter: No such file or directory 에러가 발생한다면
- dos2unix 설치 후 줄바꿈을 LF 로 변환
  
```bash

sudo apt-get install dos2unix
dos2unix run_all.sh


1. run_all.sh 실행
chmod +x run_all.sh
./run_all.sh


2. 
