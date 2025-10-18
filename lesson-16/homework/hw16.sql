--1.
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n + 1 FROM Numbers WHERE n < 1000
)
SELECT n
INTO #Numbers1to1000
FROM Numbers
OPTION (MAXRECURSION 1000);

SELECT * FROM #Numbers1to1000;

--2.
SELECT e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalSales DESC;

--3.
with cte as
(
select avg(salary) as Avgsalary
from Employees)
select * from Employees

--4.
SELECT p.ProductID, p.ProductName, s.MaxSale
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) s ON p.ProductID = s.ProductID
ORDER BY s.MaxSale DESC;

--5.
WITH Doubles AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2 FROM Doubles WHERE num * 2 < 1000000
)
SELECT * FROM Doubles;

--6.
WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
)
SELECT e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees e
JOIN SalesCount s ON e.EmployeeID = s.EmployeeID
WHERE s.TotalSales > 5
ORDER BY s.TotalSales DESC;

--7.
WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales
FROM Products p
JOIN ProductSales ps ON p.ProductID = ps.ProductID
WHERE ps.TotalSales > 500
ORDER BY ps.TotalSales DESC;

--8.
WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal FROM Employees
)
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Salary
FROM Employees e, AvgSalary a
WHERE e.Salary > a.AvgSal
ORDER BY e.Salary DESC;

--9.
SELECT TOP 5 
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    s.OrderCount
FROM Employees e
JOIN (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
ORDER BY s.OrderCount DESC;

--10.
SELECT p.CategoryID, SUM(s.SalesAmount) AS TotalSales
FROM Sales s
JOIN (
    SELECT ProductID, CategoryID
    FROM Products
) p ON s.ProductID = p.ProductID
GROUP BY p.CategoryID
ORDER BY TotalSales DESC;

--11.
select * from Numbers1
WITH Factorial AS (
    SELECT Number AS n, 1 AS i, 1 AS fact
    FROM Numbers1
    WHERE Number IS NOT NULL

    UNION ALL

    SELECT f.n, f.i + 1, f.fact * (f.i + 1)
    FROM Factorial f
    WHERE f.i + 1 <= f.n
)
SELECT n AS Number, MAX(fact) AS Factorial
FROM Factorial
GROUP BY n
ORDER BY n;

--12.
WITH SplitString AS (
    SELECT 
        Id,
        LEFT(String, 1) AS Character,
        SUBSTRING(String, 2, LEN(String)) AS Remaining
    FROM Example

    UNION ALL

    SELECT 
        Id,
        LEFT(Remaining, 1),
        SUBSTRING(Remaining, 2, LEN(Remaining))
    FROM SplitString
    WHERE LEN(Remaining) > 0
)
SELECT Id, Character
FROM SplitString
WHERE Character <> ''
ORDER BY Id;

--13.
WITH MonthlySales AS (
    SELECT 
        YEAR(SaleDate) AS Yr,
        MONTH(SaleDate) AS Mn,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
),
SalesDiff AS (
    SELECT 
        Yr,
        Mn,
        TotalSales,
        TotalSales - LAG(TotalSales) OVER (ORDER BY Yr, Mn) AS DiffFromPrevMonth
    FROM MonthlySales
)
SELECT * FROM SalesDiff
ORDER BY Yr, Mn;


--14.
SELECT e.EmployeeID, e.FirstName, e.LastName, s.Quarter, s.TotalSales
FROM Employees e
JOIN (
    SELECT 
        EmployeeID,
        DATEPART(QUARTER, SaleDate) AS Quarter,
        SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
    HAVING SUM(SalesAmount) > 45000
) s ON e.EmployeeID = s.EmployeeID
ORDER BY s.Quarter, s.TotalSales DESC;

--15.
WITH Fibonacci AS (
    SELECT 1 AS n, 0 AS a, 1 AS b
    UNION ALL
    SELECT n + 1, b, a + b
    FROM Fibonacci
    WHERE n < 20 
)
SELECT n, a AS FibonacciNumber
FROM Fibonacci
OPTION (MAXRECURSION 100);

--16.
SELECT *
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND Vals NOT LIKE '%[^' + LEFT(Vals, 1) + ']%';

--17.
DECLARE @n INT = 5;

WITH Numbers AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(20)) AS sequence
    UNION ALL
    SELECT num + 1, sequence + CAST(num + 1 AS VARCHAR(10))
    FROM Numbers
    WHERE num + 1 <= @n
)
SELECT * FROM Numbers;


--18.
SELECT e.EmployeeID, e.FirstName, e.LastName, s.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    WHERE SaleDate >= DATEADD(MONTH, -6, GETDATE())
    GROUP BY EmployeeID
) s ON e.EmployeeID = s.EmployeeID
ORDER BY s.TotalSales DESC;

--19.
SELECT 
    PawanName,
    Pawan_slug_name,
    LEFT(Pawan_slug_name, CHARINDEX('-', Pawan_slug_name + '-') - 1) AS Cleaned_Name
FROM RemoveDuplicateIntsFromNames;
