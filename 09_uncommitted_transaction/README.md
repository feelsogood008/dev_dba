# 09_uncommitted_transaction - 트랜잭션 미커밋 상황 실습


# ✅ 실습 목적

- 트랜잭션을 시작하고 COMMIT 하지 않은 상태에서 다른 세션의 데이터 조회 결과가 달라지는 현상을 재현한다.
- information_schema를 활용해 미커밋(또는 장시간 열린) 트랜잭션을 탐지하는 방법을 익힌다.
- 필요시 미커밋 트랜잭션을 강제 종료(KILL)하여 롤백시키는 절차를 실습한다.


---


# 📁 구성 파일

- `01_create_table.sql` : 테스트 DB/테이블 생성 및 초기 데이터 삽입
- `02_open_transaction.sql` : START TRANSACTION; UPDATE ...; SELECT SLEEP(300); (COMMIT 없음)
- `03_select_in_other_session.sql` : 다른 세션에서 데이터 조회
- `04_detect_uncommitted.sql` : information_schema 를 이용한 미커밋 트랜잭션 탐지 쿼리
- `05_cleanup.sql` : 실습 환경 정리 (DB drop)
- `cleanup_kill.sh` : 열린 트랜잭션을 찾아 KILL 명령으로 종료(롤백)하는 쉘 스크립트
- `run_all.sh` : 전체 실습 자동 실행 스크립트


---

# 🛠️ 실행 방법

1. 테스트 환경에서 디렉토리로 이동:
   ```bash
   cd 09_uncommitted_transaction
   chmod +x cleanup_kill.sh run_all.sh

