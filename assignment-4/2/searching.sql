create table INVINDEX (
    WORD VARCHAR(20),
    DOC_ID int,
    FREQ int
);


insert into INVINDEX 
values  ('hello',4,20),
        ('Marvel',2,4),
        ('World',12,9),
        ('Blackpink',41,5),
        ('Bonda',12,20),
        ('Hammer',6,9);

create table ENTITY (
    WORD1 VARCHAR(20),
    WORD2 VARCHAR(20),
    DOC_ID int
);

insert into ENTITY 
values ('Pizza','Italy',5),
('Margherita','Pizza',21),
('Italy','Grammy',8),
('Italy','Pasta',5),
('Taylor','Singer',8),
('Modi','Dancer',13),
('Pasta','Pineapple',5);


-- 2 --
/*
    SELECT WORD1, WORD2, DOC_ID , LEVEL
    FROM ENTITY
    CONNECT BY  WORD2 = PRIOR WORD1 
    and  DOC_ID = PRIOR DOC_ID 
    and LEVEL <3;
*/

--------------------



WITH RECURSIVE descendant AS (
    SELECT WORD1,
            WORD2,
            DOC_ID,
            0 as LEVEL
    FROM ENTITY 
    
)



-- a --



SELECT I1.DOC_ID,I1.FREQ/(SELECT SUM(FREQ) FROM INVINDEX WHERE DOC_ID = I1.DOC_ID) from INVINDEX as I1 WHERE I1.WORD = 'hello' and ISNULL(SELECT *from INVINDEX where DOC_ID=I1.DOC_ID and WORD = 'World');


SELECT I1.DOC_ID, I1.FREQ/(SELECT SUM(FREQ) FROM INVINDEX WHERE DOC_ID = I1.DOC_ID) from INVINDEX as I1 WHERE I1.WORD = 'World';

SELECT I1.DOC_ID, I1.FREQ/(SELECT SUM(FREQ) FROM INVINDEX WHERE DOC_ID = I1.DOC_ID) from INVINDEX as I1 WHERE I1.WORD = 'Hello';





SELECT DOC_ID , 

(SELECT I1.DOC_ID, I1.FREQ/(SELECT SUM(FREQ) FROM INVINDEX WHERE DOC_ID = I1.DOC_ID) as SCORE from INVINDEX as I1 WHERE I1.WORD = 'World') as W
(SELECT I1.DOC_ID, I1.FREQ/(SELECT SUM(FREQ) FROM INVINDEX WHERE DOC_ID = I1.DOC_ID) as SCORE from INVINDEX as I1 WHERE I1.WORD = 'Hello') as H



-- b -- 

CREATE VIEW TEMP1 AS
    SELECT WORD2, DOC_ID FROM ENTITY WHERE WORD1 = 'Pizza';

CREATE VIEW TEMP2 AS 
    SELECT E.WORD2, E.DOC_ID FROM ENTITY as E, TEMP1 as T WHERE E.WORD1 = T.WORD2 and E.DOC_ID = T.DOC_ID;

CREATE VIEW TEMP3 AS
    SELECT E.WORD2, E.DOC_ID FROM ENTITY as E, TEMP2 as T WHERE E.WORD1 = T.WORD2 and E.DOC_ID = T.DOC_ID;

SELECT * FROM TEMP3

-- c --


SELECT I.DOC_ID, I.FREQ FROM INVINDEX as I, TEMP3 as T WHERE T.DOC_ID = I.DOC_ID and I.WORD='Lotus';



-- d --
avg score  = sum(all scores)/num documents 

-- Order by Avg Score--

SELECT DISTINCT I.WORD from INVINDEX as I ORDER BY (SELECT SUM(I1.FREQ/(SELECT SUM(FREQ) FROM INVINDEX WHERE DOC_ID = I1.DOC_ID))/COUNT(*) from INVINDEX as I1 WHERE I1.WORD= I.WORD) DESC;
