CREATE TABLE point (
    X int,
    Y int,
    Z int
);

INSERT INTO point VALUES (1,2,3);
INSERT INTO point VALUES (12,34,55);
INSERT INTO point VALUES (51,23,31);
INSERT INTO point VALUES (12,23,34);
INSERT INTO point VALUES (12,34,34);
INSERT INTO point VALUES (9,21,83);
INSERT INTO point VALUES (20,1,3);
INSERT INTO point VALUES (20,10,5);

SELECT *FROM point;


-- 1 --

SELECT *FROM point ORDER BY x, y, z;

-- 2 --

SELECT *FROM point WHERE Z  = (SELECT MAX(Z) FROM point) ;
SELECT *FROM point WHERE Z  = (SELECT MIN(Z) FROM point) ;

-- 3 --

SELECT x,y,z FROM point ORDER BY SQRT(x*x+y*y+z*z) LIMIT 5;

--4--

select SUM(x)/COUNT(x) ,SUM(y)/COUNT(x) ,SUM(z)/COUNT(x) from point; 

--5--

