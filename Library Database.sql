CREATE DATABASE LIBRARY;
USE LIBRARY;
CREATE TABLE PUBLISHER
(
    PUBLISHER_NAME VARCHAR(20),
    PHONE VARCHAR(10),
    ADDRESS VARCHAR(20),
    PRIMARY KEY(PUBLISHER_NAME)
);
DESC PUBLISHER;
INSERT INTO PUBLISHER VALUES("HACHETTE","1234567899","BANGALORE");
INSERT INTO PUBLISHER VALUES("PENGUIN","7234567899","CHENNAI");
INSERT INTO PUBLISHER VALUES("WESTSIDE","3934567899","MUMBAI");
INSERT INTO PUBLISHER VALUES("ABACUS","3334567899","BANGALORE");
SELECT * FROM PUBLISHER;


CREATE TABLE BOOK
(
    BOOK_ID VARCHAR(5),
    TITLE VARCHAR(20),
    PUBLISHER_NAME VARCHAR(20),
    PUB_YEAR VARCHAR(4),
    PRIMARY KEY(BOOK_ID),
    FOREIGN KEY(PUBLISHER_NAME) REFERENCES PUBLISHER(PUBLISHER_NAME) ON DELETE CASCADE
);
DESC BOOK;
INSERT INTO BOOK VALUES("100","THE ALCHEMIST","HACHETTE","2002");
INSERT INTO BOOK VALUES("101","THE KITE RUNNER","ABACUS","1992");
INSERT INTO BOOK VALUES("102","COSMOS","HACHETTE","1972");
INSERT INTO BOOK VALUES("103","HARDY BOYS","WESTSIDE","1999");
SELECT * FROM BOOK;

CREATE TABLE BOOK_AUTHOR
(
    BOOK_ID VARCHAR(5),
    AUTHOR_NAME VARCHAR(20),
    PRIMARY KEY(BOOK_ID,AUTHOR_NAME),
    FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE
);
DESC BOOK_AUTHOR;
INSERT INTO BOOK_AUTHOR VALUES("100","PAULO COELHO");
INSERT INTO BOOK_AUTHOR VALUES("101","KHALED");
INSERT INTO BOOK_AUTHOR VALUES("102","CARL SAGAN");
INSERT INTO BOOK_AUTHOR VALUES("103","DAVID");
SELECT * FROM BOOK_AUTHOR;

CREATE TABLE LIBRARY_PROGRAMME
(
    PROGRAMME_ID VARCHAR(5),
    ADDRESS VARCHAR(20),
    BRANCH_NAME VARCHAR(20),
    PRIMARY KEY(PROGRAMME_ID)
);
DESC LIBRARY_PROGRAMME;
INSERT INTO LIBRARY_PROGRAMME VALUES("500","BANGALORE","BASAVANGUDI");
INSERT INTO LIBRARY_PROGRAMME VALUES("501","CHENNAI","ADYAR");
INSERT INTO LIBRARY_PROGRAMME VALUES("502","MUMBAI","BANDRA");
INSERT INTO LIBRARY_PROGRAMME VALUES("503","BANGALORE","JAYANAGAR");
SELECT * FROM LIBRARY_PROGRAMME;

CREATE TABLE BOOK_COPIES
(
    BOOK_ID VARCHAR(5),
    PROGRAMME_ID VARCHAR(5),
    NO_OF_COPIES INT,
    PRIMARY KEY(BOOK_ID,PROGRAMME_ID),
    FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
    FOREIGN KEY(PROGRAMME_ID) REFERENCES LIBRARY_PROGRAMME(PROGRAMME_ID) ON DELETE CASCADE
);
DESC BOOK_COPIES;
INSERT INTO BOOK_COPIES VALUES("100","500",5);
INSERT INTO BOOK_COPIES VALUES("101","501",1);
INSERT INTO BOOK_COPIES VALUES("102","502",9);
INSERT INTO BOOK_COPIES VALUES("103","503",9);
SELECT * FROM BOOK_COPIES;

CREATE TABLE CARD
(
    CARD_NO VARCHAR(10) PRIMARY KEY
);
DESC CARD;
INSERT INTO CARD VALUES("1000");
INSERT INTO CARD VALUES("1001");
INSERT INTO CARD VALUES("1002");
INSERT INTO CARD VALUES("1003");
SELECT * FROM CARD;

CREATE TABLE BOOK_LENDING
(
    BOOK_ID VARCHAR(5),
    PROGRAMME_ID VARCHAR(5),
    CARD_NO VARCHAR(10),
    DATE_OUT DATE,
    DUE_DATE DATE,
    PRIMARY KEY(BOOK_ID,PROGRAMME_ID,CARD_NO),
    FOREIGN KEY(BOOK_ID) REFERENCES BOOK(BOOK_ID) ON DELETE CASCADE,
    FOREIGN KEY(PROGRAMME_ID) REFERENCES LIBRARY_PROGRAMME(PROGRAMME_ID) ON DELETE CASCADE,
    FOREIGN KEY(CARD_NO) REFERENCES CARD(CARD_NO) ON DELETE CASCADE 
);
DESC BOOK_LENDING;
INSERT INTO BOOK_LENDING VALUES("100","500","1000","2022-10-10","2023-01-12");
INSERT INTO BOOK_LENDING VALUES("101","501","1000","2022-09-10","2023-02-12");
INSERT INTO BOOK_LENDING VALUES("102","502","1000","2022-07-10","2022-09-12");
INSERT INTO BOOK_LENDING VALUES("100","500","1001","2022-10-10","2023-01-12");
SELECT * FROM BOOK_LENDING;

SELECT B.BOOK_ID,B.TITLE,B.PUBLISHER_NAME,A.AUTHOR_NAME,BC.NO_OF_COPIES FROM BOOK B,BOOK_AUTHOR A,BOOK_COPIES BC WHERE B.BOOK_ID = A.BOOK_ID AND A.BOOK_ID = BC.BOOK_ID;

SELECT CARD_NO FROM BOOK_LENDING WHERE DATE_OUT BETWEEN "2022-09-10" AND "2023-02-12" GROUP BY CARD_NO HAVING COUNT(CARD_NO)>1;

DELETE FROM BOOK WHERE TITLE="HARDY BOYS";

CREATE VIEW PUB_YEAR AS SELECT PUB_YEAR FROM BOOK;
SELECT * FROM PUB_YEAR;

CREATE VIEW CURRENT AS SELECT B.BOOK_ID,B.TITLE,BC.NO_OF_COPIES FROM BOOK B,BOOK_COPIES BC WHERE B.BOOK_ID = BC.BOOK_ID;
SELECT * FROM CURRENT;
