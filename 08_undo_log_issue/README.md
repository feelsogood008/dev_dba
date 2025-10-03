# 8장) DELETE가 끝나지 않는다 – InnoDB와 undo log 이해


## 📌 실습 목적

InnoDB 환경에서 `DELETE` 문이 비정상적으로 오래 걸리는 현상을 재현한다.  
undo log가 비정상적으로 누적될 경우, 트랜잭션 지연 및 디스크 공간 이슈가 발생할 수 있음을 체험한다.  
undo 관련 설정(innodb_max_undo_log_size, innodb_undo_log_truncate 등)의 영향을 실습을 통해 이해한다.


---


## 📁 구성 파일

| 파일명 | 설명 |
|--------|------|
| 01_create_table.sql | 테스트 테이블 생성, undo 상태 확인 |
| 02_insert_bulk_data.py | 1000만 건의 더미 데이터 입력 |
| 03_delete_many_rows.py | 대량 데이터 삭제 |
| 04_cleanup.sql | 리소스 정리 테이블 |
| check_undo_log_loop.sh | n초마다 undo 로그 상태 확인 쉘 스크립트 |
| run_all.sh | 전체 실행 스크립트 |


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


2. check_undo_log_loop.sh 실행
chmod +x check_undo_log_loop.sh
./check_undo_log_loop.sh
