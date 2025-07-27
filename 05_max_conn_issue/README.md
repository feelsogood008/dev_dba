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
| `run_all.sh` | 전체 실습 과정을 순차 실행하는 스크립트 |

---

## 🛠️ 실행 방법

1. Python 모듈 설치  
   ```bash
   sudo apt install python3-pip
   pip install mysql-connector-python
