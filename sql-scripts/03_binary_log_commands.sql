-- Commands used to check binary logs 
-- These are the actual commands used in MySQL Workbench

SHOW VARIABLES LIKE 'log_bin';
SHOW VARIABLES LIKE 'log_bin_basename';
SHOW BINARY LOGS;
SHOW MASTER STATUS;
SHOW VARIABLES LIKE 'binlog_format';
SELECT VERSION();
FLUSH LOGS;
