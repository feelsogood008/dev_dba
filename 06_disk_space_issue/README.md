# 06장 - 디스크 용량이 부족하다: 테이블/로그/덤프 관리

## ✅ 실습 목적
이 실습은 디스크 용량 부족 문제를 시뮬레이션하고, 로그 테이블 관리, 데이터 아카이빙, 덤프 및 압축, 바이너리 로그 삭제까지 전체 디스크 관리 흐름을 실습하는 것을 목표로 한다.  
특히 운영 환경에서 종종 간과되는 오래된 로그 정리와 binlog 정리의 중요성을 강조한다.


## 📂 구성 파일

| 파일명 | 설명 |
|--------|------|
| 01_insert_massive_data.sql | 대량 데이터 삽입 |
| 02_check_disk_usage.sh | 디스크 사용량 확인 |
| 03_archive_old_data.sql | 오래된 로그를 아카이브 테이블로 이동 |
| 04_export_and_compress.sh | 테이블 덤프 후 압축 저장 |
| 05_purge_binlogs.sql | 오래된 바이너리 로그 제거 |
| 06_cleanup.sql | 테이블 삭제 |
| run_all.sh | 전체 실행 스크립트 |


## 🛠️ 실행 방법

- 만일 -bash: ./run_all.sh: /bin/bash^M: bad interpreter: No such file or directory 에러가 발생한다면
- dos2unix 설치 후 줄바꿈을 LF 로 변환
  
```bash
sudo apt-get install dos2unix
dos2unix run_all.sh

1. `run_all.sh` 파일에 실행 권한을 부여합니다.
    
    chmod +x run_all.sh
    
2. 전체 실습 실행:
    
    ./run_all.sh
    
