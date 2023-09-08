create table client(
    clno char(3),
    name varchar(12),
    address varchar(30),
    constraint client_PK primary key(clno)
);

create table stock(
    company char(7),
    price number(6,2),
    divided number(4,2),
    eps number(4,2),
    constraint stock_PK primary key(company)
);

create table trading(
    company char(7),
    exchange varchar(12),
    constraint trading_PK primary key(company, exchange),
    constraint trading_FK foreign key(company) references stock(company)
);

create table purchase(
    clno char(3),
    company char(7),
    pdate date,
    qty number(6),
    price number(6,2),
    constraint purchase_PK primary key(clno, company, pdate),
    constraint purchase_FK1 foreign key(clno) references client(clno),
    constraint purchase_FK2 foreign key(company) references stock(company)
);

insert into client values('100', 'John Smith', '3 East Ave Bentley WA 6102');
insert into client values('101', 'Jilly Brody', '42 Bent St Perth WA 6101');


insert into stock values('BHP', 10.50, 1.50, 3.20);
insert into stock values('IBM', 70.00, 4.25, 10.00);
insert into stock values('INTEL', 76.50, 5.00, 12.40);
insert into stock values('FORD', 40.00, 2.00, 8.50);
insert into stock values('GM', 25.00, 1.75, 4.80); -- Adding missing stock entry






















insert into trading values('GM', 'New York');
insert into trading values('INFOSYS', 'New York'); -- INFOSYS was used in your code, but not defined in the stock table



insert into purchase values('100', 'BHP', TO_DATE('2001-10-02', 'YYYY-MM-DD'), 1000, 12.00);
insert into purchase values('100', 'BHP', '2001-10-02', 1000, 12.00);
insert into purchase values('100', 'BHP', '2002-06-08', 2000, 10.50);
insert into purchase values('100', 'BHP', '2000-02-12', 500, 58.00);
insert into purchase values('100', 'BHP', '2001-04-10', 1200, 65.00);
insert into purchase values('100', 'BHP', '2001-08-11', 1000, 64.00);
insert into purchase values('101', 'BHP', '2000-01-30', 300, 35.00);
insert into purchase values('101', 'BHP', '2001-01-30', 400, 54.00);
insert into purchase values('101', 'BHP', '2001-10-02', 200, 60.00);
insert into purchase values('101', 'BHP', '1999-10-05', 300, 40.00);
insert into purchase values('101', 'BHP', '2000-12-12', 500, 55.50);


--a)

select c.name, p.company, s.price, s.divided, s.eps
from client c, stock s, purchase p
where c.clno = p.clno and s.company = p.company
/
--b)
select c.name, p.company, sum(p.qty) total_qty, sum(p.qty * p.price)/sum(p.qty) APP
from client c, purchase p
where c.clno = p.clno
group by c.name, p.company;














