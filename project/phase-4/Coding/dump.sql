-- DATABASE FOR APARTMENT MANAGEMENT SYSTEM 
-- AUTHOR MIRYALA NARAYANA REDDY @ 2021 OCTOBER 
-- SQL COMMANDS TO CREATE DATABASE TABLES AND SAMPLE DATA VALUES INSERTED INTO IT.

-- database creation
DROP DATABASE IF EXISTS APARTMENT_MANAGEMENT_SYSTEM;
CREATE SCHEMA APARTMENT_MANAGEMENT_SYSTEM;

USE APARTMENT_MANAGEMENT_SYSTEM;

-- Apartment complex 

DROP TABLE IF EXISTS APARTMENT_COMPLEX;

CREATE TABLE APARTMENT_COMPLEX (
    Block_name VARCHAR(30) NOT NULL,
    Block_manager_id BIGINT NOT NULL,
    Block_manager_name VARCHAR(30) NOT NULL,
    Email_id VARCHAR(50) NOT NULL,
    PRIMARY KEY (Block_name),
    UNIQUE KEY (Block_manager_id),
    UNIQUE KEY (Email_id)
);

LOCK TABLES APARTMENT_COMPLEX WRITE;

INSERT INTO APARTMENT_COMPLEX VALUES 
('A',2020010001,'Narayana','narayana@gmail.com'),
('B',2020010002,'Animesh','animesh@gmail.com'),
('C',2020010003,'Govind sign','govind@gmail.com'),
('D',2020010004,'charles dickens','charles@gmail.com');

UNLOCK TABLES;

-- Block_color

DROP TABLE IF EXISTS BLOCK_COLOR;

CREATE TABLE BLOCK_COLOR (
    Block_name VARCHAR(30) NOT NULL,
    Block_color VARCHAR(20) NOT NULL,
    PRIMARY KEY (Block_name),
    CONSTRAINT BLOCK_COLOR_fk_1 FOREIGN KEY (Block_name)
        REFERENCES APARTMENT_COMPLEX (Block_name)
);

LOCK TABLES BLOCK_COLOR WRITE;

INSERT INTO BLOCK_COLOR VALUES 
('A','pinkish white'),
('B','bluish white');

UNLOCK TABLES;



-- Block_manager_phno

DROP TABLE IF EXISTS BLOCK_MANAGER_PHNO;

CREATE TABLE BLOCK_MANAGER_PHNO (
    Block_manager_id BIGINT NOT NULL,
    Block_manager_phno BIGINT NOT NULL,
    PRIMARY KEY (Block_manager_id , Block_manager_phno),
    CONSTRAINT BLOCK_MANAGER_PHNO_fk_1 FOREIGN KEY (Block_manager_id)
        REFERENCES APARTMENT_COMPLEX (Block_manager_id)
);

LOCK TABLES BLOCK_MANAGER_PHNO WRITE;

INSERT INTO BLOCK_MANAGER_PHNO VALUES 
(2020010001,1122334455),
(2020010001,1234567890),
(2020010004,1212343456);

UNLOCK TABLES;



-- Apartment

DROP TABLE IF EXISTS APARTMENT;

CREATE TABLE APARTMENT (
    Apartment_number INT NOT NULL,
    Block_name VARCHAR(30) NOT NULL,
    Owner_id BIGINT,
    Apartment_size FLOAT NOT NULL,
    Monthly_maintenance_charges FLOAT NOT NULL,
    PRIMARY KEY (Block_name , Apartment_number),
    KEY (Owner_id),
    CONSTRAINT APARTMENT_fk_1 FOREIGN KEY (Block_name)
        REFERENCES APARTMENT_COMPLEX (Block_name)
);

LOCK TABLES APARTMENT WRITE;

INSERT INTO APARTMENT VALUES
('102','A',202010201,1200,1000),
('104','B',202010401,1500,1300);

UNLOCK TABLES;

-- Owners

DROP TABLE IF EXISTS OWNERS;

