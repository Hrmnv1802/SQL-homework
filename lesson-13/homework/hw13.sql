--1
SELECT CAST(EMPLOYEE_ID AS VARCHAR) + '-' + FIRST_NAME + ' ' + LAST_NAME AS EmployeeInfo
FROM Employees;
--2
UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999');
--3
SELECT FIRST_NAME AS FirstName,
       LEN(FIRST_NAME) AS NameLength
FROM Employees
WHERE FIRST_NAME LIKE 'A%' OR FIRST_NAME LIKE 'J%' OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;
--4
SELECT MANAGER_ID,
       SUM(SALARY) AS TotalSalary
FROM Employees
GROUP BY MANAGER_ID;
--5
CREATE TABLE TestMax (
    Year INT,
    Max1 INT,
    Max2 INT,
    Max3 INT
);

INSERT INTO TestMax VALUES
(2020, 10, 25, 15),
(2021, 50, 40, 60),
(2022, 20, 35, 30);

SELECT Year,
       (SELECT MAX(v) FROM (VALUES (Max1), (Max2), (Max3)) AS x(v)) AS Highest
FROM TestMax;
--6
CREATE TABLE cinema (
    id INT,
    movie VARCHAR(50),
    description VARCHAR(50)
);

INSERT INTO cinema VALUES
(1, 'Inception', 'thrilling'),
(2, 'Frozen', 'boring'),
(3, 'Avatar', 'epic'),
(4, 'Cars', 'boring'),
(5, 'Matrix', 'amazing');

SELECT *
FROM cinema
WHERE id % 2 = 1 AND description <> 'boring';
--7
CREATE TABLE SingleOrder (id INT, product VARCHAR(50));

INSERT INTO SingleOrder VALUES (2, 'Phone'), (0, 'TV'), (1, 'Tablet');

SELECT * FROM SingleOrder
ORDER BY CASE WHEN id = 0 THEN 1 ELSE 0 END, id;
--8
CREATE TABLE person (col1 VARCHAR(10), col2 VARCHAR(10), col3 VARCHAR(10));

INSERT INTO person VALUES 
(NULL, 'James', 'Lee'),
('Tom', NULL, 'Green'),
(NULL, NULL, NULL);

SELECT COALESCE(col1, col2, col3) AS FirstNonNull
FROM person;
--9
CREATE TABLE Students (FullName VARCHAR(100));

INSERT INTO Students VALUES ('John Michael Smith'), ('Anna Maria Jones');

SELECT 
  PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
  PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
  PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Students;
--10
CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT,
    State VARCHAR(50)
);

INSERT INTO Orders VALUES
(1, 101, 'California'),
(2, 101, 'Texas'),
(3, 102, 'Nevada'),
(4, 103, 'California'),
(5, 103, 'Texas');

SELECT *
FROM Orders
WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE State='California')
  AND State='Texas';
--11
CREATE TABLE DMLTable (group_id INT, value_column VARCHAR(20));

INSERT INTO DMLTable VALUES (1, 'A'), (1, 'B'), (2, 'C'), (2, 'D');

SELECT group_id,
       STRING_AGG(value_column, ', ') AS ConcatenatedValues
FROM DMLTable
GROUP BY group_id;
--12
SELECT FIRST_NAME, LAST_NAME
FROM Employees
WHERE LEN(LOWER(FIRST_NAME + LAST_NAME)) -
      LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a', '')) >= 3;
--13
SELECT DEPARTMENT_ID,
       COUNT(*) AS TotalEmployees,
       100.0 * SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(*) AS PercentOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;
--14
CREATE TABLE Students (student_id INT, score INT);
INSERT INTO Students VALUES (1, 50), (2, 70), (3, 30);

SELECT student_id,
       score,
       SUM(score) OVER (ORDER BY student_id) AS CumulativeScore
FROM Students;
--15
CREATE TABLE Student (student_id INT, student_name VARCHAR(50), birthdate DATE);

INSERT INTO Student VALUES
(1, 'Alice', '2001-03-05'),
(2, 'Bob', '2001-03-05'),
(3, 'Charlie', '2002-01-10');

SELECT s1.student_id, s1.student_name, s1.birthdate
FROM Student s1
JOIN Student s2
  ON s1.birthdate = s2.birthdate
 AND s1.student_id <> s2.student_id;
--16
CREATE TABLE PlayerScores (PlayerA VARCHAR(20), PlayerB VARCHAR(20), score INT);

INSERT INTO PlayerScores VALUES
('Alice', 'Bob', 10),
('Bob', 'Alice', 15),
('Alice', 'Charlie', 5);

SELECT 
  CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END AS Player1,
  CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END AS Player2,
  SUM(score) AS TotalScore
FROM PlayerScores
GROUP BY CASE WHEN PlayerA < PlayerB THEN PlayerA ELSE PlayerB END,
         CASE WHEN PlayerA < PlayerB THEN PlayerB ELSE PlayerA END;
--17
WITH Split AS (
  SELECT value AS ch FROM STRING_SPLIT('tf56sd#%OqH', '')
)
SELECT 
  STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch END, '') AS Uppercase,
  STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch END, '') AS Lowercase,
  STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch END, '') AS Numbers,
  STRING_AGG(CASE WHEN ch NOT LIKE '[A-Za-z0-9]' THEN ch END, '') AS Others
FROM Split;
