--1.

WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
)
SELECT 
    r.Region,
    d.Distributor,
    COALESCE(s.Sales, 0) AS Sales
FROM Regions r
CROSS JOIN Distributors d
LEFT JOIN #RegionSales s
    ON s.Region = r.Region AND s.Distributor = d.Distributor
ORDER BY r.Region, d.Distributor;

--2.
SELECT 
    m.name
FROM Employee m
JOIN Employee e
    ON e.managerId = m.id
GROUP BY m.id, m.name
HAVING COUNT(e.id) >= 5;

--3.
SELECT 
    p.product_name,
    SUM(o.unit) AS unit
FROM Products p
JOIN Orders o 
    ON p.product_id = o.product_id
WHERE 
    o.order_date >= '2020-02-01'
    AND o.order_date < '2020-03-01'
GROUP BY 
    p.product_name
HAVING 
    SUM(o.unit) >= 100;

--4.
WITH VendorCount AS (
    SELECT 
        CustomerID,
        Vendor,
        COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY CustomerID, Vendor
),
Ranked AS (
    SELECT 
        CustomerID,
        Vendor,
        OrderCount,
        ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderCount DESC) AS rn
    FROM VendorCount
)
SELECT 
    CustomerID,
    Vendor
FROM Ranked
WHERE rn = 1;

--5.
DECLARE @Check_Prime INT = 91;
-- Your WHILE-based SQL logic here

DECLARE @Check_Prime INT = 91;  
DECLARE @i INT = 2;
DECLARE @isPrime BIT = 1; 


IF @Check_Prime <= 1
    SET @isPrime = 0;
ELSE
BEGIN
    WHILE @i <= SQRT(@Check_Prime)
    BEGIN
        IF @Check_Prime % @i = 0
        BEGIN
            SET @isPrime = 0;
            BREAK;
        END
        SET @i += 1;
    END
END

IF @isPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';
--6.
WITH SignalSummary AS (
    SELECT 
        Device_id,
        Locations,
        COUNT(*) AS signal_count
    FROM Device
    GROUP BY Device_id, Locations
),
DeviceStats AS (
    SELECT 
        Device_id,
        COUNT(DISTINCT Locations) AS no_of_location,
        SUM(signal_count) AS no_of_signals
    FROM SignalSummary
    GROUP BY Device_id
),
RankedSignals AS (
    SELECT 
        Device_id,
        Locations,
        signal_count,
        ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY signal_count DESC) AS rn
    FROM SignalSummary
)
SELECT 
    d.Device_id,
    d.no_of_location,
    r.Locations AS max_signal_location,
    d.no_of_signals
FROM DeviceStats d
JOIN RankedSignals r 
    ON d.Device_id = r.Device_id AND r.rn = 1;
--7.
SELECT 
    e.EmpID,
    e.EmpName,
    e.Salary
FROM Employee e
JOIN (
    SELECT 
        DeptID,
        AVG(Salary) AS AvgSalary
    FROM Employee
    GROUP BY DeptID
) d
    ON e.DeptID = d.DeptID
WHERE e.Salary > d.AvgSalary;

--8.

--9.


--10.


WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL SELECT n + 1 FROM Numbers WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT 
    g.Product,
    1 AS Quantity
FROM Grouped g
JOIN Numbers n 
    ON n.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 0);
