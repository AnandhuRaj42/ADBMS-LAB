#bank

create table account(acno number,name varchar(20),balance number);
insert into account values(&acno,'&name',&balance);

create or replace procedure deposit(ac number,bal number) is
begin
update account set balance=balance+bal where acno=ac;
end;
/

create or replace procedure withdraw(ac number,bal number) is
begin
update account set balance=balance-bal where acno=ac;
end;
/

declare
ac number;
bal number;
ch number;
begin
ac:=&ac;
bal:=&bal;
ch:=&ch;
if ch=1
  then
  deposit(ac,bal);
else
	withdraw(ac,bal);
end if;
end;

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

#triggers

create table sample(sid number,sname varchar(20));
insert into sample values(&sid,'&sname');


create or replace trigger t1
before insert or update or delete on sample for each row
begin 
raise_application_error(-20000,'you are not permitted to do insert/update/delete');
end;
/

  create or replace trigger t2
  after insert or update or delete on sample for each row
  begin 
  raise_application_error(-20000,'table updated');
  end;
  /

#profossor

create table prof(pnum number,pname varchar(20),salary number);
insert into prof values(&pnum,'&pname',&salary);


create or replace trigger minsalary
before insert on prof for each row
begin
  if(:new.salary<60000)
  then raise_application_error(-20004,'Violation of minimum professor salary');
  end if;
  end;
  /

create table profbacklog as select * from prof;


create or replace trigger backlog 
after delete on prof for each row
begin 
insert into profbacklog values(:old.pnum,:old.pname,:old.salary);
end;
/


#student

create table stud(roll number,name varchar(20),gender varchar(10));
  insert into stud values(&rollno,'&name','&gender');
create table scount(fcount number,mcount number);
  insert into scount values(&fcount,&mcount)

create or replace trigger gender
  after insert on stud for each row
  begin
  if(:new.gender='m')
  then
  update scount set mcount=mcount+1;
  elsif(:new.gender='f') 
  then
  update scount set fcount=fcount+1;
  end if;
  end;
  /

#gold

create table gprice(cdate date,price int);
insert into gprice values(sysdate,&price);
create table pold(cdate date,price int);

  create or replace trigger gold
  after update on gprice for each row
  begin
  insert into pold values(:old.cdate,:old.price);
  end;
  /

 








