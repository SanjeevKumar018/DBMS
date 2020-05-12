create table SUPPLIERS(sid number(5) 
primary key, 
sname varchar2(20),
city varchar2(20));

create table PARTS(pid number(5) primary key,
pname varchar2(20), 
color varchar2(10));

create table CATALOG(sid number(5), pid number(5),
foreign key(sid) references SUPPLIERS(sid),
foreign key(pid) references PARTS(pid), cost float(6), primary key(sid, pid)
);

insert into suppliers values(10001,'acme widget','bangalore');
insert into suppliers values(10002,'johns','kolkata');
insert into suppliers values(10003,'vimal','mumbai');
insert into suppliers values(10004,'reliance','delhi');

insert into parts values(20001,'book','red');
insert into parts values(20002,'pen','red');
insert into parts values(20003,'pencil','green');
insert into parts values(20004,'mobile','green');
insert into parts values(20005,'charger','black');

insert into catalog values(10001,20001,10);
insert into catalog values(10001,20002,10);
insert into catalog values(10001,20003,30);
insert into catalog values(10001,20004,10);
insert into catalog values(10001,20005,10);
insert into catalog values(10002,20001,10);
insert into catalog values(10002,20002,20);
insert into catalog values(10003,20003,30);
insert into catalog values(10004,20003,40);
select * from suppliers;
select * from parts;
select * from catalog;
SELECT DISTINCT P.pname
 FROM Parts P, Catalog C
 WHERE P.pid = C.pid;
 
 SELECT S.sname
   FROM Suppliers S
    WHERE NOT EXISTS ((SELECT P.pid  FROM Parts P)
    MINUS (SELECT C.pid FROM Catalog C
    WHERE C.sid = S.sid));

 
 SELECT S.sname
FROM Suppliers S
WHERE NOT EXISTS (( SELECT P.pid
FROM Parts P
WHERE P.color = 'Red' )
			MINUS
			( SELECT C.pid
			FROM Catalog C, Parts P
			WHERE C.sid = S.sid AND
			C.pid = P.pid AND P.color = 'Red' ));
			

select pname from parts where pid in(
select pid from catalog where sid =(
select sid from suppliers where sname = 'Acme widget')
minus select pid from catalog where sid in (select sid from suppliers
where sname <>'Acme widget'));



 SELECT DISTINCT C.sid FROM Catalog C
    WHERE C.cost > ( SELECT AVG (C1.cost)
   FROM Catalog C1
    WHERE C1.pid = C.pid );


SELECT P.pid, S.sname
FROM Parts P, Suppliers S, Catalog C
WHERE C.pid = P.pid
AND C.sid = S.sid
AND C.cost = (SELECT MAX (C1.cost)
		FROM Catalog C1
		WHERE C1.pid = P.pid);
