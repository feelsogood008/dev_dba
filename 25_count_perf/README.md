# 25장) COUNT(*)가 느려지는 원인 모름


## 📌 실습 목적
- COUNT(*)가 InnoDB에서 느려지는 이유를 실습으로 확인
- 인덱스 유무, 조건 여부에 따른 성능 차이를 수치로 측정
- 근사치 활용 가능성 확인


---


## 📂 구성 파일
| 파일명 | 설명 |
|--------|------|
| 01_create_table_insert_data.sql | orders 테이블 생성 및 데이터 삽입 |
| 02_count_test.sql | COUNT 성능 비교 쿼리 |
| run_benchmark.sh | 자동 실행 및 로그 저장 |



---


## 🛠️ 실행 방법
```bash
chmod +x run_benchmark.sh
./run_benchmark.sh



