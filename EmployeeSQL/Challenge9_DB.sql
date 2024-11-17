--Create six tables

CREATE TABLE departments (
dept_no VARCHAR,
dept_name VARCHAR
)

CREATE TABLE dept_emp (
emp_no VARCHAR,
dept_no VARCHAR
)

CREATE TABLE dept_manager (
dept_no VARCHAR,
emp_no VARCHAR
)

CREATE TABLE employees (
emp_no VARCHAR,
emp_title_id VARCHAR,
birth_date DATE,
first_name VARCHAR,
last_name VARCHAR,
sex VARCHAR,
hire_date VARCHAR
)

CREATE TABLE salaries (
emp_no VARCHAR,
salary INT
)

CREATE TABLE titles (
title_id VARCHAR,
title VARCHAR
)

--1. List the employee number, last name, first name, sex, and salary of each employee.

ALTER TABLE salaries
RENAME COLUMN emp_no to emp_no_salaries;

SELECT emp_no, last_name, first_name, sex, salary
FROM Employees
	JOIN Salaries
	ON emp_no = emp_no_salaries

--2. List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date
LIKE '%1986'

--3. List the manager of each department along with their department number, department name, employee number, 
--last name, and first name.

ALTER TABLE dept_emp
RENAME COLUMN dept_no to dept_no_dept_emp

SELECT dept_no, dept_name, emp_no, dept_no_dept_emp
INTO departments_dept_emp
FROM departments
	JOIN dept_emp
	ON dept_no = dept_no_dept_emp

ALTER TABLE employees
RENAME COLUMN emp_no to emp_no_employees

SELECT dept_no, dept_name, emp_no, emp_no_employees, last_name, first_name
INTO departments_employees
FROM departments_dept_emp
	JOIN employees
	ON emp_no = emp_no_employees

DROP TABLE IF EXISTS employee_titles;
SELECT title_id, title, emp_title_id, emp_no_employees
INTO employee_titles
FROM titles
	JOIN employees
	ON title_id = emp_title_id

ALTER TABLE departments_employees
DROP COLUMN emp_no_employees

SELECT dept_no, dept_name, emp_no, last_name, first_name, title, emp_no_employees
INTO department_titles
FROM departments_employees
	JOIN employee_titles
	ON emp_no = emp_no_employees

SELECT * from department_titles

SELECT title, dept_no, dept_name, emp_no, last_name, first_name
FROM department_titles
WHERE title = 'Manager'

-- 4. List the department number for each employee along with that employee’s 
--employee number, last name, first name, and department name.

SELECT dept_no, emp_no, last_name, first_name, dept_name
FROM department_titles

--5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
From employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'

--6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT emp_no, last_name, first_name
FROM department_titles
WHERE dept_name = 'Sales'

--7. List each employee in the Sales and Development departments, 
--including their employee number, last name, first name, and department name.
SELECT dept_name, emp_no, last_name, first_name
FROM department_titles
WHERE dept_name = 'Sales' or dept_name = 'Development'

--8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT count(last_name), last_name
from employees
GROUP BY last_name
ORDER BY count desc