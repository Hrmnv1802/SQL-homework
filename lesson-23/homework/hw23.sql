--7
SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;

--8
SELECT AVG(UnitPrice) AS AvgUnitPrice
FROM Sales;

--9
SELECT COUNT(*) AS TotalTransactions
FROM Sales;

--10
SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;

--11
SELECT Category, SUM(QuantitySold) AS TotalUnitsSold
FROM Sales
GROUP BY Category;

--12
SELECT Region, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Region;
--13
SELECT TOP 1 
    Product, 
    SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;

--14
SELECT 
    SaleDate,
    SUM(QuantitySold * UnitPrice) AS DailyRevenue,
    SUM(SUM(QuantitySold * UnitPrice)) OVER (ORDER BY SaleDate) AS RunningTotal
FROM Sales
GROUP BY SaleDate
ORDER BY SaleDate;

--15
SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    ROUND(
        100.0 * SUM(QuantitySold * UnitPrice) / 
        SUM(SUM(QuantitySold * UnitPrice)) OVER (), 2
    ) AS PercentageOfTotal
FROM Sales
GROUP BY Category;
--17
SELECT 
    S.SaleID,
    S.Product,
    S.Category,
    S.QuantitySold,
    S.UnitPrice,
    S.SaleDate,
    S.Region,
    C.CustomerName
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID;

--18
SELECT C.CustomerName
FROM Customers C
LEFT JOIN Sales S ON C.CustomerID = S.CustomerID
WHERE S.CustomerID IS NULL;

--19
SELECT 
    C.CustomerName,
    SUM(S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Customers C
JOIN Sales S ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerName;

--20
SELECT TOP 1 
    C.CustomerName,
    SUM(S.QuantitySold * S.UnitPrice) AS TotalRevenue
FROM Customers C
JOIN Sales S ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerName
ORDER BY TotalRevenue DESC;
--21
SELECT 
    C.CustomerName,
    COUNT(S.SaleID) AS TotalSales
FROM Customers C
LEFT JOIN Sales S ON C.CustomerID = S.CustomerID
GROUP BY C.CustomerName;
--22
SELECT DISTINCT P.ProductName
FROM Products P
JOIN Sales S ON P.ProductName = S.Product;
--23
SELECT TOP 1 ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC;

--24
SELECT 
    ProductName,
    Category,
    SellingPrice
FROM Products P
WHERE SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products
    WHERE Category = P.Category
);

