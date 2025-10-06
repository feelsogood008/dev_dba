# 14장) 중복 데이터가 생겼다 – 제약 조건 점검과 보정 쿼리


## 📌 실습 목적
- 중복 데이터 발생 원인을 이해한다.
- GROUP BY + HAVING 을 활용해 중복 레코드를 탐지한다.
- ROW_NUMBER() + DELETE 로 안전하게 중복 레코드를 제거한다.
- 제약 조건(UNIQUE)을 적용해 재발을 방지한다.


---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_create_table_insert_data.sql | 테이블 생성 및 데이터 입력 |
| 02_find_duplicates.sql | GROUP BY / COUNT 로 중복 탐지 |
| 03_fix_duplicates.sql | ROW_NUMBER() 활용하여 중복 제거 |
| 04_add_constraints.sql | UNIQUE 제약 조건 추가 |
| 05_cleanup.sql | 리소스 정리 |



---

## 🛠️ 실행 방법

- 만일 -bash: ./run_all.sh: /bin/bash^M: bad interpreter: No such file or directory 에러가 발생한다면
- dos2unix 설치 후 줄바꿈을 LF 로 변환
  
```bash

1. 스크립트 파일 실행
 chmod +x run_all.sh
 ./run_all.sh

