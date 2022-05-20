#bank
 create table account(acno number,name varchar(20),amount number);
 insert into account values(&acno,'&name',&amount);

create or replace procedure deposit(ac number,bal number) is 
begin
update account set amount=amount+bal where acno=ac;
end;
/

create or replace procedure withdraw(ac number,bal number) is 
begin
update account set amount=amount-bal where acno=ac;
end;
/

create or replace procedure display is
cursor c is select * from account;
begin
for i in c
loop
dbms_output.put_line(i.acno||' '||i.name||' '||i.amount);
end loop;
end;
/

declare
ac number;
am number;
ch number;
begin
ac:=&acno;
am:=&amount;
ch:=&ch;
if ch=1
	then
	deposit(ac,am);
elsif ch=2
	then
	withdraw(ac,am);
elsif ch=3
	then
	display();
end if;
end;
/ 


#Exception

create table product(pid int primary key,pname varchar(20),price int);
insert into product values(&pid,'&pname',&price);

create or replace procedure record(pi number,pr number) is 
ex exception;
begin
update product set price=price+pr where pid=pi;
if sql%notfound then
raise ex;
end if;
exception
when ex then
dbms_output.put_line('product id invalid');
end;
/

declare
pid int:=&pid;
price int:=&price;
begin
record(pid,price);
end;
/


