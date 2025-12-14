\# Point-in-Time Recovery Guide



\## Overview



Point-in-Time Recovery (PITR) uses MySQL binary logs to recover from disasters like accidental DELETE statements.



\## Prerequisites



\- Binary logging enabled (`SHOW VARIABLES LIKE 'log\_bin';`)

\- Full backup taken before disaster

\- Binary log files retained



\## Step 1: Verify Binary Log Setup



Run these commands in MySQL Workbench:



-- Check if enabled

SHOW VARIABLES LIKE 'log\_bin';



-- Find binary log location

SHOW VARIABLES LIKE 'log\_bin\_basename';



-- List binary logs

SHOW BINARY LOGS;



-- Check current position

SHOW MASTER STATUS;



-- Check format

SHOW VARIABLES LIKE 'binlog\_format';



text



\*\*Note your binary log filename\*\* (e.g., `DESKTOP-LI8JPBJ-bin.000002`)



\## Step 2: Take Full Backup



cd "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin"

mysqldump -u root -p UniversityDB > C:\\backups\\UniversityDB\_base.sql



text



\*\*Record backup time\*\* (e.g., 18:06:00)



\## Step 3: Add Good Data (Before Disaster)



USE UniversityDB;



-- Record time BEFORE insertions

SELECT NOW();



-- Add good data

INSERT INTO Students (FirstName, LastName, Email)

VALUES ('Zainab', 'Tariq', 'zainab.tariq@university.edu');



INSERT INTO Courses (CourseName, Credits, Department)

VALUES ('Artificial Intelligence', 3, 'Computer Science');



-- Record time AFTER insertions

SELECT NOW();



text



\*\*Record "Good Data End" time\*\* (e.g., 18:20:57)



\## Step 4: Simulate Disaster



Wait 1-2 minutes, then:



-- Record disaster time

SELECT NOW();



-- DISASTER: Accidental DELETE of all students

DELETE FROM Students WHERE StudentID >= 1;



-- Verify damage

SELECT COUNT() FROM Students; -- Shows 0 (all deleted)



text



\*\*Record "Disaster Time"\*\* (e.g., 18:26:24)



\*\*Note:\*\* With ON DELETE SET NULL, enrollments remain but lose student references. PITR recovers both students and their enrollment relationships.



\## Step 5: Find Binary Log Information



-- Check which binary log is current

SHOW MASTER STATUS;



-- Find your binary log basename

SHOW VARIABLES LIKE 'log\_bin\_basename';



text



\*\*Example output:\*\*  

`C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\DESKTOP-LI8JPBJ-bin`



\*\*Your binary log file:\*\* `DESKTOP-LI8JPBJ-bin.000002` (or mysql-bin.000002)



\## Step 6: Perform Recovery



\### Drop Corrupted Database



DROP DATABASE UniversityDB;



text



\### Restore Base Backup



cd "C:\\Program Files\\MySQL\\MySQL Server 8.0\\bin"

mysql -u root -p < C:\\backups\\UniversityDB\_base.sql



text



\### Apply Binary Log (Exclude Disaster)



Replace times with YOUR recorded times

Replace binary log filename with YOUR actual filename

mysqlbinlog --start-datetime="2025-12-14 18:19:35" --stop-datetime="2025-12-14 18:21:00" "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\mysql-bin.000002" | mysql -u root -p UniversityDB



text



\*\*Important:\*\*

\- `--start-datetime`: After backup, before/at start of good data

\- `--stop-datetime`: After good data, BEFORE disaster

\- Use YOUR binary log filename (with hostname prefix)



\## Step 7: Verify Recovery



USE UniversityDB;



-- Check count

SELECT COUNT(\*) FROM Students;

-- Should show 6



-- Verify Zainab (row6) exists



-- Verify AI course(row5) exists

SELECT \* FROM Courses;



-- Verify enrollments have StudentID back (not NULL)

SELECT \* FROM Enrollments;



text



\## Recovery Timeline



Base Backup  Good Data           Disaster

18:06:00 →   18:20:22-18:20:57 → 18:26:24

↓ ↓ ↓

Restore      Apply Binary Log    DON'T Apply

Backup       (start → stop)      (excluded)







Recovery complete! Zero data loss 

