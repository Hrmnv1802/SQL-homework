--1.
SELECT MIN(Price) AS MinPrice
FROM Products;

--2.
SELECT MAX(Salary) AS MaxSalary
FROM Employees;

--3.
SELECT COUNT(*) AS TotalCustomers
FROM Customers;

--4.
SELECT COUNT(DISTINCT Category) AS UniqueCategories
FROM Products;

--5.
SELECT SUM(SaleAmount) AS TotalSalesAmount
FROM Sales
WHERE ProductID = 7;

--6.
SELECT AVG(Age) AS AverageAge
FROM Employees;

--7.
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

--8.
SELECT Category, 
       MIN(Price) AS MinPrice, 
       MAX(Price) AS MaxPrice
FROM Products
GROUP BY Category;

--9.
SELECT CustomerID, 
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID;

--10.
SELECT DepartmentName, COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName
HAVING COUNT(*) > 5;

--11.
SELECT p.Category,
       SUM(s.SaleAmount) AS TotalSales,
       AVG(s.SaleAmount) AS AvgSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.Category;

--12.
SELECT COUNT(*) AS HREmployeeCount
FROM Employees
WHERE DepartmentName = 'HR';

--13.
SELECT DepartmentName,
       MAX(Salary) AS MaxSalary,
       MIN(Salary) AS MinSalary
FROM Employees
GROUP BY DepartmentName;

--14.
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName;

--15.
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary,
       COUNT(*) AS EmployeeCount
FROM Employees
GROUP BY DepartmentName;

--16.
SELECT Category,
       AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 400;

--17.
SELECT YEAR(SaleDate) AS SaleYear,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY YEAR(SaleDate)
ORDER BY SaleYear;

--18.
SELECT CustomerID
FROM Orders
GROUP BY CustomerID
HAVING COUNT(*) >= 3;

--19.
SELECT DepartmentName,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 60000;

--20.
SELECT Category,
       AVG(Price) AS AvgPrice
FROM Products
GROUP BY Category
HAVING AVG(Price) > 150;

--21.
SELECT CustomerID,
       SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY CustomerID
HAVING SUM(SaleAmount) > 1500;

--22.
SELECT DepartmentName,
       SUM(Salary) AS TotalSalary,
       AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentName
HAVING AVG(Salary) > 65000;

--23.
SELECT CustomerID,
       SUM(Freight) AS TotalFreightOver50,
       MIN(Freight) AS LeastPurchase
FROM Sales.Orders
WHERE Freight > 50
GROUP BY CustomerID;

--24.
SELECT YEAR(o.OrderDate) AS SaleYear,
       MONTH(o.OrderDate) AS SaleMonth,
       SUM(s.SaleAmount) AS TotalSales,
       COUNT(DISTINCT s.ProductID) AS UniqueProducts
FROM Orders o
JOIN Sales s ON o.OrderID = s.OrderID
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
HAVING COUNT(DISTINCT s.ProductID) >= 2
ORDER BY SaleYear, SaleMonth;

--25.
SELECT YEAR(OrderDate) AS OrderYear,
       MIN(Quantity) AS MinQuantity,
       MAX(Quantity) AS MaxQuantity
FROM Orders
GROUP BY YEAR(OrderDate)
ORDER BY OrderYear;
