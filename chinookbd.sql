---- from sql assignment: 2.1
--SELECT * FROM EMPLOYEE;
--
--SELECT * 
--FROM EMPLOYEE
--WHERE LASTNAME='King';
--
--SELECT * 
--FROM EMPLOYEE
--WHERE FIRSTNAME='Andrew'
--and REPORTSTO IS NULL;
--
---- 2.2 Order by
--SELECT *
--FROM ALBUM
--ORDER BY TITLE DESC;
--
--SELECT FIRSTNAME
--FROM CUSTOMER
--ORDER BY CITY ASC;
--
---- 2.3 insert into
--INSERT INTO GENRE (GENREID, NAME)
--VALUES (26, 'Classic Rock');
--
--INSERT INTO GENRE (GENREID, NAME)
--VALUES (27, 'Beat boxing');
--commit;
--
--INSERT INTO EMPLOYEE
--VALUES (9, 'Lee', 'Yang', 'IT Staff', 1, '17-Jan-65', '18-dec-10', '1234 Joshua St', 'Palmdale', 'CA', 'USA', '92115', '1 (818)534-2872', '+1 (818) 273-4927', 'yangy@chinookcorp.com');
--
--INSERT INTO EMPLOYEE
--VALUES (10, 'bob', 'joe', 'IT Staff', 1, '15-Jan-63', '18-dec-10', '1234 Aloha St', 'Reston', 'VI', 'USA', '90202', '1 (818)123-2872', '+1 (818) 754-4927', 'bobby@chinookcorp.com');
--commit;
--
--INSERT INTO CUSTOMER
--VALUES(60, 'Joes', 'Garcia', 'revature', '648 Sunny St', 'Orange', 'CA', 'USA', '01928', '182 564 2655', '815 821 5746', 'jose@revature.com', 4);
--
--INSERT INTO CUSTOMER
--VALUES (61, 'Lucky', 'Duck', 'revature', '1236 Blossom Dr', 'Orange', 'CA', 'USA', '23149', '174 369 8164', '815 645 3195', 'luckyduck@revature.com', 4);
--commit;
--
---- 2.4 UPDATE
--UPDATE CUSTOMER
--SET FIRSTNAME = 'Robert', LASTNAME = 'Walter'
--WHERE CUSTOMERID = 32;
--commit;
--
---- cannot find artist "creedence clearwater revival" 
----UPDATE ARTIST
----SET NAME = 'CCR'
----WHERE ARTISTID = 
--
---- 2.5 LIKE COMMAND
--SELECT *
--FROM INVOICE
--WHERE BILLINGADDRESS
--LIKE 'T%';
--
---- 2.6 BETWEEN COMMAND
--SELECT *
--FROM INVOICE
--WHERE TOTAL
--BETWEEN 15 AND 50;
--
--SELECT *
--FROM EMPLOYEE
--WHERE HIREDATE
--BETWEEN '01-JUN-03' AND '01-MAR-04';

---- 2.7 DELETE COMMAND
---- Delete a record in customer table where the name is robert walter
---- find constraints that rely on this, and find out how to resolve them

---- 3.0 SQL FUNCTIONS
---- 3.1 SYSTEM DEFINED FUNCTIONS

--returns time
CREATE OR REPLACE FUNCTION gettime
RETURN TIMESTAMP WITH TIME ZONE AS times TIMESTAMP WITH TIME ZONE;
BEGIN
    times := current_timestamp;
    return times;
end;
/

DECLARE TIMES TIMESTAMP WITH TIME ZONE;
BEGIN
    TIMES:=gettime;
    dbms_output.put_line('current time '||times);
END;
/

-- create a function that returns the length of a mediatype from the mediatype
-- table
--

-- 3.2 SYSTEM DEFINED AGGREGATE FUNCTIONS
-- create a function that returns the average total of all invoices
CREATE OR REPLACE FUNCTION find_avg_track_price
RETURN NUMBER AS avgTotal NUMBER;     --FUNC DEF
BEGIN
    SELECT AVG(TOTAL) INTO avgTotal FROM INVOICE;     --selecting total colomn from invoice then avg
    RETURN avgTotalFunc;
END;
/

