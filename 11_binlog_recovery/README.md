# 11장) 실수로 데이터를 지웠다 – 백업과 binlog를 활용한 복원 전략

## 📌 실습 목적
- MySQL에서 binary log를 활성화하는 방법 학습
- 풀백업과 binlog를 활용하여 point-in-time recovery(PITR) 실습
- 실수로 데이터 삭제 후 복구하는 단계별 절차 이해


---


## 📂 구성 파일

| 파일명 | 설명 |
|--------|------|
| 01_create_table_insert_data.sql | 복구 대상 테이블 생성 및 데이터 입력 |
| 02_generate_binlog.sh | binlog 생성 쿼리 실행 |
| 03_accidental_delete.sql | DELETE 사고 시뮬레이션 |
| 04_extract_binlog.sh | binlog 추출 + DELETE/UPDATE 필터링 |
| 05_apply_binlog.sh | 필터링된 binlog 적용 |
| 06_verify_recovery.sql | 삭제 전/후/복구 후 데이터 비교 |
| 07_cleanup.sql | 사용 리소스 삭제 |
| run_all.sh | 전체 실행 스크립트 |
| enable_binlog.txt | 환경설정값 변경 |



---


# 🛠️ 실행 방법

1. 테스트 환경에서 디렉토리로 이동:
   ```bash
   cd 111_binlog_recovery
   chmod +x analyze_with_ptqd.sh run_all.sh

