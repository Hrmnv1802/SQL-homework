--1.
select o.OrderID, c.Firstname + ' ' + c.Lastname as CustomerName, o.Orderdate from [Orders] o
join Customers	 c on o.CustomerID = c.CustomerID and o.OrderDate > '2022-01-01'

--2.
select e.Name as EmployeeName, d.DepartmentName from Employees e
join Departments d on e.DepartmentID = d.DepartmentID and d.DepartmentName in ('Sales','Marketing')

--3.
select d.DepartmentName, max(Salary) as MaxSalary from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName

--4.
select OrderID, c.Firstname + ' ' + c.Lastname as CustomerName, o.Orderdate from Customers c
join [Orders] o on c.CustomerID = o.CustomerID
where c.Country in ('USA') and o.Orderdate between '2023-01-01' and '2023-12-31'

--5.
select c.Firstname + ' ' + c.Lastname as CustomerName, count(o.OrderID) as TotalOrders  from [Orders] o
join Customers c on o.CustomerID = c.CustomerID 
group by c.Firstname, c.Lastname 

--6.
select p.ProductName, s.SupplierName from Products p
join Suppliers s on p.SupplierID = s.SupplierID
where s.SupplierName in ('Gadget Supplies', 'Clothing Mart')

--7.
select c.Firstname + ' ' + c.Lastname as CustomerName, max(o.Orderdate) as MostRecentOrderDate from Customers c
left join [Orders] o on c.CustomerID = o.CustomerID
group by c.Firstname, c.Lastname
order by CustomerName

--8.
select c.Firstname + ' ' + c.Lastname as CustomerName, TotalAmount as OrderTotal from Orders o
join Customers c on o.CustomerID = c.CustomerID 
where o.TotalAmount>500 

--9.
select p.ProductName, s.SaleDate, s.SaleAmount from Products p
join Sales s on p.ProductID = s.ProductID
where YEAR (s.SaleDate) = 2022 or s.SaleAmount>400

--10.
select p.ProductName, sum(s.SaleAmount) as TotalSalesAmount from Products p
left join Sales s on p.ProductID=s.ProductID 
group by p.ProductName

--11.
select e.Name, d.DepartmentName, Salary from Employees e
join Departments d on e.DepartmentID=d.DepartmentID
where d.DepartmentName in ('Human Resources') and Salary > 60000

--12.
select ProductName, SaleDate, StockQuantity from Products p
join Sales s on p.ProductID=s.ProductID
where Year(SaleDate)=2023 and StockQuantity>100

--13.
select e.Name, DepartmentName, HireDate from Employees e
join Departments d on e.DepartmentID=d.DepartmentID
where DepartmentName in ('Sales') or Year(HireDate)>2020

--14.
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    o.OrderID,
    c.Address,
    o.OrderDate
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE c.Country = 'USA'
  AND c.Address LIKE '[0-9][0-9][0-9][0-9]%';

--15.

SELECT 
    p.ProductName,
    p.Category,
    s.SaleAmount
FROM Products p
JOIN sales s 
    ON p.ProductID = s.ProductID
WHERE p.Category = 'Electronics'
   OR s.SaleAmount > 350;
--16.

SELECT 
    c.CategoryName,
    COUNT(p.ProductID) AS ProductCount
FROM Categories c
LEFT JOIN Products p 
    ON c.CategoryID = p.Category
GROUP BY c.CategoryName
ORDER BY ProductCount DESC;

--17.
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.City,
    o.OrderID,
    o.TotalAmount
FROM Customers c
JOIN Orders o 
    ON c.CustomerID = o.CustomerID
WHERE c.City = 'Los Angeles'
  AND o.totalAmount > 300;

--18.
SELECT 
    e.Name,
    d.DepartmentName
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('HR', 'Finance')
   OR (LEN(e.Name) 
       - LEN(REPLACE(LOWER(e.Name), 'a', '')) 
       + LEN(e.Name) 
       - LEN(REPLACE(LOWER(e.Name), 'e', '')) 
       + LEN(e.Name) 
       - LEN(REPLACE(LOWER(e.Name), 'i', '')) 
       + LEN(e.Name) 
       - LEN(REPLACE(LOWER(e.Name), 'o', '')) 
       + LEN(e.Name) 
       - LEN(REPLACE(LOWER(e.Name), 'u', ''))) >= 4;

--19.
SELECT 
    e.Name,
    d.DepartmentName,
    e.Salary
FROM Employees e
JOIN Departments d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName IN ('Sales', 'Marketing')
  AND e.Salary > 60000;
