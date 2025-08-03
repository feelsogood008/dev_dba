-- 환경 설정 적용
-- 이 SQL 파일은 쉘 스크립트에서 @undo_log_size 변수 값을 넘겨받아 실행됨

-- 변수값 확인
SELECT @undo_log_size AS '설정할 undo log size';

-- 세션 변수 설정 (참고용: 실제 적용은 my.cnf 에서 해야 지속됨)
SET GLOBAL innodb_max_undo_log_size = @undo_log_size;

-- 적용 결과 확인
SHOW VARIABLES LIKE 'innodb_max_undo_log_size';
