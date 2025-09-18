create database homework_5
go
use homework_5

--1.
select Productname as Name
from Products;

--2.
select * 
from Customers as Client;

--3.
select ProductName from Products
Union
select ProductName from Products_Discounted;

--4.
select ProductName from Products
intersect
select ProductName from Products_Discounted;

--5.
select distinct FirstName, LastName, Country
from Customers;

--6.
select *,
	case when Price > 1000 then 'High'
		 when Price <= 1000 then 'Low'
		 End as PriceCategory
	from Products;

--7.
select *, iif(StockQuantity > 100, 'Yes', 'No') as StockStatus
from Products_Discounted;

--8.
select ProductName from Products
Union
select ProductName from Products_Discounted;

--9.
select * from Products
except
select * from Products_Discounted;

--10.
select * ,
       IIF(Price > 1000, 'Expensive', 'Affordable') AS PriceStatus
from Products;

--11.
select * from Employees
where Age < 25 or Salary > 60000;

--12.
update Employees
set Salary = case
                 when DepartmentName = 'HR' or EmployeeID = 5
                 then Salary * 1.10
                 else Salary
             end;

--13.
select *,
       case
           when SaleAmount > 500 then 'Top Tier'
           when SaleAmount BETWEEN 200 AND 500 then 'Mid Tier'
           else 'Low Tier'
       end as Tier
from Sales;

--14.
select CustomerID
from Orders
except
select CustomerID
from Sales;

--15.
select CustomerID, Quantity,
       case
           when Quantity = 1 then '3%'
           when Quantity BETWEEN 2 AND 3 then '5%'
           else '7%'
       end as Discount
from Orders;
