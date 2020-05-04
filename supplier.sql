create table SUPPLIERS(sid number(5) 
primary key, 
sname varchar(20),
city varchar(20));

create table PARTS(pid number(5) primary key,
pname varchar(20), 
color varchar(10));

create table CATALOG(sid number(5), pid number(5),
foreign key(sid) references SUPPLIERS(sid),
foreign key(pid) references PARTS(pid), cost float(6), primary key(sid, pid)
);
insert into suppliers values(&sid, '&sname','&city');
insert into PARTS values(&pid, '&pname','&color');
insert into CATALOG values(&sid, '&pid','&cost');

Find the pnames of parts for which there is some supplier.

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
WHERE P.color = ‘Red’ )
			MINUS
			( SELECT C.pid
			FROM Catalog C, Parts P
			WHERE C.sid = S.sid AND
			C.pid = P.pid AND P.color = ‘Red’ ));

select pname from parts where pid in(
select pid from cataloge where sid =(
select sid from suppliers where sname = 'Acme widget')
minus select pid from cataloge where sid in (select sid from suppliers
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