CREATE TABLE OWNERS (
    Owner_name VARCHAR(30) NOT NULL,
    Owner_id BIGINT NOT NULL,
    Block_name VARCHAR(30) NOT NULL,
    Email_id VARCHAR(50) NOT NULL,
    Owner_since DATETIME NOT NULL,
    PRIMARY KEY (Owner_id , Block_name),
    KEY (Email_id),
    CONSTRAINT OWNERS_fk_1 FOREIGN KEY (Owner_id)
        REFERENCES APARTMENT (Owner_id),
    CONSTRAINT OWNERS_fk_2 FOREIGN KEY (Block_name)
        REFERENCES APARTMENT_COMPLEX (Block_name)
);

LOCK TABLES OWNERS WRITE;

INSERT INTO OWNERS VALUES
('Arun',202010201,'A','arun@gmail.com','2020-10-19 20:27:35' ),
('Krish',202010401,'B','krish@gmail.com','2020-10-10 10:00:05');

UNLOCK TABLES;

-- Owner_phno

DROP TABLE IF EXISTS OWNER_PHNO;

CREATE TABLE OWNER_PHNO (
    Block_name VARCHAR(30) NOT NULL,
    Owner_id BIGINT NOT NULL,
    Owner_phno BIGINT NOT NULL,
    PRIMARY KEY (Owner_id , Block_name , Owner_phno),
    CONSTRAINT OWNER_PHNO_fk_1 FOREIGN KEY (Block_name)
        REFERENCES APARTMENT_COMPLEX (Block_name),
    CONSTRAINT OWNER_PHNO_fk_2 FOREIGN KEY (Owner_id)
        REFERENCES OWNERS (Owner_id)
);

LOCK TABLES OWNER_PHNO WRITE;

INSERT INTO OWNER_PHNO VALUES 
('A',202010201,1122334455),
('A',202010201,1234567890),
('B',202010401,1212343456);

UNLOCK TABLES;


-- Tenant

DROP TABLE IF EXISTS TENANT;

CREATE TABLE TENANT (
    Tenant_name VARCHAR(30) NOT NULL,
    Block_name VARCHAR(30) NOT NULL,
    Owner_id BIGINT NOT NULL,
    Apartment_number INT NOT NULL,
    Email_id VARCHAR(50) NOT NULL,
    Tenant_since DATETIME NOT NULL,
    PRIMARY KEY (Block_name , Owner_id),
    KEY (Email_id),
    CONSTRAINT TENANT_fk_1 FOREIGN KEY (Owner_id)
        REFERENCES OWNERS (Owner_id),
    CONSTRAINT TENANT_fk_2 FOREIGN KEY (Block_name)
        REFERENCES APARTMENT_COMPLEX (Block_name)
);

LOCK TABLES TENANT WRITE;

INSERT INTO TENANT VALUES
('Ravi','A',202010201,102,'ravi@outlook.com','2020-10-20 7:22:05' ),
('Banu','B',202010401,104,'Banu@yahoo.com','2020-10-20 7:23:39');

UNLOCK TABLES;

-- Tenant_phno

DROP TABLE IF EXISTS TENANT_PHNO;

CREATE TABLE TENANT_PHNO (
    Block_name VARCHAR(30) NOT NULL,
    Owner_id BIGINT NOT NULL,
    Tenant_phno BIGINT NOT NULL,
    PRIMARY KEY (Owner_id , Block_name , Tenant_phno),
    CONSTRAINT TENANT_PHNO_fk_1 FOREIGN KEY (Block_name)
        REFERENCES APARTMENT_COMPLEX (Block_name),
    CONSTRAINT TENANT_PHNO_fk_2 FOREIGN KEY (Owner_id)
        REFERENCES OWNERS (Owner_id)
);

LOCK TABLES TENANT_PHNO WRITE;

INSERT INTO TENANT_PHNO VALUES 
('A',202010201,1111222233),
('B',202010401,2223336660),
('B',202010401,1234123498);

UNLOCK TABLES;


-- MMC

DROP TABLE IF EXISTS MMC;

CREATE TABLE MMC (
    Block_name VARCHAR(30) NOT NULL,
    Apartment_number INT NOT NULL,
    paid_upto DATE NOT NULL,
    PRIMARY KEY (Block_name , Apartment_number),
    CONSTRAINT MMC_fk_1 FOREIGN KEY (Block_name , Apartment_number)
        REFERENCES APARTMENT (Block_name , Apartment_number)
);


