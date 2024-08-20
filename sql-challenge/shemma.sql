-- Create the 'departments' table
-- This table stores department information with a unique department number and name.
CREATE TABLE departments (
    dept_no CHAR(4) PRIMARY KEY,     -- Department number as the primary key
    dept_name VARCHAR(40) NOT NULL   -- Department name, cannot be null
);

-- Create the 'titles' table
-- This table stores job titles with a unique title ID and title description.
CREATE TABLE titles (
    title_id CHAR(5) PRIMARY KEY,    -- Title ID as the primary key
    title VARCHAR(50) NOT NULL       -- Title name, cannot be null
);

-- Create the 'employees' table
-- This table stores employee information with a unique employee number, title ID, and personal details.
CREATE TABLE employees (
    emp_no INT PRIMARY KEY,          -- Employee number as the primary key
    emp_title_id CHAR(5),            -- Title ID, references the 'titles' table
    birth_date DATE NOT NULL,        -- Employee's birth date, cannot be null
    first_name VARCHAR(50) NOT NULL, -- Employee's first name, cannot be null
    last_name VARCHAR(50) NOT NULL,  -- Employee's last name, cannot be null
    sex CHAR(1) NOT NULL,            -- Employee's gender, cannot be null
    hire_date DATE NOT NULL,         -- Employee's hire date, cannot be null
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id) -- Foreign key constraint on title ID
);

-- Create the 'salaries' table
-- This table stores salary information for employees with a foreign key to the 'employees' table.
CREATE TABLE salaries (
    emp_no INT NOT NULL,             -- Employee number, not null
    salary DECIMAL(10, 2) NOT NULL, -- Salary amount, not null
    PRIMARY KEY (emp_no),           -- Primary key is employee number
    FOREIGN KEY (emp_no) REFERENCES employees (emp_no) -- Foreign key constraint on employee number
);

-- Create the 'dept_emp' table
-- This table stores which employees are assigned to which departments, with a composite primary key.
CREATE TABLE dept_emp ( 
    emp_no INT,                      -- Employee number
    dept_no CHAR(4),                 -- Department number
    PRIMARY KEY (dept_no, emp_no),   -- Composite primary key
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no), -- Foreign key constraint on department number
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) -- Foreign key constraint on employee number
);

-- Create the 'dept_manager' table
-- This table stores information about department managers, with a composite primary key.
CREATE TABLE dept_manager ( 
    dept_no CHAR(4),                 -- Department number
    emp_no INT,                      -- Employee number
    PRIMARY KEY (dept_no, emp_no),   -- Composite primary key
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no), -- Foreign key constraint on department number
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) -- Foreign key constraint on employee number
);
