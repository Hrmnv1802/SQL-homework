
--1.
create table #MonthlySales
(
ProductID int,
TotalQuantity int,
TotalRevenue float
);

Insert into #MonthlySales(ProductID, TotalQuantity, TotalRevenue)
Select
	s.ProductID,
	sum(s.Quantity) AS TotalQuantity,
	sum(s.Quantity*p.Price) AS TotalRevenue
from Sales s
join Products p on s.ProductID=p.ProductID
where Month(s.SaleDate)=Month(getdate())
	and Year(s.SaleDate)=Year(getdate())
group by s.ProductID

select ProductID, TotalQuantity, TotalRevenue
from #MonthlySales

--2.
create view vw_ProductSalesSummary as
(
select p.ProductID, p.ProductName, p.Category,
sum(s.Quantity) as TotalQuantitySold
from Products p
left join Sales s on p.ProductID=s.ProductID
group by p.ProductID, p.ProductName, p.Category
)

select * from vw_ProductSalesSummary

--3.
create function fn_GetTotalRevenueForProduct (@ProductID INT)
returns float
as
begin
declare @TotalRevenue float

	select @TotalRevenue=Sum(s.Quantity*p.Price)
	from Sales s
	join Products p on s.ProductID=p.ProductID
	where s.ProductID=@ProductID;

	return isnull (@TotalRevenue, 0);

end

SELECT dbo.fn_GetTotalRevenueForProduct(1);

--4.

create function fn_GetSalesByCategory (@Category VARCHAR(50))
returns Table
as 
return
(
Select p.ProductName, sum(s.Quantity) as TotalQuantity, sum(s.Quantity*p.Price) as TotalRevenue
from Products p
left join Sales s on p.ProductID=s.ProductID
where p.Category=@Category
group by p.ProductName
)

select * from dbo.fn_GetSalesByCategory('clothing')

--5.
-- 5. Function to check if a number is prime
CREATE FUNCTION dbo.fn_IsPrime (@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    DECLARE @i INT;
    

    IF @Number < 2
        RETURN 'No';
    
    SET @i = 2;
    

    WHILE @i * @i <= @Number
    BEGIN
        IF @Number % @i = 0
            RETURN 'No';
        SET @i = @i + 1;
    END

    RETURN 'Yes';
END;
SELECT dbo.fn_IsPrime(7) AS IsPrime; 

--6.

CREATE FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS TABLE
AS
RETURN
(
    WITH NumbersCTE AS
    (
        SELECT @Start AS Number
        UNION ALL
        SELECT Number + 1
        FROM NumbersCTE
        WHERE Number + 1 <= @End
    )
    SELECT Number
    FROM NumbersCTE
);
SELECT * FROM dbo.fn_GetNumbersBetween(5, 10);

--7.

CREATE FUNCTION dbo.getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    SELECT @Result = (
        SELECT DISTINCT Salary
        FROM Employee
        ORDER BY Salary DESC
        OFFSET @N - 1 ROWS FETCH NEXT 1 ROWS ONLY
    );

    RETURN @Result;
END;
SELECT dbo.getNthHighestSalary(2) AS HighestNSalary;

--8.
SELECT TOP 1
    user_id AS id,
    COUNT(*) AS num
FROM
(
    
    SELECT requester_id AS user_id FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS user_id FROM RequestAccepted
) AS AllFriends
GROUP BY user_id
ORDER BY COUNT(*) DESC;

--9.

CREATE VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    SUM(o.amount) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
SELECT * FROM vw_CustomerOrderSummary;

--10.
