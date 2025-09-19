
USE demo_db;


DROP EVENT IF EXISTS ev_rotate_log_partitions;
DROP EVENT IF EXISTS ev_ensure_next_month_partition;
DROP PROCEDURE IF EXISTS rotate_log_partitions;
DROP PROCEDURE IF EXISTS ensure_next_month_partition;

DROP TABLE IF EXISTS log_events_archive;
DROP TABLE IF EXISTS log_events_part;
DROP TABLE IF EXISTS log_events_raw;
DROP TABLE IF EXISTS util_numbers;


DROP DATABASE demo_db;
