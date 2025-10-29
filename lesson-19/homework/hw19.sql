--1.
CREATE OR ALTER PROCEDURE GetEmployeeBonus
AS
BEGIN
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus db ON e.Department = db.Department;

    SELECT * FROM #EmployeeBonus;
END;
GO


EXEC GetEmployeeBonus;


--2.
CREATE OR ALTER PROCEDURE UpdateDepartmentSalary
    @Department NVARCHAR(50),
    @IncreasePercentage DECIMAL(5,2)
AS
BEGIN
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercentage / 100)
    WHERE Department = @Department;

    SELECT * FROM Employees WHERE Department = @Department;
END;
GO


EXEC UpdateDepartmentSalary 'Sales', 4;

--3.
MERGE INTO Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

WHEN MATCHED THEN
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

WHEN NOT MATCHED BY SOURCE THEN
    DELETE;


SELECT * FROM Products_Current;

--4.
SELECT 
    t1.id,
    CASE
        WHEN t1.p_id IS NULL THEN 'Root'
        WHEN t1.id NOT IN (SELECT DISTINCT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree t1
ORDER BY t1.id;

--5.
SELECT 
    s.user_id,
    CAST(
        COALESCE(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END) * 1.0 
        / NULLIF(COUNT(c.action), 0), 0) 
        AS DECIMAL(3,2)
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;

--6.
SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary) FROM employees
);

--7.
CREATE OR ALTER PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
GO

EXEC GetProductSalesSummary @ProductID = 7;

