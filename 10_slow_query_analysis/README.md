# 10장) 서비스가 죽었는데 원인을 모를 때 – slow query 로그 분석

## 📌 실습 목적
이 장에서는 MySQL의 Slow Query Log를 활성화하고, `pt-query-digest`를 사용하여 느린 쿼리를 분석하는 방법을 배운다.  
실제 운영 환경에서 서비스 장애나 성능 저하의 원인을 빠르게 파악할 수 있도록 돕는 것이 목표이다.

---

## 📂 구성 파일

| 파일명 | 설명 |
|--------|------|
| 01_enable_slow_log.sql | slow query log 설정 |
| 02_generate_slow_queries.sql | 테스트용 느린 쿼리 생성 |
| 02_generate_slow_queries2.sql | 테스트용 느린 쿼리 생성 |
| 03_cleanup.sql | 리소스 정리,slow query log 비활성화 |
| analyze_with_ptqd.sh | pt-query-digest로 분석 |
| run_all.sh | 전체 실행 스크립트 |


---


## 🛠️ 실행 방법

- 만일 -bash: ./run_all.sh: /bin/bash^M: bad interpreter: No such file or directory 에러가 발생한다면
- dos2unix 설치 후 줄바꿈을 LF 로 변환
  
```bash

1. 스크립트 파일 실행
 chmod +x analyze_with_ptqd.sh run_all.sh
 ./run_all.sh

## ⚙️ Ubuntu에서 pt-query-digest 설치 방법

`pt-query-digest`는 Percona Toolkit에 포함되어 있다. Ubuntu에서는 아래 절차로 설치할 수 있으며
mysql 버전이나 설치 옵션에 따라서는 이미 설치가 되어 있을 수 있으니 터미널에서 
pt-query-digest --version 명령을 먼저 실행해서 확인하면 된다.

1. 패키지 업데이트
sudo apt update

2. Percona Toolkit 설치
sudo apt install percona-toolkit -y

3. 설치 확인
pt-query-digest --version