LOCK TABLES MMC WRITE;

INSERT INTO MMC VALUES 
('A',102,'2020-10-1'),
('B',104,'2020-12-1');

UNLOCK TABLES;

-- committee tenure

DROP TABLE IF EXISTS COMMITTEE_TENURE;

CREATE TABLE COMMITTEE_TENURE (
    Committee_id BIGINT NOT NULL,
    Perid_start DATE NOT NULL,
    Period_end DATE,
    PRIMARY KEY (Committee_id)
);

LOCK TABLES COMMITTEE_TENURE WRITE;

INSERT INTO COMMITTEE_TENURE VALUES 
(1,'2020-10-01',NULL);

UNLOCK TABLES;

-- committee

DROP TABLE IF EXISTS COMMITEE;

CREATE TABLE COMMITTEE (
    Committee_id BIGINT NOT NULL,
    Member_name VARCHAR(30) NOT NULL,
    Email_id VARCHAR(50) NOT NULL,
    Member_id BIGINT NOT NULL,
    PRIMARY KEY (Committee_id , Member_id),
    KEY (Email_id)
);

LOCK TABLES COMMITTEE WRITE;

INSERT INTO COMMITTEE VALUES 
(1,'Vigneshwar','vigneshwar1@yahoo.com',2020101), -- member id = committee_id member_number
(1,'Aryan','Aryan12@gmail.com',2020102); 

UNLOCK TABLES;

-- committee phno

DROP TABLE IF EXISTS COMMITTEE_PHNO;

CREATE TABLE COMMITTEE_PHNO (
    Committee_id BIGINT NOT NULL,
    Member_id BIGINT NOT NULL,
    Member_phno BIGINT NOT NULL,
    PRIMARY KEY (Committee_id , Member_id , Member_phno)
);

LOCK TABLES COMMITTEE_PHNO WRITE;

INSERT INTO COMMITTEE_PHNO VALUES 
(1,2020101,1234512345),
(1,2020102,0987098712);

UNLOCK TABLES;

-- accounts

DROP TABLE IF EXISTS ACCOUNTS;

CREATE TABLE ACCOUNTS (
    Committee_id BIGINT NOT NULL,
    Period DATE NOT NULL,
    Income FLOAT NOT NULL,
    Total_expenditure FLOAT NOT NULL,
    PRIMARY KEY (Committee_id,Period)
);

LOCK TABLES ACCOUNTS WRITE;

INSERT INTO ACCOUNTS VALUES 
(1,'2020-10-1',1800,1500),
(1,'2020-11-1',2800,2000);

UNLOCK TABLES;

-- visitor

DROP TABLE IF EXISTS VISITOR;

CREATE TABLE VISITOR (
    Visitor_number BIGINT NOT NULL AUTO_INCREMENT,
    Visitor_name VARCHAR(30),
    Visit_time DATETIME NOT NULL,
    Vistor_phno BIGINT NOT NULL,
    Purpose VARCHAR(255),
    PRIMARY KEY (Visitor_number)
);

LOCK TABLES VISITOR WRITE;

INSERT INTO VISITOR (Visitor_name, Visit_time, Vistor_phno, Purpose) VALUES 
('vijay','2020-10-20 9:00:32',1111262233,'I am a relative of person in block A apartment number 102'),
('Akash','2020-10-20 9:15:12',1111222233,'Wanted to know if you have any employment for me.');

UNLOCK TABLES;

-- complaint 

DROP TABLE IF EXISTS COMPLAINT;

CREATE TABLE COMPLAINT (
    Block_name VARCHAR(30) NOT NULL,
    Apartment_number INT NOT NULL,
    Complaint_number BIGINT NOT NULL,
    Complainant VARCHAR(30) NOT NULL,
    Complaint VARCHAR(30) NOT NULL,
    Lodge_time DATETIME NOT NULL,
    Complaint_status VARCHAR(20) NOT NULL,
    Complaint_type VARCHAR(20) NOT NULL,
    PRIMARY KEY (Complaint_number)
);


LOCK TABLES COMPLAINT WRITE;

