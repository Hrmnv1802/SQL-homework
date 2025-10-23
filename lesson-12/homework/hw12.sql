--1.
CREATE TABLE Person (personId INT, lastName VARCHAR(255), firstName VARCHAR(255));
CREATE TABLE Address (addressId INT, personId INT, city VARCHAR(255), state VARCHAR(255));

TRUNCATE TABLE Person;
INSERT INTO Person VALUES (1, 'Wang', 'Allen'), (2, 'Alice', 'Bob');

TRUNCATE TABLE Address;
INSERT INTO Address VALUES (1, 2, 'New York City', 'New York'), (2, 3, 'Leetcode', 'California');

-- ✅ Solution
SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a ON p.personId = a.personId;

--2.
CREATE TABLE Employee (id INT, name VARCHAR(255), salary INT, managerId INT);

TRUNCATE TABLE Employee;
INSERT INTO Employee VALUES 
(1, 'Joe', 70000, 3),
(2, 'Henry', 80000, 4),
(3, 'Sam', 60000, NULL),
(4, 'Max', 90000, NULL);

-- ✅ Solution
SELECT e.name AS Employee
FROM Employee e
JOIN Employee m ON e.managerId = m.id
WHERE e.salary > m.salary;

--3.
CREATE TABLE Person (id INT, email VARCHAR(255));

TRUNCATE TABLE Person;
INSERT INTO Person VALUES 
(1, 'a@b.com'),
(2, 'c@d.com'),
(3, 'a@b.com');

-- ✅ Solution
SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;

--4.
CREATE TABLE Person (id INT, email VARCHAR(255));

TRUNCATE TABLE Person;
INSERT INTO Person VALUES 
(1, 'john@example.com'),
(2, 'bob@example.com'),
(3, 'john@example.com');

-- ✅ Solution
DELETE p1
FROM Person p1
JOIN Person p2 
  ON p1.email = p2.email AND p1.id > p2.id;


SELECT * FROM Person;


--5.
CREATE TABLE boys (Id INT PRIMARY KEY, name VARCHAR(100), ParentName VARCHAR(100));
CREATE TABLE girls (Id INT PRIMARY KEY, name VARCHAR(100), ParentName VARCHAR(100));

INSERT INTO boys VALUES
(1, 'John', 'Michael'), (2, 'David', 'James'),
(3, 'Alex', 'Robert'), (4, 'Luke', 'Michael'),
(5, 'Ethan', 'David'), (6, 'Mason', 'George');

INSERT INTO girls VALUES
(1, 'Emma', 'Mike'), (2, 'Olivia', 'James'),
(3, 'Ava', 'Robert'), (4, 'Sophia', 'Mike'),
(5, 'Mia', 'John'), (6, 'Isabella', 'Emily'),
(7, 'Charlotte', 'George');

-- ✅ Solution
SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (SELECT b.ParentName FROM boys b);

--6.
SELECT 
    custid,
    SUM(salesamount) AS TotalSalesOver50,
    MIN(weight) AS LeastWeight
FROM Sales.Orders
WHERE weight > 50
GROUP BY custid;

--7.
DROP TABLE IF EXISTS Cart1;
DROP TABLE IF EXISTS Cart2;

CREATE TABLE Cart1 (Item VARCHAR(100));
CREATE TABLE Cart2 (Item VARCHAR(100));

INSERT INTO Cart1 VALUES ('Sugar'), ('Bread'), ('Juice'), ('Soda'), ('Flour');
INSERT INTO Cart2 VALUES ('Sugar'), ('Bread'), ('Butter'), ('Cheese'), ('Fruit');

-- ✅ Solution
SELECT 
    c1.Item AS [Item Cart 1],
    c2.Item AS [Item Cart 2]
FROM Cart1 c1
FULL OUTER JOIN Cart2 c2 ON c1.Item = c2.Item
ORDER BY 
    CASE WHEN c1.Item IS NULL THEN 1 ELSE 0 END,
    ISNULL(c1.Item, c2.Item);

--8.
CREATE TABLE Customers (id INT, name VARCHAR(255));
CREATE TABLE Orders (id INT, customerId INT);

TRUNCATE TABLE Customers;
INSERT INTO Customers VALUES 
(1, 'Joe'), (2, 'Henry'), (3, 'Sam'), (4, 'Max');

TRUNCATE TABLE Orders;
INSERT INTO Orders VALUES (1, 3), (2, 1);

-- ✅ Solution
SELECT name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.customerId IS NULL;

--9.

CREATE TABLE Students (
    student_id INT,
    student_name VARCHAR(20)
);

CREATE TABLE Subjects (
    subject_name VARCHAR(20)
);

CREATE TABLE Examinations (
    student_id INT,
    subject_name VARCHAR(20)
);

TRUNCATE TABLE Students;
INSERT INTO Students (student_id, student_name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(13, 'John'),
(6, 'Alex');

TRUNCATE TABLE Subjects;
INSERT INTO Subjects (subject_name) VALUES
('Math'),
('Physics'),
('Programming');

TRUNCATE TABLE Examinations;
INSERT INTO Examinations (student_id, subject_name) VALUES
(1, 'Math'),
(1, 'Physics'),
(1, 'Programming'),
(2, 'Programming'),
(1, 'Physics'),
(1, 'Math'),
(13, 'Math'),
(13, 'Programming'),
(13, 'Physics'),
(2, 'Math'),
(1, 'Math');

-- ✅ Решение:
SELECT 
    s.student_id,
    s.student_name,
    sub.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects sub
LEFT JOIN Examinations e
    ON s.student_id = e.student_id
   AND sub.subject_name = e.subject_name
GROUP BY 
    s.student_id, 
    s.student_name, 
    sub.subject_name
ORDER BY 
    s.student_id, 
    sub.subject_name;


