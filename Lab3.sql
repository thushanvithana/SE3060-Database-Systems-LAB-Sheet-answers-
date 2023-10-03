--1)

CREATE TYPE exchanges_t AS VARRAY(3) OF VARCHAR2(40)
/
    
CREATE TYPE stocks_t AS OBJECT(
    company VARCHAR(12),
    currentPrice NUMBER(6,2),
    exchanges exchanges_t,
    dividend NUMBER(4,2),
    eps NUMBER(6,2)
)
/

CREATE TYPE Address_t AS OBJECT(
    streetNumber NUMBER,
    streetName VARCHAR2(20),
    suburb VARCHAR2(20),
    state VARCHAR(10),
    pin NUMBER(4)
)
/ 

--create invest type 
CREATE TYPE investments_t AS OBJECT(
    company REF stocks_t,
    purchasePrice NUMBER(6,2),
    investDate DATE,
    qty NUMBER(6)
)
/

--create invest table using invest type 
CREATE TYPE invest_table_type AS TABLE OF investments_t
/

--create client type 
CREATE TYPE clients_t AS OBJECT(
    cno NUMBER,
    cname VARCHAR(30),
    address Address_t,
    investments invest_table_type
)
/
    
--creating tables 
CREATE TABLE stocks_tbl of stocks_t(
    CONSTRAINT stocks_PK PRIMARY KEY(company)
    )
/

CREATE TABLE clients_tbl of clients_t(
    CONSTRAINT clients_PK PRIMARY KEY(cno)) NESTED TABLE investments STORE AS clients_investment_table
/

ALTER TABLE clients_investment_table
ADD SCOPE FOR (company) IS stocks_tbl
/

--2)
INSERT INTO stocks_tbl VALUES(stocks_t('BHP',10.50,exchanges_t('Sydney','New York'),1.50,3.20));
INSERT INTO stocks_tbl VALUES(stocks_t('IBM',70.00,exchanges_t('New York','London','Tokyo'),4.25,10.00));
INSERT INTO stocks_tbl VALUES(stocks_t('INTEL',76.50,exchanges_t('New York','London'),5.00,12.40));
INSERT INTO stocks_tbl VALUES(stocks_t('FORD',40.00,exchanges_t('New York'),2.00,8.50));
INSERT INTO stocks_tbl VALUES(stocks_t('GM',60.00,exchanges_t('New York'),2.50,9.20));
INSERT INTO stocks_tbl VALUES(stocks_t('INFOSYS',45.00,exchanges_t('New York'),3.00,7.80));

INSERT INTO clients_tbl VALUES(clients_t(1,'John Smith',Address_t(3,'East Av','Bentley','WA',6102),
invest_table_type(
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='BHP'),12.00,'02-oct-01',1000),
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='BHP'),10.50,'08-jun-02',2000),
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='IBM'),58.00,'12-feb-00',500),
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='IBM'),65.00,'10-apr-01',1200),
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='INFOSYS'),64.00,'11-aug-01',1000)
)))
/

INSERT INTO clients_tbl VALUES(clients_t(2,'Jill Brody',Address_t(42,'Bent St','Perth','WA',6001),
invest_table_type(
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='INTEL'),35.00,'30-jan-00',300),
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='INTEL'),54.00,'30-jan-01',400),
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='INTEL'),60.00,'02-oct-01',200),
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='FORD'),40.00,'05-oct-99',300),
    investments_t((SELECT REF(s) FROM stocks_tbl s WHERE s.company='GM'),55.50,'12-dec-00',500)
)))
/

--3)
--a)
SELECT cl.cname, ci.company.company, ci.company.currentPrice,  ci.company.dividend, ci.company.eps
FROM clients_tbl cl, TABLE(cl.investments) ci
/

--b)
SELECT cl.cname, ci.company.company, SUM(ci.qty) AS TOTAL, SUM(ci.qty*ci.purchasePrice)/SUM(ci.qty) AS AVERAGE
FROM clients_tbl cl, TABLE(cl.investments) ci
GROUP BY cl.cname, ci.company.company
/

--c)
SELECT ci.company.company AS stock, cl.cname, SUM(ci.qty) AS TOTAL, SUM(ci.qty*ci.company.currentPrice) AS PRICE
FROM stocks_tbl p, TABLE(p.exchanges) s, clients_tbl cl, TABLE(cl.investments) ci
WHERE s.COLUMN_VALUE in 'New York'
GROUP BY cl.cname, ci.company.company
/

--d)
SELECT cl.cname, SUM(ci.purchasePrice*ci.qty) AS PRICE
FROM clients_tbl cl, TABLE(cl.investments) ci
GROUP BY  cl.cname
/

--e)
SELECT cl.cname, SUM(ci.company.currentPrice*ci.qty - ci.purchasePrice*ci.qty) AS BOOK_PROFIT
FROM clients_tbl cl, TABLE(cl.investments) ci
GROUP BY  cl.cname
/


