create table branch(
branch_name varchar(20),
branch_city varchar(20),
assets int,
primary key(branch_name)
);
create table accounts(
account_no int,
branch_name varchar(20),
balance real,
primary key(account_no),
foreign key(branch_name) references branch(branch_name)
);

create table depositor(
customer_name varchar(20),
customer_street varchar(20),
customer_city varchar(20),
primary key(customer_name)
);
create table Loan(
loan_number int,
branch_name varchar(20),
amount real,
primary key(loan_number),
foreign key(branch_name) references branch(branch_name)
);

create table borrower(
customer_name varchar(20),
loan_number int,
foreign key(customer_name) references depositor(customer_name),
foreign key(loan_number) references Loan(loan_number)
);
create table customer(
customer_name varchar(20),
account_no int,
foreign key(customer_name) references depositor(customer_name),
foreign key(account_no) references accounts(account_no)
);
insert into branch values('branch_name12','branch_city1',100000);
insert into branch values('branch_name22','branch_city2',200000);
insert into branch values('branch_name32','branch_city3',300000);
select * from branch;
insert into accounts values(11111,'branch_name12',111);
insert into accounts values(22222,'branch_name12',222);
insert into accounts values(33333,'branch_name22',333);
insert into accounts values(44444,'branch_name22',444);
insert into accounts values(55555,'branch_name32',555);
insert into accounts values(66666,'branch_name32',666);
insert into accounts values(11112,'branch_name12',111);
insert into accounts values(11113,'branch_name12',111);
select * from accounts;
insert into depositor values('cust1','street1','city1');
insert into depositor values('cust2','street2','city2');
insert into depositor values('cust3','street3','city3');
insert into depositor values('cust4','street4','city4');
insert into depositor values('cust5','street5','city5');
select * from depositor;
insert into Loan values(11,'branch_name12',120000);
insert into Loan values(12,'branch_name12',120000);
insert into Loan values(21,'branch_name22',220000);
insert into Loan values(22,'branch_name22',220000);
insert into Loan values(31,'branch_name32',320000);
insert into Loan values(32,'branch_name32',320000);
select * from loan;
insert into borrower values('cust1',11);
insert into borrower values('cust2',12);
insert into borrower values('cust3',21);
insert into borrower values('cust4',22);
insert into borrower values('cust5',31);
select * from borrower;
select * from depositor ;
insert into customer values('cust1',11111);
insert into customer values('cust2',22222);
insert into customer values('cust3',33333);
insert into customer values('cust4',44444);
insert into customer values('cust5',55555);
insert into customer values('cust1',11112);
insert into customer values('cust1',11113);
select * from customer;
select (c.customer_name) from customer c,Accounts a
where a.account_no=c.account_no and a.branch_name= 'branch_name12' group by c.customer_name having count(*)>=2;
select (c.customer_name) from customer c,Accounts a,branch b
where a.account_no=c.account_no and b.branch_city = 'branch_city1' ;
