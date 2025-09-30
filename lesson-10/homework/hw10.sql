--1
select e.Name as EmployeeName, e.Salary, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where e.Salary > 50000;

--2
select c.FirstName, c.LastName, o.OrderDate
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where YEAR (o.OrderDate) = 2023;

--3
select e.Name, d.DepartmentName
from Employees e
left join Departments d on e.DepartmentID = d.DepartmentID;

--4
select p.ProductName, s.SupplierName
from Products p
right join Suppliers s on p.SupplierID = s.SupplierID

--5
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
from Orders o
full join Payments p on o.OrderID = p.OrderID;

--6
select e.Name as EmployeeName, m.Name as ManagerName
from Employees e
left join Employees m on e.ManagerID = m.EmployeeID

--7
select s.Name as StudentName, c.CourseName
from Students s
join Enrollments e on e.StudentID = s.StudentID
join Courses c on c.CourseID = e.CourseID
where c.CourseName = 'Math 101';

--8
select c.FirstName, c.LastName, o.Quantity
from Customers c
join Orders o on c.CustomerID = o.CustomerID
where o.Quantity > 3;

--9
select e.Name as EmplyeeName, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Human Resources';

--10
select d.DepartmentName, count(*) as EmployeeCount
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
group by d.DepartmentName
having COUNT(*) > 5;

--11
select p.ProductID, p.ProductName
from Products p
left join Sales s on p.ProductID = s.ProductID
where s.ProductID is NULL;

--12
select c.FirstName, c.LastName, COUNT(o.OrderID) as TotalOrders
from Customers c
join Orders o on c.CustomerID = o.CustomerID
group by c.FirstName, c.LastName;

--13
select e.Name as EmployeeName, d.Departmentname
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID;

--14
SELECT e1.Name AS Employee1,
       e2.Name AS Employee2,
       e1.ManagerID
FROM Employees e1
JOIN Employees e2 ON e1.ManagerID = e2.ManagerID
                 AND e1.EmployeeID < e2.EmployeeID;

--15
select o.OrderID, o.OrderDate, c.FirstName, c.LastName
from Orders o
join Customers c on o.CustomerID = c.CustomerID
where YEAR(o.OrderDate) = 2022;

--16
select e.Name as EmployeeName, e.Salary, d.DepartmentName
from Employees e
join Departments d on e.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Sales' and e.Salary > 60000;

--17
select o.OrderID, o.OrderDate, p.PaymentDate, p.Amount
from Orders o
join Payments p on o.OrderID = p.OrderID;

--18
select p.ProductID, p.ProductName 
from Products p
left join Orders o on p.ProductID = o.ProductID
where o.ProductID is null;
