------------------------------------------------------------
-- BASIC + INTERMEDIATE + ADVANCED SQL TASKS (1–25)
-- SQL Server Compatible
------------------------------------------------------------

-- 1. Create Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);

-- 2. Insert records (single-row + multi-row)
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Alice', 6000);

INSERT INTO Employees (EmpID, Name, Salary)
VALUES (2, 'Bob', 5500), (3, 'Charlie', 4800);

-- 3. Update salary where EmpID = 1
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

-- 4. Delete record where EmpID = 2
DELETE FROM Employees
WHERE EmpID = 2;

-- 5. Difference between DELETE, TRUNCATE, DROP:
-- DELETE removes rows (can use WHERE)
-- TRUNCATE removes all rows (faster, no WHERE)
-- DROP removes the table completely

-- 6. Modify Name column to VARCHAR(100)
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);

-- 7. Add Department column
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 8. Change data type of Salary to FLOAT
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- 9. Create Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(50)
);

-- 10. Remove all records from Employees but keep structure
TRUNCATE TABLE Employees;

------------------------------------------------------------
-- INTERMEDIATE LEVEL TASKS
------------------------------------------------------------

-- 11. Insert 5 records into Departments using INSERT INTO SELECT
INSERT INTO Departments (DepartmentID, DepartmentName)
SELECT 1, 'Finance' UNION ALL
SELECT 2, 'HR' UNION ALL
SELECT 3, 'IT' UNION ALL
SELECT 4, 'Sales' UNION ALL
SELECT 5, 'Management';

-- 12. Update Department to 'Management' where Salary > 5000
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- 13. Remove all employees but keep table
TRUNCATE TABLE Employees;

-- 14. Drop Department column
ALTER TABLE Employees
DROP COLUMN Department;

-- 15. Rename Employees to StaffMembers
EXEC sp_rename 'Employees', 'StaffMembers';

-- 16. Drop Departments table
DROP TABLE Departments;

------------------------------------------------------------
-- ADVANCED LEVEL TASKS
------------------------------------------------------------

-- 17. Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Description VARCHAR(100)
);

-- 18. Add CHECK constraint (Price > 0)
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);

-- 19. Add StockQuantity with DEFAULT 50
ALTER TABLE Products
ADD StockQuantity INT DEFAULT 50;

-- 20. Rename Category to ProductCategory
EXEC sp_rename 'Products.Category', 'ProductCategory', 'COLUMN';

-- 21. Insert 5 records into Products
INSERT INTO Products (ProductID, ProductName, ProductCategory, Price, Description)
VALUES
(1, 'Laptop', 'Electronics', 1200.00, 'Gaming laptop'),
(2, 'Phone', 'Electronics', 800.00, 'Smartphone'),
(3, 'Desk', 'Furniture', 250.00, 'Wooden desk'),
(4, 'Chair', 'Furniture', 120.00, 'Office chair'),
(5, 'Pen', 'Stationery', 2.50, 'Blue ink pen');

-- 22. Create backup table using SELECT INTO
SELECT * INTO Products_Backup FROM Products;

-- 23. Rename Products to Inventory
EXEC sp_rename 'Products', 'Inventory';

-- 24. Change data type of Price to FLOAT
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

-- 25. Add IDENTITY column ProductCode (start 1000, increment 5)
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);
