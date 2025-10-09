
USE demo_db;


-- 오래된 월 파티션을 자동으로 제거하는 이벤트
-- 예: 현재로부터 90일 이전의 월 파티션을 매일 03:30에 삭제 시도
SET GLOBAL event_scheduler = ON;

DROP PROCEDURE IF EXISTS rotate_log_partitions;
DELIMITER //
CREATE PROCEDURE rotate_log_partitions()
BEGIN
  DECLARE pname VARCHAR(32);
  DECLARE cnt INT DEFAULT 0;
  DECLARE has_err INT DEFAULT 0;

  -- 오류 발생시 has_err 를 1로 세팅 (빈 BEGIN/END 대신)
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_err = 1;

  SET pname = DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 'p%Y%m');

  -- 파티션 존재 여부 확인
  SELECT COUNT(*) INTO cnt
  FROM information_schema.PARTITIONS
  WHERE TABLE_SCHEMA = 'logs'
    AND TABLE_NAME = 'log_events_part'
    AND PARTITION_NAME = pname;

  IF cnt = 0 THEN
    SELECT CONCAT('partition ', pname, ' does not exist') AS info;
  ELSE
    -- PREPARE는 세션 변수(@sql) 사용
    SET @sql = CONCAT('ALTER TABLE `logs`.`log_events_part` DROP PARTITION `', pname, '`');
    PREPARE dyn FROM @sql;
    EXECUTE dyn;
    DEALLOCATE PREPARE dyn;

    IF has_err = 1 THEN
      SELECT CONCAT('error occurred while dropping partition ', pname) AS error;
    ELSE
      SELECT CONCAT('dropped partition ', pname) AS info;
    END IF;
  END IF;
END //
DELIMITER ;

-- 이벤트 등록 (rotate_log_partitions 실행)
DROP EVENT IF EXISTS ev_rotate_log_partitions;
CREATE EVENT ev_rotate_log_partitions
  ON SCHEDULE EVERY 1 DAY STARTS CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 3 HOUR + INTERVAL 30 MINUTE
  DO CALL rotate_log_partitions();


-- CALL rotate_log_partitions();
-- SHOW WARNINGS;


-- 참고: 새 월 진입 시 다음달 파티션을 미리 추가하는 작업도 권장
DROP PROCEDURE IF EXISTS ensure_next_month_partition;
DELIMITER //
CREATE PROCEDURE ensure_next_month_partition()
BEGIN
  DECLARE next_p  VARCHAR(16);
  DECLARE next_v  DATE;
  DECLARE cnt     INT DEFAULT 0;
  DECLARE has_err INT DEFAULT 0;

  -- 예외 발생 시 플래그 설정 (빈 BEGIN END 대신)
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET has_err = 1;

  -- 다음 달 1일 (파티션 경계값)
  SET next_v = DATE_ADD(LAST_DAY(CURDATE()), INTERVAL 1 DAY);
  SET next_p = DATE_FORMAT(next_v, 'p%Y%m');

  -- 파티션 존재 여부 확인
  SELECT COUNT(*) INTO cnt
  FROM information_schema.PARTITIONS
  WHERE TABLE_SCHEMA = 'logs'
    AND TABLE_NAME = 'log_events_part'
    AND PARTITION_NAME = next_p;

  IF cnt = 0 THEN
    -- ADD PARTITION SQL 구성
    SET @sql = CONCAT(
      'ALTER TABLE `logs`.`log_events_part` ',
      'ADD PARTITION (PARTITION `', next_p, '` VALUES LESS THAN (\'',
      DATE_FORMAT(DATE_ADD(next_v, INTERVAL 1 MONTH), '%Y-%m-01'),
      '\'))'
    );

    PREPARE dyn FROM @sql;
    EXECUTE dyn;
    DEALLOCATE PREPARE dyn;

    IF has_err = 1 THEN
      SELECT CONCAT('Error while adding partition ', next_p) AS msg;
    ELSE
      SELECT CONCAT('Added partition ', next_p) AS msg;
    END IF;
  ELSE
    SELECT CONCAT('Partition ', next_p, ' already exists') AS msg;
  END IF;
END //
DELIMITER ;


-- 이벤트 등록 (ev_ensure_next_month_partition 실행)
DROP EVENT IF EXISTS ev_ensure_next_month_partition;
CREATE EVENT ev_ensure_next_month_partition
  ON SCHEDULE EVERY 1 DAY STARTS CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 2 HOUR
  DO CALL ensure_next_month_partition();

-- CALL ensure_next_month_partition();
-- SHOW WARNINGS;
