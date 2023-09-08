
create type emp_t as object(
    empno char(6),
    fname varchar(12),
    lname varchar(15),
    workdept REF department_t,
    sex char(1),
    bdate date, 
    salary number(8,2)
)
/
    
create or replace type department_t as object(
    deptno char(3),
    deptName varchar(36),
    mgrno REF emp_t,
    admrdept REF department_t
)
/

create table OREMP of emp_t(
    constraint OREMP_PK primary key (empno),
    constraint OREMP_FNAME fname not null,
    constraint OREMP_LNAME lname not null,
    constraint fname not null,
    lname not null
)
/
    
create table ORDEPT of department_t(
    deptno PRIMARY KEY,
    deptName not null
)
/


INSERT INTO OREMP (empno, fname, lname, workdept, sex, bdate, salary) 
    VALUES ('000010', 'CHRISTINE', 'HAAS', null, 'F', '14-AUG-1953', 72750);
INSERT INTO OREMP (empno, fname, lname, workdept, sex, bdate, salary) 
    VALUES ('000020', 'MICHAEL', 'THOMPSON', null, 'M', '02-FEB-1968', 61250);
INSERT INTO OREMP (empno, fname, lname, workdept, sex, bdate, salary) 
    VALUES ('000030', 'SALLY', 'KWAN', null, 'F', '11-MAY-1971', 58250);
INSERT INTO OREMP (empno, fname, lname, workdept, sex, bdate, salary) 
    VALUES ('000060', 'IRVING', 'STERN', null, 'M', '07-JUL-1965', 55555);
INSERT INTO OREMP (empno, fname, lname, workdept, sex, bdate, salary) 
    VALUES ('000070', 'EVA', 'PULASKI', null, 'F', '26-MAY-1973', 56170);

INSERT INTO ORDEPT (deptno, deptName, mgrno, admrdept) 
    VALUES ('A00', 'SPIFFY COMPUTER SERVICE DIV.', (select ref(e) from OREMP e where e.empno = '000010') , null);
INSERT INTO ORDEPT (deptno, deptName, mgrno, admrdept) 
    VALUES ('B01', 'PLANNING', (select ref(e) from OREMP e where e.empno = '000020'), null);
INSERT INTO ORDEPT (deptno, deptName, mgrno, admrdept) 
    VALUES ('C01', 'INFORMATION CENTRE', (select ref(e) from OREMP e where e.empno = '000030'), null);
INSERT INTO ORDEPT (deptno, deptName, mgrno, admrdept) 
    VALUES ('D01', 'DEVELOPMENT CENTRE', (select ref(e) from OREMP e where e.empno = '000060'), null);


UPDATE OREMP 
    SET workdept = (SELECT REF(d) FROM ORDEPT d WHERE d.deptno = 'A00') WHERE empno = '000010';
UPDATE OREMP 
    SET workdept = (SELECT REF(d) FROM ORDEPT d WHERE d.deptno = 'B01') WHERE empno = '000020';
UPDATE OREMP 
    SET workdept = (SELECT REF(d) FROM ORDEPT d WHERE d.deptno = 'C01') WHERE empno = '000030';
UPDATE OREMP 
    SET workdept = (SELECT REF(d) FROM ORDEPT d WHERE d.deptno = 'D01') WHERE empno = '000060';
UPDATE OREMP 
    SET workdept = (SELECT REF(d) FROM ORDEPT d WHERE d.deptno = 'D01') WHERE empno = '000070';

UPDATE ORDEPT 
    SET admrdept = (SELECT REF(d) FROM ORDEPT d WHERE d.deptno = 'A00') WHERE deptno = 'A00';
UPDATE ORDEPT 
    SET admrdept = (SELECT REF(d) FROM ORDEPT d WHERE d.deptno = 'A00') WHERE deptno = 'B01';
UPDATE ORDEPT 
    SET admrdept = (SELECT REF(d) FROM ORDEPT d WHERE d.deptno = 'A00') WHERE deptno = 'C01';
UPDATE ORDEPT 
    SET admrdept = (SELECT REF(d) FROM ORDEPT d WHERE d.deptno = 'C01') WHERE deptno = 'D01';


select d.deptname, d.mgrno.lname
from ORDEPT d;

select e.empno, e.lname, e.workdept.deptname
from OREMP e;

select d.deptno, d.deptName, d.admrdept.deptname
from ORDEPT d;

select d.deptno, d.deptName, d.admrdept.deptname, d.mgrno.lname
from ORDEPT d;

select e.empno, e.fname, e.lname, e.salary, d.mgrno.lname, d.mgrno.salary
from OREMP e, ORDEPT d
where e.empno = d.mgrno.empno;

select d.deptno,
    d.deptName,
    AVG(CASE WHEN e.sex = 'M' THEN e.salary ELSE NULL END) AS avg_salary_male,
    AVG(CASE WHEN e.sex = 'F' THEN e.salary ELSE NULL END) AS avg_salary_female
from OREMP e, ORDEPT d
where e.empno = d.mgrno.empno
group by d.deptno, d.deptName;