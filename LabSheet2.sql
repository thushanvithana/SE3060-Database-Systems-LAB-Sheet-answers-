--dummy data type
create type dept_t
/
create type emp_t as object(
    empno char(6),
    firstname varchar(12),
    lastname varchar(15),
    workdept ref dept_t,
    sex char(1),
    birthday date,
    salary number(8,2)
) 
/

create type dept_t as object(
    deptno char(3),
    deptName varchar(36),
    mgrno ref emp_t,
    admrdept ref dept_t
)
/



create table oremp of emp_t(
    constraint oremp_pk  primary key(empno),
    constraint oremp_firstname_nn firstname not null,
    constraint oremp_lastname_nn lastname not null,
    constraint oremp_sec_ck check sex='M' or sex='F' or sex='m' or sex='f'
)
/

create table ordept of dept_t(
    constraint ordept_pk  primary key(deptno),
    constraint ordept_deptname_nn deptname not null,
    constraint ordept_mgrno_fk foreign key (mgrno) references oremp,
    constraint ordept_admrdept_fk foreign key(admrdept) references ordept
)
/


select * from ordept








