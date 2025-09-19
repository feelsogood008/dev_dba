
USE demo_db;


-- 오래된 월 파티션을 자동으로 제거하는 이벤트
-- 예: 현재로부터 90일 이전의 월 파티션을 매일 03:30에 삭제 시도
SET GLOBAL event_scheduler = ON;

DROP PROCEDURE IF EXISTS rotate_log_partitions;
DELIMITER //
CREATE PROCEDURE rotate_log_partitions()
BEGIN
  DECLARE pname VARCHAR(16);
  DECLARE stmt  TEXT;

  -- 3개월 전 월 파티션 이름 계산 (예: p202505)
  SET pname = DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 3 MONTH), 'p%Y%m');
  SET stmt  = CONCAT('ALTER TABLE logs.log_events_part DROP PARTITION ', pname);

  -- 파티션 없을 수도 있으니 에러 무시
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;

  PREPARE s FROM stmt;
  EXECUTE s;
  DEALLOCATE PREPARE s;
END//
DELIMITER ;

DROP EVENT IF EXISTS ev_rotate_log_partitions;
CREATE EVENT ev_rotate_log_partitions
  ON SCHEDULE EVERY 1 DAY STARTS CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 3 HOUR + INTERVAL 30 MINUTE
  DO CALL rotate_log_partitions();

-- 참고: 새 월 진입 시 다음달 파티션을 미리 추가하는 작업도 권장
DROP PROCEDURE IF EXISTS ensure_next_month_partition;
DELIMITER //
CREATE PROCEDURE ensure_next_month_partition()
BEGIN
  DECLARE next_p  VARCHAR(16);
  DECLARE next_v  DATE;
  DECLARE stmt    TEXT;
  DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END;

  SET next_v = DATE_FORMAT(DATE_ADD(LAST_DAY(CURDATE()), INTERVAL 1 DAY), '%Y-%m-01');
  SET next_p = DATE_FORMAT(next_v, 'p%Y%m');

  SET @exists := (SELECT COUNT(*) FROM information_schema.partitions
                  WHERE table_schema='logs' AND table_name='log_events_part' AND partition_name=next_p);
  IF @exists = 0 THEN
    SET stmt = CONCAT("ALTER TABLE logs.log_events_part ADD PARTITION (PARTITION ", next_p,
                      " VALUES LESS THAN ('", DATE_FORMAT(DATE_ADD(next_v, INTERVAL 1 MONTH), '%Y-%m-01'), "'))");
    PREPARE s FROM stmt; EXECUTE s; DEALLOCATE PREPARE s;
  END IF;
END//
DELIMITER ;

DROP EVENT IF EXISTS ev_ensure_next_month_partition;
CREATE EVENT ev_ensure_next_month_partition
  ON SCHEDULE EVERY 1 DAY STARTS CURRENT_DATE + INTERVAL 1 DAY + INTERVAL 2 HOUR
  DO CALL ensure_next_month_partition();
