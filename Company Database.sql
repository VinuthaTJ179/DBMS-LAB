CREATE DATABASE COMPANY;
USE COMPANY;
CREATE TABLE DEPARTMENT
(
    DNO VARCHAR(1) PRIMARY KEY,
    DNAME VARCHAR(20),
    MGRSSN VARCHAR(10),
    MGRSTARTDATE DATE
);

DESC DEPARTMENT;

CREATE TABLE EMPLOYEE
(
    SSN VARCHAR(10) PRIMARY KEY,
    FNAME VARCHAR(10),
    LNAME VARCHAR(10),
    ADDRESS VARCHAR(20),
    GENDER VARCHAR(6),
    SALARY INT,
    SUPERSSN VARCHAR(10),
    DNO VARCHAR(1),
    FOREIGN KEY(SUPERSSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY(DNO) REFERENCES DEPARTMENT(DNO)
);

DESC EMPLOYEE;

ALTER TABLE DEPARTMENT ADD FOREIGN KEY(MGRSSN) REFERENCES EMPLOYEE(SSN);
DESC EMPLOYEE;
 
CREATE TABLE DLOCATION
(
    DNO VARCHAR(1),
    DLOC VARCHAR(20),
    PRIMARY KEY(DNO,DLOC),
    FOREIGN KEY(DNO) REFERENCES DEPARTMENT(DNO)
);

DESC DLOCATION;

CREATE TABLE PROJECT
(
    PNO VARCHAR(1) PRIMARY KEY,
    PNAME VARCHAR(20),
    PLOCATION VARCHAR(20),
    DNO VARCHAR(1),
    FOREIGN KEY(DNO) REFERENCES DEPARTMENT(DNO)
);

DESC PROJECT;

CREATE TABLE WORKS_ON
(
    SSN VARCHAR(10),
    PNO VARCHAR(1),
    HOURS INT,
    PRIMARY KEY(SSN,PNO),
    FOREIGN KEY(SSN) REFERENCES EMPLOYEE(SSN),
    FOREIGN KEY(PNO) REFERENCES PROJECT(PNO)
);

DESC WORKS_ON;

INSERT INTO EMPLOYEE(SSN,FNAME,LNAME,ADDRESS,GENDER,SALARY) VALUES ("100","ABHAY","CHANDRAN","BANGALORE","MALE",12000);
INSERT INTO EMPLOYEE(SSN,FNAME,LNAME,ADDRESS,GENDER,SALARY) VALUES ("101","ALIA","BHATT","MUMBAI","FEMALE",22000);
INSERT INTO EMPLOYEE(SSN,FNAME,LNAME,ADDRESS,GENDER,SALARY) VALUES ("102","BHAVYA","ROY","WEST BENGAL","FEMALE",10000);
INSERT INTO EMPLOYEE(SSN,FNAME,LNAME,ADDRESS,GENDER,SALARY) VALUES ("103","NIKHITHA","RAI","MANGALORE","FEMALE",42000);
INSERT INTO EMPLOYEE(SSN,FNAME,LNAME,ADDRESS,GENDER,SALARY) VALUES ("104","ABHIJIT","IYER","BANGALORE","MALE",10000);

SELECT * FROM EMPLOYEE;

INSERT INTO DEPARTMENT VALUES("1","CSE","101","2023-01-01");
INSERT INTO DEPARTMENT VALUES("2","ISE","100","2023-03-01");
INSERT INTO DEPARTMENT VALUES("3","ECE","103","2023-02-01");

SELECT * FROM DEPARTMENT;

UPDATE EMPLOYEE SET DNO="1",SUPERSSN="101" WHERE SSN="100";
UPDATE EMPLOYEE SET DNO="2" WHERE SSN="101";
UPDATE EMPLOYEE SET DNO="1",SUPERSSN="100" WHERE SSN="102";
UPDATE EMPLOYEE SET DNO="3" WHERE SSN="103";
UPDATE EMPLOYEE SET DNO="1",SUPERSSN="102" WHERE SSN="104";

SELECT * FROM EMPLOYEE;

INSERT INTO DLOCATION VALUES("1","BANGALORE");
INSERT INTO DLOCATION VALUES("1","CHENNAI");
INSERT INTO DLOCATION VALUES("2","MUMBAI");
INSERT INTO DLOCATION VALUES("2","BANGALORE");
INSERT INTO DLOCATION VALUES("3","CHENNAI");

SELECT * FROM DLOCATION;

INSERT INTO PROJECT VALUES("1","IOT","BANGALORE","2");
INSERT INTO PROJECT VALUES("2","ML","CHENNAI","1");
INSERT INTO PROJECT VALUES("3","AI","INDORE","3");
INSERT INTO PROJECT VALUES("4","DSA","USA","2");
INSERT INTO PROJECT VALUES("5","DAA","TEXAS","3");

SELECT * FROM PROJECT;

INSERT INTO WORKS_ON VALUES("100","1",12);
INSERT INTO WORKS_ON VALUES("100","2",120);
INSERT INTO WORKS_ON VALUES("101","3",24);
INSERT INTO WORKS_ON VALUES("101","1",12);
INSERT INTO WORKS_ON VALUES("102","5",56);

SELECT * FROM WORKS_ON;

1.(SELECT DISTINCT P1.PNO FROM PROJECT P1,EMPLOYEE E1, DEPARTMENT D1 WHERE E1.LNAME="BHATT" AND D1.DNO = E1.DNO AND E1.SSN = D1.MGRSSN) UNION
  (SELECT DISTINCT P2.PNO FROM PROJECT P2,EMPLOYEE E2, WORKS_ON W2 WHERE E2.LNAME="BHATT" AND W2.SSN = E2.SSN AND W2.PNO=P2.PNO);  

2.SELECT (E1.SALARY*1.1) FROM EMPLOYEE E1,PROJECT P1,WORKS_ON W1 WHERE P1.PNAME="IOT" AND W1.PNO=P1.PNO AND W1.SSN=E1.SSN;

3.SELECT MAX(E.SALARY),MIN(E.SALARY),SUM(E.SALARY),AVG(E.SALARY) FROM EMPLOYEE E,DEPARTMENT D WHERE D.DNAME="CSE" AND E.DNO=D.DNO;


4.SELECT E.FNAME, E.LNAME
FROM EMPLOYEE E
WHERE NOT EXISTS((SELECT PNO FROM PROJECT WHERE DNO="1") 
    EXCEPT (SELECT
PNO FROM WORKS_ON
WHERE E.SSN=SSN));

5.SELECT D.DNO,COUNT(*) FROM DEPARTMENT D,EMPLOYEE E WHERE E.DNO = D.DNO AND E.SALARY > 10000 AND D.DNO IN (SELECT E1.DNO FROM EMPLOYEE E1 GROUP BY(E1.DNO) HAVING COUNT(*)>1) GROUP BY D.DNO;




 







































