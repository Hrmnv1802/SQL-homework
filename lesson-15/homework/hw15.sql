--1.
select * from employees
where salary in (select min(salary) from employees)

--2.
select * from products
where price>(select avg(price) from products)

--3.
select * from employees
where department_id=(select id from departments
where department_name = 'Sales')

--4.
select customer_id, name from customers
where customer_id not in (select customer_id from orders)

--5.
SELECT id, product_name, price, category_id--
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products AS p2
    WHERE p2.category_id = products.category_id
);

--6.
SELECT id, name, salary, department_id
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);

--7.
select id, name, salary, department_id from employees as a
where salary>(select avg(salary) from employees
where department_id=a.department_id)

--8.
SELECT 
    (SELECT name FROM students s WHERE s.student_id = g.student_id) AS student_name,
    g.course_id,
    g.grade
FROM grades g
WHERE g.grade = (
    SELECT MAX(g2.grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id
);


--9.
SELECT p1.id, p1.product_name, p1.price, p1.category_id
FROM products p1
WHERE 2 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM products p2
    WHERE p2.category_id = p1.category_id
      AND p2.price > p1.price
);

--10.
SELECT id, name, salary, department_id
FROM employees e
WHERE salary > (
    SELECT AVG(salary)
    FROM employees
)
AND salary < (
    SELECT MAX(salary)
    FROM employees
    WHERE department_id = e.department_id
);
