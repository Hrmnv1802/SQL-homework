
--1
/*BULK INSERT in SQL Server is a Transact-SQL (T-SQL) command used to import large volumes of data from an 
external file (like a .txt or .csv) directly into a SQL Server table.*/

--2
/*cvs, txt, xls, xml*/

--3
create table Products (ProductID INT primary key, ProductName varchar(50), Price DECIMAL(10,2))

--4
insert into Products ([ProductID], [ProductName], [Price])
Values
(1, 'Earphones', 10.2),
(2, 'Monitor', 25.5),
(3, 'Smartphone', 20.3)

select * from Products

--5
/* NULL means no value, unknown value, or missing data, NOT NULL means the column must always have a value.*/

--6
alter table Products ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName)

--7
/*Adding a UNIQUE constraint to ensure no two products have the same name*/

--8
alter table Products
ADD CategoryID INT



--9
create table Categories (CategoryID int primary key, CategoryName varchar(50) unique)
select * from Categories

--10
/*An IDENTITY column in SQL Server is used to automatically generate sequential numeric values for rows inserted into a table.*/

--11
select * from Products

bulk insert Products
from 'C:\Users\Jasur\OneDrive\Рабочий стол\text.txt'
with (
fieldterminator = ',',
rowterminator = '\n',
firstrow = 1
)

--12

ALTER TABLE Products
ADD CONSTRAINT FK_Products_Categories
FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID);

--13
/*1. PRIMARY KEY

Ensures uniqueness of values in the column(s).

Does not allow NULL values.

Only one PRIMARY KEY is allowed per table.

By default, creates a clustered index (unless specified otherwise).

👉 Typically used to uniquely identify each row (e.g., ProductID).

2. UNIQUE KEY

Also ensures uniqueness of values in the column(s).

Allows NULL values (and in SQL Server, multiple NULLs are allowed).

A table can have multiple UNIQUE constraints.

By default, creates a non-clustered index.*/

--14
ALTER TABLE Products
ADD CONSTRAINT CHK_Products_Price CHECK (Price > 0)

--15
ALTER TABLE Products
ADD Stock int NOT NULL DEFAULT 0

--16

SELECT 
    ProductID,
    ProductName,
    ISNULL(Price, 0) AS Price,
    CategoryID,
    Stock
FROM Products;

--17
/*A FOREIGN KEY is a constraint that creates a relationship between two tables.
It ensures that the value in one column (or set of columns) in a table must match an existing value in another table.*/


--18

CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Age INT NOT NULL,
    CONSTRAINT CHK_Customers_Age CHECK (Age >= 18)
);

--19

CREATE TABLE Orders (
    OrderID INT IDENTITY(100,10) PRIMARY KEY,
    OrderDate DATE NOT NULL,
    CustomerName NVARCHAR(100) NOT NULL
);

--20

CREATE TABLE OrderDetails (
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID)
);

--21
/*ISNULL in SQL Server

Purpose: Replaces NULL with a specified replacement value.
Example:

SELECT ISNULL(Price, 0) AS SafePrice
FROM Products;
 If Price is NULL, it will return 0.

Notes:

Accepts only two arguments.

The return type is the data type of the first argument.

🔹 COALESCE

Purpose: Returns the first non-NULL value from a list of expressions.
Example:

SELECT COALESCE(DiscountPrice, SalePrice, Price, 0) AS FinalPrice
FROM Products;
Returns the first non-NULL among DiscountPrice, SalePrice, Price. If all are NULL, it returns 0.*/

--22

CREATE TABLE Employees (
    EmpID INT NOT NULL PRIMARY KEY,        -- Primary Key
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE    -- Unique Key
);

--23

CREATE TABLE Departments (
    DeptID INT PRIMARY KEY,
    DeptName NVARCHAR(100) NOT NULL
);


CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    EmpName NVARCHAR(100) NOT NULL,
    DeptID INT,
    CONSTRAINT FK_Employees_Departments 
        FOREIGN KEY (DeptID) 
        REFERENCES Departments(DeptID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
