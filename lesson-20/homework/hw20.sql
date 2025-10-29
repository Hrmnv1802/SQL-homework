--1.
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s2.CustomerName = s1.CustomerName
      AND MONTH(s2.SaleDate) = 3
      AND YEAR(s2.SaleDate) = 2024
);

--2.
SELECT TOP 1 Product, SUM(Quantity * Price) AS TotalRevenue
FROM #Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

--3.
SELECT MAX(Total) AS SecondHighestSale
FROM (
    SELECT DISTINCT Quantity * Price AS Total
    FROM #Sales
) AS t
WHERE Total < (
    SELECT MAX(Quantity * Price) FROM #Sales
);

--4.
SELECT 
    DATENAME(MONTH, SaleDate) AS MonthName,
    (SELECT SUM(s2.Quantity) 
     FROM #Sales s2 
     WHERE MONTH(s2.SaleDate) = MONTH(s1.SaleDate)
       AND YEAR(s2.SaleDate) = YEAR(s1.SaleDate)) AS TotalQuantity
FROM #Sales s1
GROUP BY DATENAME(MONTH, SaleDate), MONTH(SaleDate)
ORDER BY MONTH(SaleDate);

--5.
SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.CustomerName <> s2.CustomerName
      AND s1.Product = s2.Product
);

--6.
SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;

--7.
WITH Relations AS (
    SELECT ParentID AS PID, ChildID AS CHID
    FROM Family
    UNION ALL
    SELECT f.ParentID, r.CHID
    FROM Family f
    JOIN Relations r ON f.ChildID = r.PID
)
SELECT DISTINCT PID, CHID
FROM Relations
ORDER BY PID, CHID;

--8.
SELECT o.*
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders c
      WHERE c.CustomerID = o.CustomerID
        AND c.DeliveryState = 'CA'
  );

--9.
UPDATE #residents
SET fullname = SUBSTRING(address, CHARINDEX('name=', address) + 5, CHARINDEX(' ', address + ' ', CHARINDEX('name=', address)) - CHARINDEX('name=', address) - 5)
WHERE fullname IS NULL
   OR fullname = ''
   OR fullname NOT IN (SELECT SUBSTRING(address, CHARINDEX('name=', address) + 5, CHARINDEX(' ', address + ' ', CHARINDEX('name=', address)) - CHARINDEX('name=', address) - 5)
                       FROM #residents
                       WHERE CHARINDEX('name=', address) > 0);

--10.
WITH Paths AS (
    SELECT 
        RouteID,
        DepartureCity,
        ArrivalCity,
        CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(200)) AS Route,
        Cost
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'

    UNION ALL

    SELECT 
        r.RouteID,
        p.DepartureCity,
        r.ArrivalCity,
        CAST(p.Route + ' - ' + r.ArrivalCity AS VARCHAR(200)),
        p.Cost + r.Cost
    FROM Paths p
    JOIN #Routes r ON p.ArrivalCity = r.DepartureCity
)
SELECT Route, Cost
FROM Paths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost;

--11.
SELECT *,
       ROW_NUMBER() OVER (ORDER BY ID) AS RankOrder
FROM #RankingPuzzle;

--12.
SELECT e.*
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(SalesAmount)
    FROM #EmployeeSales
    WHERE Department = e.Department
);

--13.
SELECT e.*
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales s
    WHERE s.SalesMonth = e.SalesMonth
      AND s.SalesYear = e.SalesYear
    GROUP BY s.SalesMonth, s.SalesYear
    HAVING e.SalesAmount = MAX(s.SalesAmount)
);

--14.
SELECT DISTINCT e1.EmployeeName
FROM #EmployeeSales e1
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth
    FROM #EmployeeSales
    WHERE SalesMonth NOT IN (
        SELECT SalesMonth FROM #EmployeeSales e2 WHERE e2.EmployeeName = e1.EmployeeName
    )
);

--15.
SELECT Name, Price
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);

--16.
SELECT Name, Stock
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);

--17.
SELECT Name
FROM Products
WHERE Category = (
    SELECT Category FROM Products WHERE Name = 'Laptop'
);

--18.
SELECT Name, Price
FROM Products
WHERE Price > (
    SELECT MIN(Price) FROM Products WHERE Category = 'Electronics'
);

--19.
SELECT p1.Name, p1.Category, p1.Price
FROM Products p1
WHERE p1.Price > (
    SELECT AVG(p2.Price)
    FROM Products p2
    WHERE p2.Category = p1.Category
);

--20.
SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;

--21.
SELECT p.Name, SUM(o.Quantity) AS TotalQty
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (
    SELECT AVG(q.TotalQ)
    FROM (
        SELECT SUM(Quantity) AS TotalQ
        FROM Orders
        GROUP BY ProductID
    ) q
);


--22.
SELECT Name
FROM Products p
WHERE NOT EXISTS (
    SELECT 1 FROM Orders o WHERE o.ProductID = p.ProductID
);

--23.
SELECT TOP 1 p.Name, SUM(o.Quantity) AS TotalQty
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
ORDER BY TotalQty DESC;

