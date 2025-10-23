--easy
--1
SELECT 
    LEFT(Name, CHARINDEX(',', Name) - 1) AS FirstName,
    LTRIM(RIGHT(Name, LEN(Name) - CHARINDEX(',', Name))) AS Surname
FROM TestMultipleColumns;
--2
SELECT *
FROM TestPercent
WHERE Vals LIKE '%[%]%';
--3
SELECT value AS SplitPart
FROM Splitter
CROSS APPLY STRING_SPLIT(Vals, '.');
--4
SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;
--5
SELECT 
    Vals,
    LEN(Vals) - LEN(REPLACE(Vals, ' ', '')) AS SpaceCount
FROM CountSpaces;
--6
SELECT e.EMPLOYEE_ID, e.FIRST_NAME, e.LAST_NAME, e.SALARY, m.SALARY AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.MANAGER_ID = m.EMPLOYEE_ID
WHERE e.SALARY > m.SALARY;
--7
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 11 AND 14;
--medium
--1
SELECT w1.id
FROM weather w1
JOIN weather w2 ON DATEDIFF(DAY, w2.recordDate, w1.recordDate) = 1
WHERE w1.temperature > w2.temperature;
--2
SELECT 
    player_id, 
    MIN(event_date) AS first_login
FROM Activity
GROUP BY player_id;
--3
WITH cte AS (
    SELECT value, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
    FROM fruits CROSS APPLY STRING_SPLIT(Vals, ',')
)
SELECT value AS third_item
FROM cte
WHERE rn = 3;
--4
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    CASE 
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 6 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 11 AND 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;
--5
SELECT 
    Vals,
    LEFT(Vals, PATINDEX('%[^0-9]%', Vals + 'x') - 1) AS IntegerPart
FROM GetIntegers;
--difficult
--1
SELECT 
    STRING_AGG(
        RIGHT(LEFT(value, 2), 1) + LEFT(LEFT(value, 2), 1) + SUBSTRING(value, 3, LEN(value)),
        ','
    ) AS SwappedVals
FROM MultipleVals
CROSS APPLY STRING_SPLIT(Vals, ',');
--2
DECLARE @str VARCHAR(100) = 'sdgfhsdgfhs@121313131';

WITH Numbers AS (
    SELECT TOP (LEN(@str)) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects
)
SELECT SUBSTRING(@str, n, 1) AS Character
FROM Numbers;
--3
WITH FirstLogin AS (
    SELECT 
        player_id,
        MIN(event_date) AS first_date
    FROM Activity
    GROUP BY player_id
)
SELECT a.player_id, a.device_id
FROM Activity a
JOIN FirstLogin f ON a.player_id = f.player_id AND a.event_date = f.first_date;
--4
DECLARE @str VARCHAR(100) = 'rtcfvty34redt';

SELECT
    LEFT(@str, PATINDEX('%[0-9]%', @str + 'x') - 1) AS Letters,
    SUBSTRING(@str, PATINDEX('%[0-9]%', @str), LEN(@str)) AS Digits;


