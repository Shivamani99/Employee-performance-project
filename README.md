📊 Employee Performance Mapping - MySQL Project
📌 Project Overview
This project, Employee Performance Mapping, was completed as part of the SQL Training Course-End Project. The goal was to help ScienceQtech, a data science startup, analyze and evaluate employee performance using a relational database approach in MySQL.

🧠 Problem Statement
ScienceQtech needs a system to analyze employee performance during their annual appraisal cycle. As a Junior Database Administrator (DBA), your job is to extract key insights from the employee and project data, calculate bonuses, evaluate job standards, and assist HR with data-driven decision-making.

🗂️ Dataset Description
Three datasets were used:

1. emp_record_table.csv
Details of all employees:

EMP_ID, FIRST_NAME, LAST_NAME, GENDER, ROLE, DEPT, EXP, COUNTRY, CONTINENT, SALARY, EMP_RATING, MANAGER_ID, PROJ_ID

2. proj_table.csv
Information about all projects:

PROJECT_ID, PROJ_NAME, DOMAIN, START_DATE, CLOSURE_DATE, DEV_QTR, STATUS

3. data_science_team.csv
Employees in the data science team:

EMP_ID, FIRST_NAME, LAST_NAME, GENDER, ROLE, DEPT, EXP, COUNTRY, CONTINENT

⚙️ Setup Instructions
Create Database:

sql
Copy
Edit
CREATE DATABASE employee;
Import Datasets:

Load the three CSV files into MySQL tables within the employee database.

Entity Relationship (ER) Diagram:

Constructed to understand the relationships between employee, project, and team data.

✅ Key SQL Tasks Performed
Fetch employee details with various filters (e.g., department, ratings)

Concatenate names and use column aliasing

List managers and their reporters

Filter employees using UNION, GROUP BY, and HAVING clauses

Calculate:

Min/max salary by role

Ranking by experience

Bonuses based on rating

Average salary by country and continent

Use of:

Views for high-salary employees

Stored Procedures for filtering by experience

Stored Functions to match roles with experience

Indexing to improve search performance

Nested queries and subqueries


🧮 Job Role Standards Mapping (Stored Function Logic)
Experience (Years)	Job Title
0–2	JUNIOR DATA SCIENTIST
2–5	ASSOCIATE DATA SCIENTIST
5–10	SENIOR DATA SCIENTIST
10–12	LEAD DATA SCIENTIST
12–16	MANAGER

📊 Outputs
Clean, normalized relational data tables

Insightful queries supporting HR appraisal and training decisions

Optimized query performance using indexes and procedures

🛠️ Tools Used
Database: MySQL

IDE: MySQL Workbench 
