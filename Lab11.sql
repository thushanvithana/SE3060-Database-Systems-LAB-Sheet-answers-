-- Create the client table
CREATE TABLE client (
  clno CHAR(3) PRIMARY KEY,
  name VARCHAR(12),
  address VARCHAR(30)
);

-- Create the stock table
CREATE TABLE stock (
  company CHAR(7) PRIMARY KEY,
  price NUMBER(6, 2),
  dividend NUMBER(4, 2),
  eps NUMBER(4, 2)
);

-- Create the trading table
CREATE TABLE trading (
  company CHAR(7),
  exchange VARCHAR(12),
  PRIMARY KEY (company, exchange)
);

-- Create the purchase table with foreign keys
CREATE TABLE purchase (
  clno CHAR(3),
  company CHAR(7),
  pdate DATE,
  qty NUMBER(6),
  price NUMBER(6, 2),
  PRIMARY KEY (clno, company, pdate),
  FOREIGN KEY (clno) REFERENCES client(clno),
  FOREIGN KEY (company) REFERENCES stock(company)
);

-- Insert sample data into client table
INSERT INTO client VALUES ('c01', 'John Smith', '3 East Av, Bentley, WA 6102');
INSERT INTO client VALUES ('c02', 'Jill Brody', '42 Bent St, Perth, WA 6001');

-- Insert sample data into stock table
INSERT INTO stock VALUES ('BHP', 10.50, 1.50, 3.20);
INSERT INTO stock VALUES ('IBM', 70.00, 4.25, 10.00);
INSERT INTO stock VALUES ('INTEL', 76.50, 5.00, 12.40);
INSERT INTO stock VALUES ('FORD', 40.00, 2.00, 8.50);
INSERT INTO stock VALUES ('GM', 60.00, 2.50, 9.20);
INSERT INTO stock VALUES ('INFOSYS', 45.00, 3.00, 7.80);

-- Insert sample data into trading table
INSERT INTO trading VALUES ('BHP', 'Sydney');
INSERT INTO trading VALUES ('BHP', 'New York');
INSERT INTO trading VALUES ('IBM', 'New York');
INSERT INTO trading VALUES ('IBM', 'London');
INSERT INTO trading VALUES ('IBM', 'Tokyo');
INSERT INTO trading VALUES ('INTEL', 'New York');
INSERT INTO trading VALUES ('INTEL', 'London');
INSERT INTO trading VALUES ('FORD', 'New York');
INSERT INTO trading VALUES ('GM', 'New York');
INSERT INTO trading VALUES ('INFOSYS', 'New York');

-- Insert sample data into purchase table
INSERT INTO purchase VALUES ('c01', 'BHP', TO_DATE('02/10/01', 'DD/MM/YY'), 1000, 12.00);
INSERT INTO purchase VALUES ('c01', 'BHP', TO_DATE('08/06/02', 'DD/MM/YY'), 2000, 10.50);
INSERT INTO purchase VALUES ('c01', 'IBM', TO_DATE('12/02/00', 'DD/MM/YY'), 500, 58.00);
INSERT INTO purchase VALUES ('c01', 'IBM', TO_DATE('10/04/01', 'DD/MM/YY'), 1200, 65.00);
INSERT INTO purchase VALUES ('c01', 'INFOSYS', TO_DATE('11/08/01', 'DD/MM/YY'), 1000, 64.00);
INSERT INTO purchase VALUES ('c02', 'INTEL', TO_DATE('30/01/00', 'DD/MM/YY'), 300, 35.00);
INSERT INTO purchase VALUES ('c02', 'INTEL', TO_DATE('30/01/01', 'DD/MM/YY'), 400, 54.00);
INSERT INTO purchase VALUES ('c02', 'INTEL', TO_DATE('02/10/01', 'DD/MM/YY'), 200, 60.00);
INSERT INTO purchase VALUES ('c02', 'FORD', TO_DATE('05/10/99', 'DD/MM/YY'), 300, 40.00);
INSERT INTO purchase VALUES ('c02', 'GM', TO_DATE('12/12/00', 'DD/MM/YY'), 500, 55.50);







--(a
SELECT c.name AS "Client Name", p.company AS "Stock Name", s.price AS "Current Price", s.dividend AS "Last Dividend", s.eps AS "Earnings Per Share"
FROM client c
JOIN purchase p ON c.clno = p.clno
JOIN stock s ON p.company = s.company;

--(b
SELECT c.name AS "Client Name", p.company AS "Stock Name", SUM(p.qty) AS "Total Shares Held", 
       ROUND(SUM(p.qty * p.price) / SUM(p.qty), 2) AS "Average Purchase Price"
FROM client c
JOIN purchase p ON c.clno = p.clno
GROUP BY c.name, p.company;

--(c
SELECT t.company AS "Stock Name", c.name AS "Client Name", p.qty AS "Shares Held",
       ROUND(p.qty * s.price, 2) AS "Current Value"
FROM trading t
JOIN purchase p ON t.company = p.company
JOIN client c ON p.clno = c.clno
JOIN stock s ON t.company = s.company
WHERE t.exchange = 'New York';















