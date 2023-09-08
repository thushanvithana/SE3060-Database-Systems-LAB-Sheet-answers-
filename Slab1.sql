--(a)
create type department_t 

create type employee_t as object(
    EMPNO char(6),
    FIRSTNAME VARCHAR(12),
    LASTNAME VARCHAR(15),
    WORKDEPT ref department_t,
    SEX CHAR(1),
    BIRTHDATE DATE,
    SALARY NUMBER(8,2)
)
/



create type department_t as object(
    DEPTNO CHAR(3),
    DEPTNAME VARCHAR(36),
    MGRNO ref employee_t,
    ADMRDEPT ref department_t
)
/

--how to delete types with attributes
drop type department_t force;
drop type employee_t force;


--how to find existing object
SELECT object_name, object_type
FROM all_objects
WHERE object_name = 'employee_t';


--(b)
create table OREMP of employee_t(
    CONSTRAINT OREMP_PK  primary key(EMPNO),
    CONSTRAINT OREMP_FIRSTNAME FIRSTNAME not null,
    CONSTRAINT OREMP_LASTNAME LASTNAME not null,
    CONSTRAINT OREMP_SEX_CHECK CHECK SEX='F' or SEX='f' or SEX='M' or SEX='m'
)
/





