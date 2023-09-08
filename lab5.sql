SET serveroutput on

-- Exercise 1
DECLARE
  var_company_name CHAR(7) := 'IBM';
  var_stock NUMBER(10,2);
BEGIN
  SELECT price INTO var_stock FROM stock WHERE company = var_company_name;
  DBMS_OUTPUT.PUT_LINE('The stock price of ' || var_company_name || ' is ' || var_stock || ' dollars');
END;
/

-- Exercise 2
DECLARE
  var_company_name CHAR(7) := 'IBM';
  var_stock NUMBER(10,2);
BEGIN
  SELECT price INTO var_stock FROM stock WHERE company = var_company_name;
  
  IF var_stock < 45 THEN
    DBMS_OUTPUT.PUT_LINE('Current price is very low!');
  ELSIF var_stock < 55 THEN
    DBMS_OUTPUT.PUT_LINE('Current price is low!');
  ELSIF var_stock < 65 THEN
    DBMS_OUTPUT.PUT_LINE('Current price is medium!');
  ELSIF var_stock < 75 THEN
    DBMS_OUTPUT.PUT_LINE('Current price is medium high!');
  ELSE
    DBMS_OUTPUT.PUT_LINE('Current price is high!');
  END IF;
END;
/

-- Exercise 3
DECLARE
  i NUMBER := 9;
  j NUMBER := 1;
BEGIN
  WHILE i >= 1 LOOP
    j := 1;
    
    WHILE j <= i LOOP
      DBMS_OUTPUT.PUT(TO_CHAR(i, '999'));
      j := j + 1;
    END LOOP;
    
    DBMS_OUTPUT.NEW_LINE;
    i := i - 1;
  END LOOP;
END;
/

-- Exercise 4
DECLARE
  CURSOR purchase_cur IS
    SELECT clno, company, pdate, qty
    FROM purchase;
  purchase_rec purchase_cur%ROWTYPE;
BEGIN
  FOR purchase_rec IN purchase_cur LOOP
    IF purchase_rec.pdate < DATE '2000-01-01' THEN
      UPDATE purchase SET qty = qty + 150 WHERE clno = purchase_rec.clno AND company = purchase_rec.company AND pdate = purchase_rec.pdate;
    ELSIF purchase_rec.pdate < DATE '2001-01-01' THEN
      UPDATE purchase SET qty = qty + 100 WHERE clno = purchase_rec.clno AND company = purchase_rec.company AND pdate = purchase_rec.pdate;
    ELSIF purchase_rec.pdate < DATE '2002-01-01' THEN
      UPDATE purchase SET qty = qty + 50 WHERE clno = purchase_rec.clno AND company = purchase_rec.company AND pdate = purchase_rec.pdate;
    END IF;
  END LOOP;
  COMMIT; -- Add a commit statement to save changes
END;
/

-- Exercise 5 - Explicit cursors
DECLARE
  CURSOR purchase_cur IS
    SELECT clno, company, pdate, qty
    FROM purchase;
  purchase_rec purchase_cur%ROWTYPE;
BEGIN
  FOR purchase_rec IN purchase_cur LOOP
    IF purchase_rec.pdate < DATE '2000-01-01' THEN
      UPDATE purchase SET qty = qty + 150 WHERE clno = purchase_rec.clno AND company = purchase_rec.company AND pdate = purchase_rec.pdate;
    ELSIF purchase_rec.pdate < DATE '2001-01-01' THEN
      UPDATE purchase SET qty = qty + 100 WHERE clno = purchase_rec.clno AND company = purchase_rec.company AND pdate = purchase_rec.pdate;
    ELSIF purchase_rec.pdate < DATE '2002-01-01' THEN
      UPDATE purchase SET qty = qty + 50 WHERE clno = purchase_rec.clno AND company = purchase_rec.company AND pdate = purchase_rec.pdate;
    END IF;
  END LOOP;
  COMMIT; -- Add a commit statement to save changes
END;
/

-- Display the updated purchase table
SELECT * FROM purchase;
