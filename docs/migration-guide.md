\# Migration Guide



\## Prerequisites



\- MySQL 8.0+

\- SQL Server 2025 Express

\- SSMA for MySQL

\- MySQL ODBC 9.1 Driver



\## Step 1: Create Database in MySQL



mysql -u root -p < sql-scripts/01\_create\_database.sql

mysql -u root -p UniversityDB < sql-scripts/02\_sample\_data.sql



text



\## Step 2: Configure MySQL Authentication



ALTER USER 'root'@'localhost'

IDENTIFIED WITH mysql\_native\_password BY 'your\_password';

FLUSH PRIVILEGES;



text



\## Step 3: Install \& Launch SSMA



1\. Download SSMA for MySQL from Microsoft

2\. Install with default settings

3\. Launch SSMA

4\. Create New Project

5\. Select SQL Server 2025 as target



\## Step 4: Connect to MySQL



Provider: MySQL ODBC 9.1 Driver

Server: localhost

Port: 3306

User: root

Database: UniversityDB



text



\## Step 5: Connect to SQL Server



Server: localhost\\SQLEXPRESS

Authentication: Windows Authentication

Database: UniversityDB (create new)

Trust server certificate: ✓



text



Click "Continue" on prerequisite warnings (normal for Express edition).



\## Step 6: Convert Schema



1\. In MySQL Metadata Explorer → Select all tables (Students, Courses, Enrollments)

2\. Right-click → Convert Schema

3\. Review conversion in SQL Server Metadata Explorer

4\. Right-click UniversityDB → Synchronize with Database

5\. Click OK to create database and tables



\## Step 7: Migrate Data



1\. In MySQL Metadata Explorer → Right-click UniversityDB

2\. Select "Migrate Data"

3\. Enter MySQL password if prompted

4\. Wait for migration to complete

5\. Review migration report



\## Step 8: Verify Migration



Check row counts in SQL Server:

\- Students: 6 rows

\- Courses: 5 rows

\- Enrollments: 8 rows



Migration complete! 

