@echo off
REM MySQL Backup Script for UniversityDB

REM Set variables
SET mysql_bin=C:\Program Files\MySQL\MySQL Server 8.0\bin
SET backup_dir=C:\backups
SET timestamp=%date:~-4,4%%date:~-10,2%%date:~-7,2%_%time:~0,2%%time:~3,2%
SET timestamp=%timestamp: =0%

REM Create backup with timestamp
"%mysql_bin%\mysqldump.exe" -u root -pYourPasswordHere UniversityDB > "%backup_dir%\UniversityDB_%timestamp%.sql"

REM Log the backup
echo Backup completed at %date% %time% >> "%backup_dir%\backup_log.txt"

REM Delete backups older than 7 days (optional)
forfiles /p "%backup_dir%" /s /m *.sql /d -7 /c "cmd /c del @path" 2>nul

echo Backup completed successfully!