INSERT INTO COMPLAINT VALUES 
('A',102,1,'Arun','No electricity in hall','2020-10-20 9:39:46','pending','electrician'),
('B',104,2,'Arun','Tap leakage in kitchen','2020-10-20 9:43:07','pending','plumbing');

UNLOCK TABLES;


-- complaint history

DROP TABLE IF EXISTS COMPLAINT_HISTORY;

CREATE TABLE COMPLAINT_HISTORY (
    Block_name VARCHAR(30) NOT NULL,
    Apartment_number INT NOT NULL,
    Complaint_number BIGINT NOT NULL,
    Complainant VARCHAR(30) NOT NULL,
    Complaint VARCHAR(30) NOT NULL,
    Lodge_time DATETIME NOT NULL,
    Complaint_type VARCHAR(20) NOT NULL,
    Resolver_name VARCHAR(30) NOT NULL,
    Resolver_phno BIGINT NOT NULL,
    Resolver_email_id VARCHAR(50),
    PRIMARY KEY (Complaint_number)
);

DELETE FROM COMPLAINT 
WHERE
    Complaint_number = 2;

LOCK TABLES COMPLAINT_HISTORY  WRITE;

INSERT INTO COMPLAINT_HISTORY VALUES 
('B',104,2,'Arun','Tap leakage in kitchen','2020-10-20 9:43:07','plumbing','Ganesh',9977883322,'ganesh_pumbing@gmail.com');

UNLOCK TABLES;


-- employee 

DROP TABLE IF EXISTS EMPLOYEE;

CREATE TABLE EMPLOYEE (
    Employee_id BIGINT NOT NULL,
    Employee_name VARCHAR(30) NOT NULL,
    Email_id VARCHAR(50) NOT NULL,
    Salary FLOAT NOT NULL,
    Manager_id BIGINT,
    Work_type VARCHAR(20) NOT NULL,
    Start_date DATE,
    PRIMARY KEY (Employee_id)
);

LOCK TABLES EMPLOYEE WRITE;

INSERT INTO EMPLOYEE VALUES 
(1,'david','david@gmail.com',1200,NULL,'managing cleaners','2020-10-20 10:16:56');

UNLOCK TABLES;


-- employee phno

DROP TABLE IF EXISTS EMPLOYEE_PHNO;

CREATE TABLE EMPLOYEE_PHNO (
    Employee_id BIGINT NOT NULL,
    Phone_number BIGINT NOT NULL,
    PRIMARY KEY (Employee_id , Phone_number)
);

LOCK TABLES EMPLOYEE_PHNO WRITE;

INSERT INTO EMPLOYEE_PHNO VALUES 
(1,9998885551),
(1,9998883330);

UNLOCK TABLES;


-- employee history

DROP TABLE IF EXISTS EMPLOYEE_HISTORY;

CREATE TABLE EMPLOYEE_HISTORY (
    Employee_id BIGINT NOT NULL,
    Employee_name VARCHAR(30) NOT NULL,
    Email_id VARCHAR(50) NOT NULL,
    Salary FLOAT NOT NULL,
    Manager_id BIGINT,
    Work_type VARCHAR(50) NOT NULL,
    Start_date DATE,
    end_date Date,
    PRIMARY KEY (Employee_id)
);

LOCK TABLES EMPLOYEE_HISTORY WRITE;

INSERT INTO EMPLOYEE_HISTORY VALUES 
(2,'john','john@outlook.com',2000,NULL,'managing festive events','2020-10-01 10:21:53','2020-10-20 10:24:35');

UNLOCK TABLES;


-- employee phno

DROP TABLE IF EXISTS EMPLOYEE_PHNO_HISTORY;

CREATE TABLE EMPLOYEE_PHNO_HISTORY (
    Employee_id BIGINT NOT NULL,
    Phone_number BIGINT NOT NULL,
    PRIMARY KEY (Employee_id , Phone_number)
);

LOCK TABLES EMPLOYEE_PHNO_HISTORY WRITE;

INSERT INTO EMPLOYEE_PHNO_HISTORY VALUES 
(2,9998885541),
(2,9998883230);

UNLOCK TABLES





