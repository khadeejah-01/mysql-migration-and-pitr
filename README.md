\# MySQL to SQL Server Migration \& Point-in-Time Recovery



!\[License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)

!\[MySQL](https://img.shields.io/badge/MySQL-8.0.44-blue.svg)

!\[SQL Server](https://img.shields.io/badge/SQL%20Server-2025%20Express-red.svg)



\##  Project Overview



A comprehensive database administration project demonstrating cross-platform migration from MySQL to SQL Server using SSMA, and implementing disaster recovery through binary log-based point-in-time recovery.



This project showcases real-world DBA skills including database migration across different RDBMS platforms, point-in-time recovery procedures, and automated backup implementation.



\##  Objectives



\- Migrate UniversityDB from MySQL 8.0 to SQL Server 2025 Express using SSMA

\- Implement point-in-time recovery using MySQL binary logs

\- Automate database backups with scheduled batch scripts

\- Document complete migration and recovery processes for portfolio



\##  Technologies Used



\- \*\*MySQL 8.0.44 Community Edition\*\* - Source database platform

\- \*\*SQL Server 2025 Express\*\* - Target database platform

\- \*\*SQL Server Migration Assistant (SSMA) for MySQL\*\* - Migration tool

\- \*\*MySQL ODBC 9.1 Driver\*\* - Database connectivity

\- \*\*MySQL Binary Logs\*\* - Point-in-time recovery mechanism

\- \*\*mysqldump\*\* - Backup utility

\- \*\*mysqlbinlog\*\* - Binary log analysis and recovery tool

\- \*\*Windows Task Scheduler\*\* - Backup automation



\##  Key Features



\### 1. Cross-Platform Database Migration

\- Automated schema conversion (MySQL → SQL Server)

\- Data type mapping (VARCHAR → NVARCHAR, AUTO\_INCREMENT → IDENTITY)

\- Referential integrity preservation

\- Client-side data migration engine

\- Migration verification procedures



\### 2. Point-in-Time Recovery (PITR)

\- Binary log-based disaster recovery

\- Time-based transaction replay using --start-datetime and --stop-datetime

\- Disaster scenario simulation (accidental DELETE recovery)

\- Sub-second recovery precision

\- Recovery verification and validation



\### 3. Automated Backup System

\- Scheduled nightly backups at 2:00 AM

\- Timestamp-based file naming for easy identification

\- 7-day retention policy with automatic cleanup

\- Execution logging for audit trail



\##  Database Schema



\*\*UniversityDB\*\* - Educational institution management system



\*\*Tables:\*\*

\- \*\*Students\*\* - Student information (StudentID, FirstName, LastName, Email, EnrollmentDate)

\- \*\*Courses\*\* - Course catalog (CourseID, CourseName, Credits, Department)

\- \*\*Enrollments\*\* - Student-course relationships (EnrollmentID, StudentID, CourseID, EnrollmentDate, Grade)



\*\*Sample Data:\*\*

\- 6 students

\- 5 courses

\- 8 enrollments



\##  Results



\### Migration Performance

✅ Zero data loss during migration  

✅ 100% data integrity verification passed  

✅ Schema conversion: 3 tables, 100% success rate  

✅ Row count verification: Source = Target  

✅ Referential integrity maintained



\### Point-in-Time Recovery

✅ Recovery Point Objective (RPO): Sub-second precision  

✅ Recovery Time Objective (RTO): ~5 minutes  

✅ Data loss: 0 rows  

✅ Disaster transaction successfully excluded



\##  Challenges \& Solutions



\### 1. ODBC Driver Selection

\*\*Challenge:\*\* Initial SSMA connection used ODBC 5.1, needed to determine optimal driver version  

\*\*Solution:\*\* Switched to MySQL ODBC 9.1 driver during migration phase - worked perfectly  

\*\*Learning:\*\* SSMA supports multiple ODBC driver versions; both 5.1 and 9.x are compatible. Version 9.1 is recommended for MySQL 8.0+



\### 2. MySQL Authentication Method

\*\*Challenge:\*\* SSMA connection required mysql\_native\_password authentication  

\*\*Solution:\*\* Changed MySQL user authentication plugin to mysql\_native\_password  

\*\*Learning:\*\* MySQL 8.0 defaults to caching\_sha2\_password; SSMA requires native password method



\### 3. ROW-based Binary Log Format

\*\*Challenge:\*\* Binary log showed row changes, not SQL statements  

\*\*Solution:\*\* Used `mysqlbinlog --base64-output=DECODE-ROWS -v` to decode row events  

\*\*Learning:\*\* MySQL 8.0 defaults to ROW format; verbose mode is essential for analysis



\### 4. Binary Log File Naming

\*\*Challenge:\*\* Binary logs used hostname prefix (DESKTOP-LI8JPBJ-bin.XXXXXX) instead of standard mysql-bin  

\*\*Solution:\*\* Used `SHOW VARIABLES LIKE 'log\_bin\_basename'` to find actual location and filenames  

\*\*Learning:\*\* Always check actual binary log file names before using mysqlbinlog; they may include system hostname



\### 5. Database Already Exists Error During PITR

\*\*Challenge:\*\* Binary log contained CREATE DATABASE, conflicting with restored backup  

\*\*Solution:\*\* Used `--start-datetime` flag to skip CREATE DATABASE statement  

\*\*Learning:\*\* Start-datetime is essential when binary log includes initial setup commands



\### 6. SQL Server Agent Unavailable

\*\*Challenge:\*\* SQL Server Express doesn't include SQL Server Agent  

\*\*Solution:\*\* Used client-side migration engine instead of server-side  

\*\*Learning:\*\* Express edition limitations require alternative approaches; client-side works well for small-to-medium databases



\##  Documentation



Detailed guides available in `/docs` folder:



\- \*\*\[Migration Guide](docs/migration-guide.md)\*\* - Step-by-step migration process

\- \*\*\[PITR Guide](docs/pitr-guide.md)\*\* - Point-in-time recovery procedures

\- \*\*\[Troubleshooting](docs/troubleshooting.md)\*\* - Common issues and solutions



\##  Quick Start



\### Prerequisites

\- MySQL 8.0 or higher

\- SQL Server 2019/2022/2025 (Express or higher)

\- SSMA for MySQL v9.x

\- MySQL ODBC 9.x Driver



\### Setup



1\. Clone repository

git clone https://github.com/khadeejah-01/mysql-migration-and-pitr.git

cd mysql-migration-and-pitr



2\. Create MySQL database

mysql -u root -p < sql-scripts/01\_create\_database.sql



3\. Insert sample data

mysql -u root -p UniversityDB < sql-scripts/02\_sample\_data.sql



4\. Follow migration guide

See docs/migration-guide.md for detailed instructions



text



\##  Key Learnings



\### Technical Insights

\- Binary logging must be enabled BEFORE disaster occurs (proactive, not reactive)

\- Cross-platform migrations require careful data type mapping and testing

\- Time-based recovery with start-datetime provides granular control over transaction replay

\- SSMA supports multiple ODBC driver versions - flexibility in driver selection

\- mysql\_native\_password authentication is essential for SSMA connectivity

\- Regular backups + binary logs = complete data protection strategy



\### Best Practices

\- Document exact versions and configurations for reproducibility

\- Test different driver versions if connectivity issues occur

\- Use start-datetime in PITR when binary logs include setup commands

\- Automate backups to eliminate human error

\- Maintain both full backups (baseline) and binary logs (incremental changes)

\- Keep detailed recovery time logs for accurate PITR



\### Industry Relevance

\- These are actual production DBA responsibilities

\- Companies invest heavily in disaster recovery planning and testing

\- Migration skills are valuable during system modernization projects

\- Backup automation is critical for 24/7 operations and compliance



\##  Future Enhancements



\- \[ ] Add support for PostgreSQL migration

\- \[ ] Implement incremental backup strategy (differential backups)

\- \[ ] Create monitoring dashboard for backup status

\- \[ ] Add email alerting for failed backups

\- \[ ] Extend to MySQL → Azure SQL Database migration

\- \[ ] Implement backup encryption for sensitive data

\- \[ ] Add automated restore testing

\- \[ ] Create Ansible/Terraform scripts for infrastructure automation



\##  Contributing



This is a portfolio project, but suggestions are welcome! If you find issues or have improvements:



1\. Fork the repository

2\. Create a feature branch (`git checkout -b feature/improvement`)

3\. Commit changes (`git commit -m 'Add improvement'`)

4\. Push to branch (`git push origin feature/improvement`)

5\. Open a Pull Request



\##  Author



\*\*Khadeejah\*\*  

BS Computer Science Student  

&nbsp;Email: your.email@example.com  

&nbsp;LinkedIn: \[linkedin.com/in/yourprofile](https://linkedin.com/in/yourprofile)  

&nbsp;Location: Pakistan



\##  License



This project is licensed under the MIT License - see the \[LICENSE](LICENSE) file for details.



\##  Acknowledgments



\- MySQL Documentation for binary log reference

\- Microsoft SSMA documentation for migration procedures

\- Database Administration community for best practices

\- Stack Overflow community for troubleshooting assistance



---



\*\* If you found this project helpful, please consider giving it a star!\*\*



\*\* Project Status:\*\* Complete  | Last Updated: December 2025

