--Puzzle 1.
CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm');

SELECT DISTINCT 
       CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
       CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
FROM InputTbl;

SELECT 
       MIN(col1) AS col1,
       MAX(col2) AS col2
FROM (
    SELECT CASE WHEN col1 < col2 THEN col1 ELSE col2 END AS col1,
           CASE WHEN col1 < col2 THEN col2 ELSE col1 END AS col2
    FROM InputTbl
) t
GROUP BY col1, col2;

--Puzzle 2.
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0);

SELECT *
FROM TestMultipleZero
WHERE A <> 0 OR B <> 0 OR C <> 0 OR D <> 0;

--Puzzle 3.
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro')

SELECT *
FROM section1
WHERE id % 2 = 1;

--Puzzle 4.
SELECT TOP 1 *
FROM section1
ORDER BY id ASC;

--or
SELECT *
FROM section1
WHERE id = (SELECT MIN(id) FROM section1);


--Puzzle 5.
SELECT *
FROM section1
WHERE id = (SELECT MAX(id) FROM section1);

--Puzzle 6.
SELECT *
FROM section1
WHERE name LIKE 'B%';

--Puzzle 7.
CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999');

SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';
--or
SELECT *
FROM ProductCodes
WHERE CHARINDEX('_', Code) > 0;
