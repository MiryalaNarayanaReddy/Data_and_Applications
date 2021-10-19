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
    Block_name VARCHAR(10) NOT NULL,
    Block_manager_id INT NOT NULL,
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

-- Apartment

DROP TABLE IF EXISTS APARTMENT;

CREATE TABLE APARTMENT(
	Apartment_number int NOT NULL,
    Block_name varchar(10) NOT NULL,
    Owner_id int,
    Apartment_size float NOT NULL,
    Monthly_maintenance_charges float NOT NULL,
    PRIMARY KEY (Block_name, Apartment_number),
    KEY (Owner_id),
    CONSTRAINT APARTMENT_fk_1 FOREIGN KEY (Block_name) REFERENCES APARTMENT_COMPLEX (Block_name)

);

LOCK TABLES APARTMENT WRITE;

INSERT INTO APARTMENT VALUES
('102','A',202010201,1200,1000),
('104','A',202010401,1500,1300);

UNLOCK TABLES;

-- Owners

DROP TABLE IF EXISTS OWNERS;

CREATE TABLE OWNERS(
	Owner_name varchar(30) NOT NULL,
    Owner_id int NOT NULL,
    Block_name varchar(10) NOT NULL,
    Email_id varchar(50) NOT NULL,
    Owner_since datetime NOT NULL,
    PRIMARY KEY (Owner_id,Block_name),
    KEY (Email_id),
    CONSTRAINT OWNERS_fk_1 FOREIGN KEY (Owner_id) REFERENCES APARTMENT(Owner_id),
	CONSTRAINT OWNERS_fk_2 FOREIGN KEY (Block_name) REFERENCES APARTMENT_COMPLEX (Block_name)
);



LOCK TABLES OWNERS WRITE;

INSERT INTO OWNERS VALUES
('Arun',202010201,'A','arun@gmail.com','2020-10-19 20:27:35' ),
('Krish',202010401,'A','krish@gmail.com','2020-10-10 10:00:05');

UNLOCK TABLES;


