USE capstone;
SELECT * FROM countries;
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM jobs;
SELECT   department_name,COUNT(department_id)
FROM capstone.employees JOIN capstone.departments
USING (department_id)
GROUP BY department_name
ORDER BY COUNT(department_id ) DESC;
-- The department with the highest count is the Shipping department

-- What is the average salary per department, and which department has the highest and lowest average salaries?
SELECT AVG(salary), department_name
FROM capstone.departments JOIN capstone.employees
USING (department_id)
GROUP BY department_name
ORDER BY AVG(salary) DESC
LIMIT 1;
-- The unit with the highest average salary is Executive
SELECT AVG(salary), department_name
FROM capstone.departments JOIN capstone.employees
USING (department_id)
GROUP BY department_name
ORDER BY AVG(salary) ASC
LIMIT 1;
-- The unit with the Lowest average salary is Shipping

-- Classify employees into three salary bands using CASE: Low (<5000), Medium (5000 – 10000), High (>10000), How many employees fall into each band?
SELECT
CASE 
WHEN Salary < 5000 THEN 'Low'
WHEN Salary Between 5000 AND 10000 THEN 'Medium'
WHEN Salary > 10000 THEN 'High'
End as 'Salary_band',
COUNT(*) AS employee_count
FROM capstone.employees
Group by 1
ORDER BY employee_count DESC; 
-- LOW=49, MEDIUM = 43, HIGH = 15

-- List all countries in which Orion Data Systems operates. For each country, show the number of departments located there (Concepts: JOIN, GROUP BY, COUNT)

SELECT country_name, count(*) as country_count
FROM capstone.countries JOIN capstone.employees
USING(country_id)
JOIN capstone.departments
USING (department_id)
GROUP BY country_name;

-- Find all employees whose salaries are greater than the company-wide average salary.
SELECT emp_name, salary
FROM capstone.employees
WHERE salary > (
    SELECT AVG(salary) 
    FROM capstone.employees)
ORDER BY salary DESC;


-- For each job title, calculate the average salary. Then, identify job titles where the average salary is above 12,000.
SELECT 
    job_title, 
    AVG(salary) AS Average_Salary
FROM 
    jobs 
JOIN 
    employees USING(job_id)
GROUP BY 
    job_title
HAVING 
    AVG(salary) > 12000;
    
    
    -- Answer:  President, Administration Vice President, Sales Manager, Marketing Manager
    
    -- Calculate the total salaries paid to employees in each country. List the country name alongside the total salary cost, ordered from highest to lowest.
SELECT country_name, sum(salary) as Total_salaries
FROM employees JOIN countries 
USING (country_id) 
GROUP BY country_name
ORDER BY Total_salaries DESC;

-- Identify all job roles in the company (jobs table) that currently have no employees assigned.
SELECT Job_title, emp_name
FROM jobs JOIN employees
USING(job_id)
WHERE emp_name is null;
