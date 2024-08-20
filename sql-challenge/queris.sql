-- Query 1: List the employee number, last name, first name, sex, and salary of each employee
-- This query joins the employees and salaries tables to provide detailed information about each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
JOIN salaries s ON e.emp_no = s.emp_no;

-- Query 2: List the first name, last name, and hire date for the employees who were hired in 1986
-- This query filters the employees based on their hire date to show only those hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE YEAR(hire_date) = 1986;

-- Query 3: List the manager of each department along with their department number, department name, employee number, last name, and first name
-- This query joins the dept_manager, employees, and departments tables to list managers and their associated departments.
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name
FROM dept_manager dm
JOIN employees e ON dm.emp_no = e.emp_no
JOIN departments d ON dm.dept_no = d.dept_no;

-- Query 4: List the department number for each employee along with that employee’s employee number, last name, first name, and department name
-- This query joins the dept_emp, employees, and departments tables to show which department each employee belongs to.
SELECT de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e ON de.emp_no = e.emp_no
JOIN departments d ON de.dept_no = d.dept_no;

-- Query 5: List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B
-- This query filters employees based on specific criteria: first name 'Hercules' and last name starting with 'B'.
SELECT first_name, last_name, sex
FROM employees;

-- Query 6: List each employee in the Sales department, including their employee number, last name, and first name
-- This query shows employees working in the 'Sales' department by joining the appropriate tables.
SELECT e.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

-- Query 7: List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name
-- This query shows employees working in either the 'Sales' or 'Development' departments.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e
JOIN dept_emp de ON e.emp_no = de.emp_no
JOIN departments d ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

-- Query 8: List the frequency counts, in descending order, of all the employee last names
-- This query counts how many employees share each last name and orders the results by frequency.
SELECT last_name, COUNT(*) AS frequency
FROM employees
GROUP BY last_name
ORDER BY frequency DESC;