DECLARE total NUMBER;
BEGIN
    total:= find_avg_track_price;
    dbms_output.put_line('average total is '||total);
END;
/

-- create a function that returns the most expensive track
CREATE OR REPLACE FUNCTION find_max_track
RETURN NUMBER AS expTrack NUMBER;
BEGIN
    SELECT MAX(UNITPRICE) INTO expTrack FROM INVOICELINE;
    RETURN expTrack;
END;
/
DECLARE track NUMBER;
BEGIN
    track:=find_max_track;
    dbms_output.put_line('average total is '||track);
END;
/

-- 3.3 USER DEFNINED FUNCTION
-- function that returns the average price of invoiceline items in the invoiceline table
--

-- 3.4 USER DEFINED TABLE VALUED FUNCTION
-- function that returns all employees who are born after 1968
--CREATE OR REPLACE FUNCTION FIND_YOUNG_EMPLOYEES
--RETURN DATE AS youngEmployee DATE;
--BEGIN
--        SELECT FIRSTNAME INTO youngEmployee FROM EMPLOYEE
--        WHERE BIRTHDATE > 01-01-68;
--        RETURN youngEmployee;
--END;
--/


-- 4 STORED PROCEDURES
-- 4.1
-- selects the first and last names of all the employees
--Cursors
CREATE OR REPLACE PROCEDURE
GET_ALL_NAMES(S OUT SYS_REFCURSOR) AS
BEGIN
    OPEN S FOR
    SELECT EMPLOYEEID, FIRSTNAME, LASTNAME FROM EMPLOYEE;
END;
/

DECLARE
    S SYS_REFCURSOR;
    SOME_ID EMPLOYEE.EMPLOYEEID%TYPE;
    SOME_FIRSTNAME EMPLOYEE.FIRSTNAME%TYPE;
    SOME_LASTNAME EMPLOYEE.LASTNAME%TYPE;

BEGIN
    GET_ALL_NAMES(S);
    LOOP
        FETCH S INTO SOME_ID, SOME_FIRSTNAME, SOME_LASTNAME;
        EXIT WHEN S%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(SOME_ID||' IS CURRENT ID, '||SOME_FIRSTNAME||' '||SOME_LASTNAME||' IS CURRENT NAME');
    END LOOP;
    CLOSE S;
END;
/





-- 4.2 .1
-- Stored procedure that updates the personal information of an employee
CREATE OR REPLACE PROCEDURE
UPDATE_EMPLOYEE AS
BEGIN
    UPDATE EMPLOYEE
    SET TITLE = 'NEW BOSS MAN'
    WHERE EMPLOYEEID = 10;
    COMMIT;
END;
/
DECLARE

BEGIN
    UPDATE_EMPLOYEE;
    --DBMS_OUTPUT.PUT_LINE(EMPLOYEEID||'EMPLOYEE IS NOW'||TITLE);
END;
/

-- 4.2.2
-- stored procedure that returns the managers of an employee

-- 4.3 stored procedure output parameters
-- stored procedure that returns the name and company of a customer

-- 5 TRANSACTIONS
-- usually nested within a stored procedure
-- 5.1.1
-- create a transaction that given a invoiced will delete that invoice
-- there may be constraints that rely on this, find and resolve them

-- 5.1.2
-- create a transaction nested within a stored procedure that inserts a new record
-- in the customer table

-- 6.0 TRIGGERS
-- will create triggers that work when certain dml statements are executed on a table

-- 6.1 AFTER/FOR
-- 6.1.1
-- create an after insert trigger on the employee table fired after a new record 
-- is inserted into the table
-- 6.1.2
-- create an after update trigger on the album table that fires after a row is 
-- inserted into the table
-- 6.1.3
-- create an after delete trigger on the customer table that fires after a row is 
-- deleted from the table

-- 7 JOINS
-- combining various tables through the use of joins

-- 7.1 INNER
-- create an outer join that joins the customer and invoice table
-- specifying the customer id, firstname, lastname, invoiceID, and total

-- 7.2 OUTER
-- joins the customer and invoice table, specifying the CustomerID, firstname, 
-- lastname, invoiceid, and total

