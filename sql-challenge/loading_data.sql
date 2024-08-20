
-- Import data into departments table
LOAD DATA INFILE 'C:/Users/aristah/Desktop/sql-challenge/departments.csv'
INTO TABLE departments
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(dept_no, dept_name);

-- Import data into titles table
LOAD DATA INFILE 'C:/Users/aristah/Desktop/sql-challenge/titles.csv'
INTO TABLE titles
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(title_id, title);

-- Import data into employees table
LOAD DATA INFILE 'C:/Users/aristah/Desktop/sql-challenge/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 ROWS
(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date);

-- Import data into salaries table
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

-- Import data into dept_emp table
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



-- Import data into dept_manager table
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
