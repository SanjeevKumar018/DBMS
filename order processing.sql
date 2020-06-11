create table salesman(
salesman_id int,
sname varchar(15), 
city varchar(15),
commission  int,
primary key(salesman_id));

INSERT INTO SALESMAN VALUES (1000, 'JOHN','BANGALORE',25); 
INSERT INTO SALESMAN VALUES (2000,'RAVI','BANGALORE',20); 
INSERT INTO SALESMAN VALUES (3000, 'KUMAR','MYSORE',15); 
INSERT INTO SALESMAN VALUES (4000, 'SMITH','DELHI',30); 
INSERT INTO SALESMAN VALUES (5000, 'HARSHA','HYDRABAD',15); 
 select * from salesman;
 
 create table CUSTOMER (Customer_id int,
 Cust_Name varchar(15),
 City varchar(15),
 Grade int,
 Salesman_id int,
 primary key(Customer_id),
 foreign key (Salesman_id) references salesman(Salesman_id) on delete cascade);
 
INSERT INTO CUSTOMER VALUES (10, 'PREETHI','BANGALORE', 100, 1000); 
INSERT INTO CUSTOMER VALUES (11, 'VIVE','MANGALORE', 300, 1000); 
INSERT INTO CUSTOMER VALUES (12, 'BHASKAR','CHENNAI', 400, 2000); 
INSERT INTO CUSTOMER VALUES (13, 'CHETHAN','BANGALORE', 200, 2000); 
INSERT INTO CUSTOMER VALUES (14, 'MAMATHA','BANGALORE', 400, 3000); 
select * from customer;

create table ORDERS (Ord_No int,
Purchase_Amt int,
Ord_Date varchar(15), 
Customer_id int, 
Salesman_id int,
primary key(Ord_No),
foreign key (Salesman_id) references salesman(Salesman_id) on delete cascade,
foreign key (Customer_id) references CUSTOMER(Customer_id) on delete cascade);

INSERT INTO ORDERS VALUES (50, 5000, '04-MAY-17', 10, 1000); 
INSERT INTO ORDERS VALUES (51, 450, '20-JAN-17', 10, 2000);
INSERT INTO ORDERS VALUES (52, 1000, '24-FEB-17', 13, 2000); 
INSERT INTO ORDERS VALUES (53, 3500, '13-APR-17', 14, 3000); 
INSERT INTO ORDERS VALUES (54, 550, '09-MAR-17', 12, 2000);

select * from orders;


select Count(*) 
from CUSTOMER
where Grade>(select avg(Grade)
			from CUSTOMER
			where City='BANGALORE');
            
select salesman_id,sname
from salesman
where salesman_id=(select Salesman_id from CUSTOMER where CUSTOMER.Salesman_id=salesman.salesman_id group by CUSTOMER.Salesman_id having count(*)>1);
                    

					      
select s.salesman_id,s.sname,c.Cust_Name,s.commission
from salesman s,customer c
where s.city=c.City
union
select salesman_id,sname,'NO MATCH',commission
from salesman
where not city=any(select City from customer);					      


create view BestSalesman AS
select B.Ord_Date, A.salesman_id, A.sname 
from salesman A, ORDERS B
where A.salesman_id = B.Salesman_id 
AND B.Purchase_Amt=(select MAX(Purchase_Amt) 
from ORDERS C 
WHERE C.Ord_Date = B.Ord_Date);

select * from BestSalesman;



delete from salesman 
where salesman_id=1000;

SELECT sName
FROM Orders, Salesman
WHERE Orders.salesman_id = salesman.Salesman_id
GROUP BY salesman.salesman_id, sName                  
HAVING COUNT( salesman.salesman_id ) >1;

SELECT * FROM salesman WHERE city=ANY(SELECT city FROM customer);
