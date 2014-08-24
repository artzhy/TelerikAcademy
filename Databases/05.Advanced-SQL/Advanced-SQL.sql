--NOTE: You can execute each query individually by selecting the query and pressing F5

-- 1. Write a SQL query to find the names and salaries of the employees that take the minimal salary in the company.
SELECT FirstName, LastName, Salary FROM Employees
WHERE Salary = (SELECT MIN(Salary) FROM Employees)

-- 2. Write a SQL query to find the names and salaries of the employees that have a salary that is up to 10% higher than the minimal salary for the company.
SELECT FirstName, LastName, Salary FROM Employees
WHERE Salary <= 1.1 * (SELECT MIN(Salary) FROM Employees)

-- 3. Write a SQL query to find the full name, salary and department of the employees that take the minimal salary in their department.
SELECT FirstName, LastName, d.Name AS Department, Salary
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE Salary = 
  (SELECT MIN(Salary) FROM Employees 
   WHERE DepartmentID = e.DepartmentID)
ORDER BY Name

-- 4. Write a SQL query to find the average salary in the department #1.
SELECT d.DepartmentID, d.Name AS Department, ROUND(AVG(e.Salary), 2) AS [Avg. Salary] 
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE e.DepartmentID = 1
GROUP BY d.DepartmentID, d.Name

-- 5. Write a SQL query to find the average salary in the "Sales" department.
SELECT d.Name AS Department, ROUND(AVG(e.Salary), 2) AS [Avg. Salary] 
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
GROUP BY d.Name


-- 6. Write a SQL query to find the number of employees in the "Sales" department.
SELECT d.Name, Count(*) AS [Number of Employees] FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
GROUP BY d.Name

-- second variant:
SELECT COUNT(*) AS [Number of Employees] FROM Employees
WHERE DepartmentId = (SELECT DepartmentID FROM Departments WHERE Name = 'Sales')

-- 7. Write a SQL query to find the number of all employees that have manager.
SELECT COUNT(*) AS [Employees that have manager] 
FROM Employees
WHERE ManagerID IS NOT NULL

-- or
SELECT COUNT(ManagerID) AS [Employees that have manager] FROM Employees

-- 8. Write a SQL query to find the number of all employees that have no manager.
SELECT COUNT(*) AS [6ef4eta] FROM Employees WHERE ManagerID IS NULL

-- 9. Write a SQL query to find all departments and the average salary for each of them.
SELECT d.Name, ROUND(AVG(e.Salary),2) AS [Avg. Salary]
FROM Employees e
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name
ORDER BY [Avg. Salary] DESC

-- 10. Write a SQL query to find the count of all employees in each department and for each town.

-- First query (employees in each department)
SELECT d.Name AS Department, COUNT(e.EmployeeId) AS [Employee Count]
FROM Employees e 
JOIN Departments d ON e.DepartmentID = d.DepartmentID
GROUP BY d.Name

-- Second query (employees in each town)
SELECT t.Name AS Town, COUNT(e.EmployeeId) AS [Employee Count]
FROM Employees e 
JOIN Addresses a ON e.AddressID = a.AddressID
JOIN Towns t ON a.TownID = t.TownID
GROUP BY t.Name

-- 11. Write a SQL query to find all managers that have exactly 5 employees. Display their first name and last name.
SELECT m.FirstName, m.LastName
FROM Employees m
JOIN Employees e ON e.ManagerID = m.EmployeeID
GROUP BY m.FirstName, m.LastName
HAVING Count(*) = 5

-- second variant:
SELECT e.FirstName, e.LastName FROM Employees e
WHERE 5 = (SELECT COUNT(*) FROM Employees WHERE ManagerID = e.EmployeeID)

-- 12. Write a SQL query to find all employees along with their managers. For employees that do not have manager display the value "(no manager)".
SELECT 
  e.FirstName + ' ' + e.LastName AS [Employee],
  ISNULL(m.FirstName + ' ' + m.LastName, '(no manager)') AS [Manager]
FROM Employees e
LEFT JOIN Employees m ON e.ManagerID = m.EmployeeID

-- second variant:
SELECT 
  e.LastName as [Employee],
  CASE WHEN e.ManagerId IS NULL THEN '(no manager)' ELSE m.LastName END AS [Manager]
FROM Employees e
LEFT JOIN Employees m ON e.ManagerId = m.EmployeeId

-- 13. Write a SQL query to find the names of all employees whose last name is exactly 5 characters long. Use the built-in LEN(str) function.
SELECT LastName FROM Employees
WHERE LEN(LastName) = 5

--Write a SQL query to display the current date and time in the following format "day.month.year hour:minutes:seconds:milliseconds". Search in Google to find how to format dates in SQL Server.
--Write a SQL statement to create a table Users. Users should have username, password, full name and last login time. Choose appropriate data types for the table fields. Define a primary key column with a primary key constraint. Define the primary key column as identity to facilitate inserting records. Define unique constraint to avoid repeating usernames. Define a check constraint to ensure the password is at least 5 characters long.
--Write a SQL statement to create a view that displays the users from the Users table that have been in the system today. Test if the view works correctly.
--Write a SQL statement to create a table Groups. Groups should have unique name (use unique constraint). Define primary key and identity column.
--Write a SQL statement to add a column GroupID to the table Users. Fill some data in this new column and as well in the Groups table. Write a SQL statement to add a foreign key constraint between tables Users and Groups tables.
--Write SQL statements to insert several records in the Users and Groups tables.
--Write SQL statements to update some of the records in the Users and Groups tables.
--Write SQL statements to delete some of the records from the Users and Groups tables.
--Write SQL statements to insert in the Users table the names of all employees from the Employees table. Combine the first and last names as a full name. For username use the first letter of the first name + the last name (in lowercase). Use the same for the password, and NULL for last login time.
--Write a SQL statement that changes the password to NULL for all users that have not been in the system since 10.03.2010.
--Write a SQL statement that deletes all users without passwords (NULL password).
--Write a SQL query to display the average employee salary by department and job title.
--Write a SQL query to display the minimal employee salary by department and job title along with the name of some of the employees that take it.
--Write a SQL query to display the town where maximal number of employees work.
--Write a SQL query to display the number of managers from each town.
--Write a SQL to create table WorkHours to store work reports for each employee (employee id, date, task, hours, comments). Don't forget to define identity, primary key and appropriate foreign key. Issue few SQL statements to insert, update and delete of some data in the table. Define a table WorkHoursLogs to track all changes in the WorkHours table with triggers. For each change keep the old record data, the new record data and the command (insert / update / delete).
--Start a database transaction, delete all employees from the 'Sales' department along with all dependent records from the pother tables. At the end rollback the transaction.
--Start a database transaction and drop the table EmployeesProjects. Now how you could restore back the lost table data?
--Find how to use temporary tables in SQL Server. Using temporary tables backup all records from EmployeesProjects and restore them back after dropping and re-creating the table.