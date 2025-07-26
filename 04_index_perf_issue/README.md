# 4장 쿼리가 갑자기 느려졌다 – 인덱스 재검토


## 목적
인덱스 유무에 따른 쿼리 성능 차이를 실습합니다.
- 테이블: board_posts
- 시나리오: category_id와 created_at을 기준으로 특정 카테고리의 최근 게시글을 조회하는 쿼리를 성능 비교

## 실행 순서
```bash
bash run_all.sh
