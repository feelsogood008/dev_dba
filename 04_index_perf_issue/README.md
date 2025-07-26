# 4장 쿼리가 갑자기 느려졌다 – 인덱스 재검토


## 실습 목적
인덱스 유무에 따른 쿼리 성능 차이를 실습합니다.
- 테이블: board_posts
- 시나리오: category_id와 created_at을 기준으로 특정 카테고리의 최근 게시글을 조회하는 쿼리를 성능 비교


---

## 구성 파일

| 파일명                          | 설명 |
|---------------------------------|------|
| 01_init_and_data.sql   | 테이블 생성 + 더미 데이터 입력 (board_posts 중심) |
| 02_run_slow_query.sql  | 인덱스 없이 쿼리 실행 |
| 03_create_index.sql    | 인덱스 생성 (category_id, created_at) |
| 04_run_fast_query.sql  | 인덱스 적용 후 동일 쿼리 실행 |
| 05_cleanup.sql         | 테이블 정리 |
| run_all.sh             | 실습 전체 자동 실행 스크립트 |

---


## 실행 방법
- 만일 -bash: ./run_all.sh: /bin/bash^M: bad interpreter: No such file or directory 에러가 발생한다면
- dos2unix 설치 후 줄바꿈을 LF 로 변환
  
```bash
sudo apt-get install dos2unix
dos2unix run_all.sh

chmod +x run_all.sh
./run_all.sh
