
DROP TABLE stocks;
DROP TABLE clients;
DROP TYPE stock_t;


 DROP TYPE client_t;
/

 DROP TYPE Dept_t;
 /

 DROP TYPE investment_t;
 /

 DROP TYPE exchanges_array;
/

 DROP TYPE address_t;
/






create type Dept_t

create type Emp_t as object(

eno number(4),
ename varchar2(15),
edept ref dept_t

)





-- Create the Dep_t type
create type Dep_t


create or replace type Dep_t as object (
    dno number(2),
    dname varchar2(12)
);

-- Create the Emp_t type
create or replace type Emp_t as object (
    eno number(4),
    ename varchar2(15),
    edept ref Dep_t,
    salary number(8,2)
);

-- Create the Dept_t type
create or replace type Dept_t as object (
    dno number(2),
    dname varchar2(12),
    mgr ref Emp_t
);

-- Create the Proj_t type
create or replace type Proj_t as object (
    pno number(4),
    pname varchar2(15),
    pdept ref Dept_t,
    budget number(10,2)
);

-- Create tables
create table Emp of Emp_t (
    eno primary key,
    edept references Dep_t
);

create table Dept of Dept_t (
    dno primary key,
    mgr references Emp
);

create table Proj of Proj_t (
    pno primary key,
    pdept references Dept
);


select * from Dept_t




--(a) Find the name and salary of managers of all departments. Display the department number, manager name and salary.
select d.dno, d.mgr.ename, d.mgr.salary
from Dept d

--(b) For projects that have budgets over $50000, get the project name, and the name of the manager of the department in charge of the project.
SELECT p.pname, p.mgr.ename
FROM Proj p 
where p.budgets >  50000

--(c) For departments that are in charge of projects, find the department number, department name and total budget of all its projects together.
select p.pdept.dno, p.pdept.dname, sum(p.budget)
from Proj p
group by p.pdept.dno, p.pdept.dname

-- (d) Find the manager’s name who is controlling the project with the largest budget
select 
from 
where p.budjet = p.max(budget)




table




