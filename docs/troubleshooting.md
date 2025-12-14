\# Troubleshooting Guide



\## MySQL Connection Issues



\### ODBC Driver Not Found



\*\*Solution:\*\*

1\. Download MySQL ODBC 9.1 from https://dev.mysql.com/downloads/connector/odbc/

2\. Install the driver

3\. Verify in odbcad64.exe → Drivers tab

4\. Restart SSMA



\### Authentication Failed



\*\*Error:\*\* "Access denied for user 'root'@'localhost'"



\*\*Solution:\*\*

ALTER USER 'root'@'localhost'

IDENTIFIED WITH mysql\_native\_password BY 'your\_password';

FLUSH PRIVILEGES;



text



\### SSMA Can't Connect



\*\*Solution:\*\*

1\. Try switching ODBC driver version (5.1 ↔ 9.1)

2\. Check MySQL service is running (services.msc)

3\. Verify port 3306 is not blocked



\## SQL Server Connection Issues



\### Can't Find SQL Server Instance



\*\*Solution:\*\*

\- Use: `localhost\\SQLEXPRESS` (not just `localhost`)

\- Select Windows Authentication

\- Check "Trust server certificate"



\## Migration Issues



\### "SQL Server Agent not running"



\*\*This is normal for Express edition.\*\*



\*\*Solution:\*\* Click "Continue" - SSMA uses client-side migration automatically.



\### Password Prompt During Migration



\*\*Solution:\*\* SSMA may not save passwords between steps. Re-enter when prompted.



\## PITR Issues



\### Binary Log File Not Found



\*\*Solution:\*\*

-- Find actual filename

SHOW VARIABLES LIKE 'log\_bin\_basename';



text

Use the exact path and filename shown (includes your hostname).



\### Can't Read Binary Log ('DELETE' keyword)



\*\*Solution:\*\*

Use verbose mode to decode ROW format (in cmd using administrator privileges)

mysqlbinlog --base64-output=DECODE-ROWS -v binlog\_file > output.txt



text



\### "Database already exists" During Recovery



\*\*Solution:\*\*

\- Binary log contains CREATE DATABASE statement

\- Use `--start-datetime` to skip it

\- Or manually drop database before restoring



\### Recovery Shows Wrong Data



\*\*Problem:\*\* Timestamps don't match expected data



\*\*Solution:\*\*

\- Verify start-datetime is AFTER backup time

\- Verify stop-datetime is BEFORE disaster time

\- Check you're using correct binary log file (SHOW MASTER STATUS)



\## Backup Script Issues



\### "Access Denied" in Backup Script



\*\*Solution:\*\*

1\. Run Command Prompt as Administrator

2\. Verify MySQL password in script

3\. Check mysql\_bin path is correct



\### Scheduled Backup Not Running



\*\*Solution:\*\*

1\. Open Task Scheduler → Check task status

2\. Ensure "Run with highest privileges" is checked

3\. Verify trigger is set correctly (Daily at 2:00 AM)

4\. Check backup\_log.txt for error messages





\## Common Mistakes



\- Using wrong binary log filename (forgot hostname prefix)

\- Not using --start-datetime (applies CREATE DATABASE twice)

\- Stop-datetime AFTER disaster (includes bad transaction)

\- Forgetting to take backup BEFORE disaster occurs

