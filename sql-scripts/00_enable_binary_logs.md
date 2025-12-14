\# Enable Binary Logging in MySQL



\## Overview



Binary logging must be enabled in MySQL configuration file \*\*before\*\* starting PITR work.



\## Steps



\### 1. Locate my.ini File



\*\*Default location:\*\*

C:\\ProgramData\\MySQL\\MySQL Server 8.0\\my.ini



text



\### 2. Edit my.ini (as Administrator)



Open `my.ini` in Notepad (Run as Administrator)



\### 3. Add Binary Log Configuration



Find the `\[mysqld]` section and add these lines:



\[mysqld]



Enable binary logging

log-bin=mysql-bin

server-id=1

binlog\_format=ROW



text



\*\*Explanation:\*\*

\- `log-bin` - Enables binary logging with filename prefix (can be customized)

\- `server-id` - Unique server identifier (required for replication/logging)

\- `binlog\_format=ROW` - MySQL 8.0 default; logs row changes



\*\*Note:\*\* You can customize the prefix (e.g., `log-bin=binlog` or `log-bin=mysql-bin`). This determines your binary log filenames.



\### 4. Restart MySQL Service



\*\*Using Services:\*\*

Open services.msc



Find "MySQL80"



Right-click → Restart



text



\*\*Using Command Prompt (as Admin):\*\*

net stop MySQL80

net start MySQL80



text



\### 5. Verify Binary Logging Enabled



Open MySQL Workbench and run:



SHOW VARIABLES LIKE 'log\_bin';

-- Should show: ON



SHOW VARIABLES LIKE 'log\_bin\_basename';

-- Shows full path with your chosen prefix



text



\## Notes



\- Binary logs are stored in MySQL data directory

\- Default location: `C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Data\\`

\- File naming depends on your prefix:

&nbsp; - `log-bin=mysql-bin` → `mysql-bin.000001`, `mysql-bin.000002`

&nbsp; - `log-bin=binlog` → `binlog.000001`, `binlog.000002`

&nbsp; - Default (hostname) → `DESKTOP-NAME-bin.000001`

\- Each FLUSH LOGS command creates a new binary log file

