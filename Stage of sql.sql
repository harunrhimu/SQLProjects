--make a project to cover all think together,
--Here's a structured list of PostgreSQL SQL functions, keywords, and concepts along with brief explanations:

    --SELECT: Retrieves data from a database.
SELECT * 
FROM employees;

--    FROM: Specifies the table from which to retrieve data.
SELECT * FROM employees;

--    WHERE: Filters rows based on a condition.
SELECT * FROM employees
WHERE department = 'Sales';

--    GROUP BY: Groups rows that have the same values into summary rows.
SELECT department, COUNT(*) as employee_count
FROM employees
GROUP BY department;

--    HAVING: Filters groups based on a condition.
SELECT department, COUNT(*) as employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 5;

--    LIMIT: Specifies the maximum number of rows to return.
SELECT * FROM employees
LIMIT 10;

--    Joins:
--        INNER JOIN: Returns rows when there is a match in both tables.
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

--        LEFT JOIN (LEFT OUTER JOIN): Returns all rows from the left table and matched rows from the right table.
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

--        RIGHT JOIN (RIGHT OUTER JOIN): Returns all rows from the right table and matched rows from the left table.
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;

--        FULL JOIN (FULL OUTER JOIN): Returns all rows when there is a match in either table.
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
FULL JOIN departments d ON e.department_id = d.department_id;

--        CROSS JOIN: Returns the Cartesian product of the sets of rows from the joined tables.
SELECT e.employee_name, d.department_name
FROM employees e
CROSS JOIN departments d;



--    Aggregate Functions:
--        SUM(): Calculates the sum of values.
SELECT SUM(salary) AS total_salary
FROM employees;

--        MAX(): Returns the maximum value.
SELECT MAX(salary) AS max_salary
FROM employees;

--        MIN(): Returns the minimum value.
SELECT MIN(salary) AS min_salary
FROM employees;

--        AVG(): Calculates the average value.
SELECT AVG(salary) AS avg_salary
FROM employees;

--    Window Functions:
--        ROW_NUMBER(): Assigns a unique integer to each row within a partition.
SELECT employee_id, employee_name, department_id,
       ROW_NUMBER() OVER (ORDER BY employee_id) AS row_num
FROM employees;

--        RANK(): Assigns a rank to each row within a partition, with gaps.
SELECT employee_id, employee_name, department_id,
       RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
FROM employees;

--        DENSE_RANK(): Assigns a rank to each row within a partition, without gaps.
SELECT employee_id, employee_name, department_id,
       DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_dense_rank
FROM employees;

--        LEAD(): Accesses data from a subsequent row within the same result set.
SELECT employee_id, employee_name, department_id,
       LEAD(employee_name, 1) OVER (ORDER BY employee_id) AS next_employee
FROM employees;

--        LAG(): Accesses data from a previous row within the same result set.
SELECT employee_id, employee_name, department_id,
       LAG(employee_name, 1) OVER (ORDER BY employee_id) AS prev_employee
FROM employees;

--       SUM() OVER(): Computes a sum across a set of rows.
SELECT employee_id, employee_name, department_id, salary,
       SUM(salary) OVER (PARTITION BY department_id) AS dept_total_salary
FROM employees;


--    CASE: Evaluates a set of conditions and returns a result.
SELECT employee_id, employee_name, salary,
       CASE 
           WHEN salary > 50000 THEN 'High Salary'
           WHEN salary > 30000 THEN 'Medium Salary'
           ELSE 'Low Salary'
       END AS salary_category
FROM employees;

--    LIKE: Searches for a specified pattern in a column.
SELECT employee_name
FROM employees
WHERE employee_name LIKE 'J%';

--    Subqueries: Queries nested within another SQL query.
SELECT employee_id, employee_name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name = 'Sales'
);

--    CTE (Common Table Expression): Defines a temporary named result set that you can reference within a SELECT, INSERT, UPDATE, or DELETE statement.
WITH high_salary_employees AS (
    SELECT employee_id, employee_name, salary
    FROM employees
    WHERE salary > 50000
)
SELECT * FROM high_salary_employees;

--    Temp Tables: Temporary tables that exist only for the duration of a session or transaction.
CREATE TEMPORARY TABLE temp_high_salary_employees AS (
    SELECT employee_id, employee_name, salary
    FROM employees
    WHERE salary > 50000
);

SELECT * FROM temp_high_salary_employees;

--    Methods to Optimize SQL Queries:
--        Proper indexing of tables.
CREATE INDEX idx_employee_department_id ON employees(department_id);

--        Writing efficient queries (using appropriate joins, avoiding unnecessary subqueries).
SELECT e.employee_id, e.employee_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
WHERE d.department_name = 'Sales';

--        Using EXPLAIN ANALYZE to analyze query performance.
EXPLAIN ANALYZE
SELECT * FROM employees
WHERE department_id = 5;


--        Limiting data retrieval to necessary columns and rows.
SELECT employee_name
FROM employees
WHERE department_id = 5
LIMIT 10;

--        Avoiding using functions on indexed columns in WHERE clauses.
-- Assuming 'name' column is indexed
SELECT * FROM users
WHERE LOWER(name) = 'john';

--        Optimizing database schema design.
-- Assuming 'name' column is indexed
SELECT * FROM users
WHERE name = 'John';  -- Assuming case-insensitive search is not required

--These concepts and functions cover a wide range of SQL capabilities in PostgreSQL and are essential for querying and manipulating data effectively in databases.





