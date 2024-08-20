# SQL Data Challenge

## Overview

This project involves setting up a database schema, importing data from CSV files into the schema, and performing data analysis queries. The goal is to create and manage a database that handles employee data, including departments, titles, salaries, and managerial roles.

## Data Modeling

### Entity Relationship Diagram (ERD)

The database schema includes the following tables:

- **Departments**: Stores information about departments.
- **Titles**: Stores job titles for employees.
- **Employees**: Stores details about employees, including their job titles and personal information.
- **Salaries**: Contains salary information for employees.
- **Dept_Emp**: Maps employees to departments.
- **Dept_Manager**: Maps managers to departments.

**ERD Sketch:**
![ERD Sketch](path/to/ERD_image) 

### Relationships

- **Employees** have a one-to-many relationship with **Salaries**. Each employee can have only one salary record.
- **Employees** have a many-to-many relationship with **Departments** through **Dept_Emp**. An employee can be associated with multiple departments.
- **Employees** can be managers of departments through **Dept_Manager**. Each department can have one manager.

## Data Engineering

### Table Creation

Below are the SQL commands to create the tables in the database schema. This setup includes data types, primary keys, foreign keys, and other constraints to ensure data integrity.

```sql
-- Create Departments Table
CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,
    dept_name VARCHAR(40) NOT NULL
);

-- Create Titles Table
CREATE TABLE titles (
    title_id CHAR(5) PRIMARY KEY,
    title VARCHAR(50) NOT NULL
);

-- Create Employees Table
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,
    emp_title_id CHAR(5),
    birth_date DATE NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    sex CHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

-- Create Salaries Table
CREATE TABLE salaries (
    emp_no INT NOT NULL,
    salary DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no)
);

-- Create Dept_Emp Table
CREATE TABLE dept_emp (
    emp_no INT,
    dept_no CHAR(4),
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

-- Create Dept_Manager Table
CREATE TABLE dept_manager (
    dept_no CHAR(4),
    emp_no INT,
    PRIMARY KEY (dept_no, emp_no),
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

## Data Import
## Data is imported from CSV files into the corresponding tables. Special handling ensures that only valid employee numbers are imported, especially when they need to match records in the employees table.

Importing Salaries Data
CREATE TEMPORARY TABLE temp_salaries (
    emp_no INT,
    salary INT
);

LOAD DATA INFILE 'C:/Users/aristah/Desktop/sql-challenge/salaries.csv'
INTO TABLE temp_salaries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(emp_no, salary);

INSERT INTO salaries (emp_no, salary)
SELECT emp_no, salary
FROM temp_salaries
WHERE emp_no IN (SELECT emp_no FROM employees);


-- Create temporary table
CREATE TEMPORARY TABLE temp_dept_emp (
     emp_no INT,
    dept_no CHAR(4)
   
);

-- Load data
LOAD DATA INFILE 'C:/Users/aristah/Desktop/sql-challenge/dept_emp.csv'
INTO TABLE temp_dept_emp
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(emp_no, dept_no);

INSERT INTO dept_emp (emp_no,dept_no)
SELECT emp_no, dept_no
FROM temp_dept_emp
WHERE emp_no IN (SELECT emp_no FROM employees);




-- Create temporary table
CREATE TEMPORARY TABLE temp_dept_manager (
    dept_no CHAR(4),
    emp_no INT
   
);

-- Load data
LOAD DATA INFILE 'C:/Users/aristah/Desktop/sql-challenge/dept_manager.csv'
INTO TABLE temp_dept_manager
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(dept_no,emp_no);

INSERT INTO dept_manager (emp_no,dept_no)
SELECT  dept_no, emp_no 
FROM temp_dept_manager
WHERE emp_no IN (SELECT emp_no FROM employees);
