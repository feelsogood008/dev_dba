# 3장) 테이블과 데이터만 보면 안 되는 이유: 설정과 권한의 중요성

## 📌 실습 목적

- 신규 객체 접근 시 권한 부족 오류 발생 재현
- `SHOW GRANTS` 및 `INFORMATION_SCHEMA`를 통한 권한 확인
- 권한 누락 시 서비스 장애 가능성 체험

---

## 📂 구성 파일

| 파일명                            | 설명 |
|---------------------------------|------|
| 01_create_test_db_and_user.sql    | 테스트용 DB 및 계정 생성 |
| 02_create_objects_as_admin.sql   | 테이블, 뷰, 프로시저 생성 |
| 03_check_user_privileges.sql     | 서비스 계정 권한 확인 |
| 04_access_test_as_user.sql       | 권한 부족 상황 재현 |
| 05_fix_privileges_and_config.sql | 권한 보완 후 재확인 |
| 06_cleanup.sql                   | 정리 |
| run_all.sh                       | 실습 전체 자동 실행 스크립트 |

---

## 🛠️ 실행 방법
- 만일 다음과 같은 에러가 발생한다면
- -bash: ./run_all.sh: /bin/bash^M: bad interpreter: No such file or directory 에러가 발생한다면
- dos2unix 설치 후 아래의 명령어를 이용해서 줄바꿈을 LF 로 변환하면 된다.
  
```bash
sudo apt-get install dos2unix
dos2unix run_all.sh

chmod +x run_all.sh
./run_all.sh