-- 7.3 RIGHT
-- joins album and artist and sorts by artist name in ascending order

-- 7.4 CROSS
-- joins album and artist and sorts by artist name in ascending order

-- 7.5 SELF
-- self join on the meployee table, joining on the reporsto column

-- 7.6 COMPLICATED JOIN ASSIGNMENT
-- create an inner join between all tables in the chinook database

-- 8.0 ADMINISTRATION
-- learn to backup databse and restore the database
-- 8.1
-- create a .bak file for chinook database






-- 3.2 SYSTEM DEFINED AGGREGATE FUNCTIONS
-- create a function that returns the average total of all invoices
CREATE OR REPLACE FUNCTION find_avg_track_price
RETURN NUMBER AS avgTotal NUMBER;     --FUNC DEF
BEGIN
    SELECT AVG(TOTAL) INTO avgTotal FROM INVOICE;     --selecting total colomn from invoice then avg
    RETURN avgTotalFunc;
END;
/

DECLARE total NUMBER;
BEGIN
    total:= find_avg_track_price;
    dbms_output.put_line('average total is '||total);
END;
/

-- create a function that returns the most expensive track
CREATE OR REPLACE FUNCTION find_max_track
RETURN NUMBER AS expTrack NUMBER;
BEGIN
    SELECT MAX(UNITPRICE) INTO expTrack FROM INVOICELINE;
    RETURN expTrack;
END;
/
DECLARE track NUMBER;
BEGIN
    track:=find_max_track;
    dbms_output.put_line('average total is '||track);
END;
/


-- 3.4 USER DEFINED TABLE VALUED FUNCTION
-- function that returns all employees who are born after 1968
CREATE OR REPLACE FUNCTION FIND_YOUNG_EMPLOYEES
RETURN DATE AS youngEmployee DATE;
BEGIN
        SELECT FIRSTNAME INTO youngEmployee FROM EMPLOYEE
        WHERE BIRTHDATE > 01-01-68;
        RETURN youngEmployee;
END;
/

-- 4 STORED PROCEDURES
-- 4.1
-- selects the first and last names of all the employees
--Cursors
CREATE OR REPLACE PROCEDURE
GET_ALL_NAMES(S OUT SYS_REFCURSOR) AS
BEGIN
    OPEN S FOR
    SELECT EMPLOYEEID, FIRSTNAME, LASTNAME FROM EMPLOYEE;
END;
/

DECLARE
    S SYS_REFCURSOR;
    SOME_ID EMPLOYEE.EMPLOYEEID%TYPE;
    SOME_FIRSTNAME EMPLOYEE.FIRSTNAME%TYPE;
    SOME_LASTNAME EMPLOYEE.LASTNAME%TYPE;

BEGIN
    GET_ALL_NAMES(S);
    LOOP
        FETCH S INTO SOME_ID, SOME_FIRSTNAME, SOME_LASTNAME;
        EXIT WHEN S%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(SOME_ID||' IS CURRENT ID, '||SOME_FIRSTNAME||' '||SOME_LASTNAME||' IS CURRENT NAME');
    END LOOP;
    CLOSE S;
END;
/


CREATE OR REPLACE PROCEDURE
UPDATE_EMPLOYEE AS
BEGIN
    UPDATE EMPLOYEE
    SET TITLE = 'NEW BOSS MAN'
    WHERE EMPLOYEEID = 10;
    COMMIT;
END;
/
DECLARE

BEGIN
    UPDATE_EMPLOYEE;
    --DBMS_OUTPUT.PUT_LINE(EMPLOYEEID||'EMPLOYEE IS NOW'||TITLE);
END;
/
-- 4.2.2
-- stored procedure that returns the managers of an employee
CREATE OR REPLACE PROCEDURE GET_MANAGERS AS
BEGIN
     SELECT REPORTSTO FROM EMPLOYEE
     WHERE EMPLOYEEID = 10;
     COMMIT;
END;
/
DECLARE
BEGIN
    GET_MANAGER;
END;
/
--------------------------------------------------------------------------------
-- 4.3 stored procedure output parameters
-- stored procedure that returns the name and company of a customer
CREATE OR REPLACE PROCEDURE GET_NAME_AND_COMPANY AS
BEGIN
    SELECT FIRSTNAME, LASTNAME, COMPANY FROM CHINOOK.CUSTOMER
    WHERE CUSTOMERID = 7;
    COMMIT;
