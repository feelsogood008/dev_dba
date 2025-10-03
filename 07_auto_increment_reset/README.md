# 07_auto_increment_reset

## 📌 실습 목적
테이블의 auto_increment 값이 예상치 못하게 초기화되는 원인을 재현하고 이해하는 것이 목적입니다.  
특히 `TRUNCATE`, `DELETE` 사용 시 auto_increment가 어떻게 동작하는지를 실습을 통해 확인할 수 있습니다.


---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_create_test_table.sql | 테이블 생성 및 초기 데이터 삽입 |
| 02_check_auto_increment.sql | 현재 auto_increment 상태 확인 |
| 03_truncate_table.sql | truncate 명령 실행 |
| 04_insert_after_truncate.sql | truncate 이후 데이터 삽입 |
| 05_delete_and_insert.sql | delete 이후 삽입 시 auto_increment 확인 |
| 06_cleanup.sql | 전체 정리 스크립트 |
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

