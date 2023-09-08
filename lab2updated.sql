create type dept_t
/

create type emp_t as object
(
    empno     char(6),
    firstname varchar(12),
    lastname  varchar(12),
    workdept  ref dept_t,
    sex       char(1),
    birthday  date,
    salary    number(8, 2)
)
/

create type dept_t as object
(
    deptno   char(3),
    deptname varchar(36),
    mgrno    ref emp_t,
    admrdept ref dept_t
)
/



create table oremp of emp_t
(
    constraint oremp_pk primary key (empno),
    constraint oremp_firstname_nn firstname not null,
    constraint oremp_lastname_nn lastname not null,
    constraint oremp_sex_check check (sex='m' or sex='m' or sex='f' or sex='f')
)
/


create table ordept of dept_t
(
    constraint ordept_pk primary key (deptno),
    constraint ordept_deptname_nn deptname not null,
    constraint ordept_mgrno_fk foreign key (mgrno) references oremp,
    constraint ordept_admrdept_fk foreign key (admrdept) references ordept
)
/

alter table oremp
    add constraint oremp_workdept_fk foreign key (workdept) references ordept
/


insert into ordept
values (dept_t('a00', 'spiffy computer service div', null, null))
/
insert into ordept
values (dept_t('b01', 'planning', null, (select ref(d) from ordept d where d.deptno = 'a00')))
/
insert into ordept
values (dept_t('c01', 'information center', null, (select ref(d) from ordept d where d.deptno = 'a00')))
/
insert into ordept
values (dept_t('d01', 'development center', null, (select ref(d) from ordept d where d.deptno = 'c01')))
/

update ordept d
set d.admrdept=(select ref(d) from ordept d where d.deptno = 'a00')
where d.deptno = 'a00'
/




insert into oremp
values (emp_t('000010', 'christine', 'hass', (select ref(d) from ordept d where d.deptno = 'a00'), 'f', '14-aug-1953', 72750))
/
insert into oremp
values (emp_t('000020', 'michell', 'thompson', (select ref(d) from ordept d where d.deptno = 'b01'), 'm', '02-feb-1968', 61250))
/
insert into oremp
values (emp_t('000030', 'sally', 'kwan', (select ref(d) from ordept d where d.deptno = 'c01'), 'f', '11-may-1971', 58250))
/
insert into oremp
values (emp_t('000060', 'irving', 'stern', (select ref(d) from ordept d where d.deptno = 'd01'), 'm', '07-jul-1965', 55555))
/
insert into oremp
values (emp_t('000070', 'eva', 'pulaksi', (select ref(d) from ordept d where d.deptno = 'd01'), 'f', '26-may-1973', 56170))
/
insert into oremp
values (emp_t('000050', 'jhon', 'geyer', (select ref(d) from ordept d where d.deptno = 'c01'), 'm', '15-sep-1955', 60175))
/
insert into oremp
values (emp_t('000090', 'eileen', 'henderson', (select ref(d) from ordept d where d.deptno = 'b01'), 'f', '15-may-1961', 49750))
/
insert into oremp
values (emp_t('000100', 'theodore', 'spenser', (select ref(d) from ordept d where d.deptno = 'b01'), 'm', '18-aug-1976', 46150))
/
commit
/



update ordept d
set d.mgrno = (select ref(e) from oremp e where e.empno = '000010')
where d.deptno = 'a00'
/
update ordept d
set d.mgrno = (select ref(e) from oremp e where e.empno = '000020')
where d.deptno = 'b01'
/
update ordept d
set d.mgrno = (select ref(e) from oremp e where e.empno = '000030')
where d.deptno = 'c01'
/
update ordept d
set d.mgrno = (select ref(e) from oremp e where e.empno = '000060')
where d.deptno = 'd01'
/
    
commit
/