END;
/
DECLARE
BEGIN
    GET_NAME_AND_COMPANY;
END;
/
-- 5 TRANSACTIONS
-- usually nested within a stored procedure
-- maintain data integrity
-- 5.1.1
-- create a transaction that given a invoiceid will delete that invoice
-- there may be constraints that rely on this, find and resolve them

-- 5.1.2
-- create a transaction nested within a stored procedure that inserts 
-- a new record
-- in the customer table
CREATE PROCEDURE NEW_CUSTOMER AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION
            INSERT INTO CHINOOK.CUSTOMER 
            VALUES (62, Bobby, Cat, null, null, null, null, null, null, null, null, bobcat@hotmail.com, null);
        COMMIT TRANSACTIOIN
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
    END CATCH
END


-- 6.0 TRIGGERS
-- will create triggers that work when certain dml statements are 
-- executed on a table

-- 6.1 AFTER/FOR
-- 6.1.1
-- create an after insert trigger on the employee table fired after a new record 
-- is inserted into the table
CREATE TRIGGER TR_EMPLOYEE_FOR_INSERT ON EMPLOYEE
FOR INSERT AS
BEGIN
    SELECT * FROM INSERTED   
END
/
INSERT INTO EMPLOYEE
VALUES (11, MANZA, MIKEY, null, null, null, null, null, null, null, null, null, null, null, null);
-- 6.1.2
-- create an after update trigger on the album table that fires after a row is 
-- inserted into the table
CREATE TRIGGER TR_ALBUM_FOR_UPDATE ON ALBUM
FOR UPDATE AS
BEGIN
    SELECT * FROM INSERTED
END
/
UPDATE ALBUM
SET TITLE = 'INAPROPRIATE'
WHERE ALBUMID = 2

-- 6.1.3
-- create an after delete trigger on the customer table that fires 
-- after a row is deleted from the table
CREATE TRIGGER TR_CUSTOMER_FOR_DELETE
FOR DELETE AS
BEGIN
    SELECT * FROM DELETED
END
/
DELETE FROM CUSTOMER WHERE CUSTOMERID = 61
-- 7 JOINS
-- combining various tables through the use of joins

-- 7.1 INNER
-- create an inner join that joins the customer and invoice table
-- specifying the name of customer and invoiceID
SELECT FIRSTNAME, LASTNAME, INVOICEID
FROM CUSTOMER
INNER JOIN INVOICE
ON CUSTOMER.CUSTOMERID = INVOICE.CUSTOMERID

-- 7.2 OUTER
-- joins the customer and invoice table, specifying the CustomerID, firstname, 
-- lastname, invoiceid, and total
SELECT CUSTOMERID, FIRSTNAME, LASTNAME, INVOICEID, TOTAL
LEFT OUTER JOIN  FROM CUSTOMER
JOIN INVOICE
ON CUSTOMER.CUSTOMERID = INVOICE.CUSTOMERID

-- 7.3 RIGHT
-- joins album and artist and specifying artist name and title
SELECT TITLE, NAME
FROM ALBUM
RIGHT OUTER JOIN ARTIST
ON ALBUM.ARTISTID = ARTIST.ARTISTID

-- 7.4 CROSS
-- joins album and artist and sorts by artist name in ascending order
SELECT  NAME
FROM ALBUM
CROSS JOIN ARTIST
ORDER BY NAME ASC

-- 7.5 SELF
-- self join on the meployee table, joining on the reporsto column
-- joining a table with itself
SELECT EMP.NAME AS EMPLOYEE, MANA.NAME AS MANAGER
FROM EMPLOYEE EMP
SELF JOIN EMPLOYEE MANA
ON EMP.REPORTSTO = MANA.EMPLOYEE

-- 7.6 COMPLICATED JOIN ASSIGNMENT
-- create an inner join between all tables in the chinook database

-- 8.0 ADMINISTRATION
-- learn to backup databse and restore the database
-- 8.1
-- create a .bak file for chinook database