# 19장) 백업 전략 설계: mysqldump vs xtrabackup


## 📌 실습 목적

이 디렉토리에는 `mysqldump`와 `xtrabackup`을 이용한 백업/복구 실습 스크립트가 포함되어 있습니다.


---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_full_backup_mysqldump.sh | 전체 DB 백업 |
| 02_logical_partial_backup.sh | 테이블 단위 선택적 백업 |
| 03_full_backup_xtrabackup.sh | 전체 DB 백업 |
| 04_incremental_backup_xtrabackup.sh | 증분 백업 (하루 1회 전체 + 매시간 증분) |
| 05_verify_restore.sh | 복구 검증 |
| 06_hybrid_backup.sh | 혼합 백업 |
| 07_hybrid_restore.sh | 혼합 파일 복구 |
| 08_hybrid_cron.sh | 혼합 백업 배치와 알림 |



---


## 🛠️ 실행 방법
1. mysqldump 백업  
   ```bash
   cd 19_backup_strategy
   chmod +x *.sh
   ./01_full_backup_mysqldump.sh demo_db



