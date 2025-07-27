# 5장) 연결 수 초과 오류 – max_connections 조정과 커넥션 풀 점검

## ✅ 실습 목적

- MySQL에서 `max_connections` 제한이 어떻게 동작하는지 실습을 통해 이해한다.
- 과도한 동시 접속 시 발생하는 오류 상황을 Python 스크립트로 재현한다.
- `max_connections` 값을 동적으로 조정해보고, 커넥션 풀(Pooling) 기법을 적용하여 접속 효율을 개선한다.
- 단순한 연결 시도와 커넥션 풀 방식의 차이를 실습을 통해 직접 확인한다.

---

## 📂 구성 파일

| 파일명 | 설명 |
|--------|------|
| `01_init_and_config.sql` | 실습용 DB 생성 및 `max_connections` 설정 확인 |
| `02_open_many_connections.py` | 다수의 연결을 동시에 시도하여 연결 수 초과 오류 재현 |
| `03_adjust_max_connections.sql` | `max_connections` 값을 임시로 증가 |
| `04_use_connection_pool.py` | 커넥션 풀을 이용한 효율적 연결 방식 실습 |
| `05_cleanup.sql` | 실습 후 계정 및 DB 정리 |
| `check_connections.py` | 현재 DB 커넥션 개수 확인 |
| `run_all.sh` | 전체 실습 과정을 순차 실행하는 스크립트 |

---

## 🛠️ 실행 방법

## 실행 방법
- 만일 -bash: ./run_all.sh: /bin/bash^M: bad interpreter: No such file or directory 에러가 발생한다면
- dos2unix 설치 후 줄바꿈을 LF 로 변환
  
```bash
sudo apt-get install dos2unix
dos2unix run_all.sh

1. Python 모듈 설치  
sudo apt install python3-pip
pip install mysql-connector-python

2. 별도 터미널에서 수행
python3 check_connections.py

3. run_all.sh 실행
chmod +x run_all.sh
./run_all.sh

