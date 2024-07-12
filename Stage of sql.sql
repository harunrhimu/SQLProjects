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

Understanding SQL commands in a chronological order helps in grasping how SQL has evolved and how to utilize various commands effectively. Below is a list of SQL commands organized to reflect a typical learning path from basic to advanced.

### Basic SQL Commands

1. **Data Query Language (DQL)**: Focused on retrieving data.
   - `SELECT`: Retrieves data from a database.
     ```sql
     SELECT * FROM employees;
     ```

2. **Data Definition Language (DDL)**: Defines and modifies database structure.
   - `CREATE TABLE`: Creates a new table.
     ```sql
     CREATE TABLE employees (
       id INT PRIMARY KEY,
       name VARCHAR(100),
       position VARCHAR(50)
     );
     ```
   - `ALTER TABLE`: Modifies an existing table structure.
     ```sql
     ALTER TABLE employees ADD COLUMN salary DECIMAL(10, 2);
     ```
   - `DROP TABLE`: Deletes a table.
     ```sql
     DROP TABLE employees;
     ```

3. **Data Manipulation Language (DML)**: Used for data manipulation.
   - `INSERT INTO`: Inserts new data into a table.
     ```sql
     INSERT INTO employees (id, name, position) VALUES (1, 'John Doe', 'Manager');
     ```
   - `UPDATE`: Updates existing data within a table.
     ```sql
     UPDATE employees SET salary = 50000 WHERE id = 1;
     ```
   - `DELETE`: Deletes data from a table.
     ```sql
     DELETE FROM employees WHERE id = 1;
     ```

4. **Data Control Language (DCL)**: Manages permissions.
   - `GRANT`: Gives a user access privileges to the database.
     ```sql
     GRANT SELECT ON employees TO user_name;
     ```
   - `REVOKE`: Takes back permissions from a user.
     ```sql
     REVOKE SELECT ON employees FROM user_name;
     ```

### Intermediate SQL Commands

5. **Join Operations**: Combines rows from two or more tables.
   - `INNER JOIN`: Selects records that have matching values in both tables.
     ```sql
     SELECT employees.name, departments.department_name
     FROM employees
     INNER JOIN departments ON employees.department_id = departments.id;
     ```
   - `LEFT JOIN`: Selects all records from the left table, and the matched records from the right table.
     ```sql
     SELECT employees.name, departments.department_name
     FROM employees
     LEFT JOIN departments ON employees.department_id = departments.id;
     ```
   - `RIGHT JOIN`: Selects all records from the right table, and the matched records from the left table.
     ```sql
     SELECT employees.name, departments.department_name
     FROM employees
     RIGHT JOIN departments ON employees.department_id = departments.id;
     ```
   - `FULL OUTER JOIN`: Selects all records when there is a match in either left or right table.
     ```sql
     SELECT employees.name, departments.department_name
     FROM employees
     FULL OUTER JOIN departments ON employees.department_id = departments.id;
     ```

6. **Set Operations**: Combines the results of two or more queries.
   - `UNION`: Combines the results of two queries and removes duplicates.
     ```sql
     SELECT name FROM employees
     UNION
     SELECT name FROM managers;
     ```
   - `UNION ALL`: Combines the results of two queries without removing duplicates.
     ```sql
     SELECT name FROM employees
     UNION ALL
     SELECT name FROM managers;
     ```

### Advanced SQL Commands

7. **Subqueries**: Nested queries used within a main query.
   - Scalar Subquery:
     ```sql
     SELECT name, (SELECT AVG(salary) FROM employees) AS avg_salary FROM employees;
     ```
   - Correlated Subquery:
     ```sql
     SELECT name, salary
     FROM employees e1
     WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e1.department_id = e2.department_id);
     ```

8. **Window Functions**: Perform calculations across a set of table rows.
   - `ROW_NUMBER()`: Assigns a unique number to each row within a partition.
     ```sql
     SELECT name, salary, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank
     FROM employees;
     ```
   - `RANK()`: Assigns a rank to each row within a partition.
     ```sql
     SELECT name, salary, RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank
     FROM employees;
     ```
   - `DENSE_RANK()`: Similar to `RANK()`, but without gaps in ranking values.
     ```sql
     SELECT name, salary, DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank
     FROM employees;
     ```
   - `NTILE()`: Divides rows into a specified number of approximately equal groups.
     ```sql
     SELECT name, salary, NTILE(4) OVER (ORDER BY salary DESC) AS quartile
     FROM employees;
     ```

9. **Common Table Expressions (CTE)**: Simplify complex queries by breaking them into simple sub-queries.
   - `WITH`: Defines a CTE.
     ```sql
     WITH SalesCTE AS (
       SELECT salesperson_id, SUM(sales_amount) AS total_sales
       FROM sales
       GROUP BY salesperson_id
     )
     SELECT * FROM SalesCTE WHERE total_sales > 10000;
     ```

10. **Stored Procedures and Functions**: Encapsulate logic within the database.
    - Stored Procedure:
      ```sql
      CREATE PROCEDURE GetEmployeeById(IN emp_id INT)
      BEGIN
        SELECT * FROM employees WHERE id = emp_id;
      END;
      ```
    - Function:
      ```sql
      CREATE FUNCTION GetEmployeeSalary(emp_id INT) RETURNS DECIMAL(10, 2)
      BEGIN
        DECLARE salary DECIMAL(10, 2);
        SELECT salary INTO salary FROM employees WHERE id = emp_id;
        RETURN salary;
      END;
      ```

### Advanced Optimization and Transaction Commands

11. **Transactions**: Ensure the integrity of the database.
    - `BEGIN TRANSACTION`: Starts a transaction.
      ```sql
      BEGIN TRANSACTION;
      ```
    - `COMMIT`: Saves the changes made in the transaction.
      ```sql
      COMMIT;
      ```
    - `ROLLBACK`: Undoes the changes made in the transaction.
      ```sql
      ROLLBACK;
      ```

12. **Indexing**: Improves the speed of data retrieval operations.
    - `CREATE INDEX`: Creates an index on a table.
      ```sql
      CREATE INDEX idx_employee_name ON employees(name);
      ```
    - `DROP INDEX`: Removes an index.
      ```sql
      DROP INDEX idx_employee_name;
      ```

By following this chronological order, you can build a strong foundation in SQL and progressively advance to more complex and powerful SQL commands.



