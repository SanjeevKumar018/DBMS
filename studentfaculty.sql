create table student
(
 snum int,
 sname varchar2(20),
 major varchar2(20),
 lvl varchar2(20),
 age int,
 primary key(snum)
);

create table faculty
(
 fid int,
 fname varchar2(20),
 deptid int,
 primary key(fid)
); 

create table class
(
 cname varchar2(5),
 meets_at timestamp,
 room int,
 fid int,
 primary key(cname),
 foreign key(fid) references faculty(fid)
);

create table enrolled
(
 snum int,
 cname varchar2(5),
 primary key(snum),
 foreign key(snum) references student(snum),
 foreign key(cname) references class(cname)
);

insert into student values(1,'Rahul','cse','sr',20);
insert into student values(2,'Lohith','ise','jr',19);
insert into student values(3,'keerthan','ete','jr',19);
insert into student values(4,'patil','cse','sr',20);
insert into student values(5,'priyanka','ise','sr',20);
insert into student values(6,'hemanth','cse','sr',20);
insert into student values(7,'yamini','ise','jr',19);
insert into student values(8,'sneha','ete','jr',19);
insert into student values(9,'saranya','cse','sr',20);
insert into student values(10,'anil','ise','sr',20);

insert into faculty values(10,'prof. Murthy',10);
insert into faculty values(20,'prof. Sudha',20);
insert into faculty values(30,'prof. Latha',30);

insert into class values('4A',timestamp '2011-10-20 09:50:00',301,10);
insert into class values('4B',timestamp '2013-11-02 10:45:30',302,20);
insert into class values('4C',timestamp'2014-11-22 11:15:02',303,10);
insert into class values('3A',timestamp'2015-10-11 12:50:01',304,10);
insert into class values('3B',timestamp'2016-10-16 01:05:05',305,10);

insert into enrolled values(1,'4B');
insert into enrolled values(2,'4B');
insert into enrolled values(3,'4C');
insert into enrolled values(4,'4B');
insert into enrolled values(5,'4A');
insert into enrolled values(6,'4B');
insert into enrolled values(7,'3B');
insert into enrolled values(8,'3B');
insert into enrolled values(9,'3B');
insert into enrolled values(10,'3A');

 select distinct sname 
   from student s,class c,enrolled e,faculty f
   where s.snum = e.snum and e.cname = c.cname and c.fid = f.fid and f.fname = 'prof. Murthy' and s.lvl = 'jr';
 select c.cname  
   from class c
   where c.room = 301
   or c.cname in (select e.cname from enrolled e group by e.cname having count(*) >= 5);
 select distinct sname
   from student s
   where s.snum in (select e1.snum
   from enrolled e1,enrolled e2,class c1,class c2
   where e1.snum=e2.snum and e1.cname=c1.cname and e2.cname=c2.cname and c1.meets_at=timestamp'2014-11-22 11:15:02');
 select distinct f.fname
   from faculty f
   where not exists((select c.room from class c)
   minus
   (select c1.room from class c1 where c1.fid=f.fid));
 select distinct fname 
   from faculty f where 5>(select count(e.snum)
   from class c,enrolled e where c.cname=e.cname and c.fid=f.fid);
 select distinct sname 
   from student s
   where s.snum not in(select e.snum from enrolled e);
 select s.age,s.lvl 
   from student s
   group by s.age,s.lvl
   having s.lvl in(select s1.lvl from student s1 where s1.age=s.age
                   group by s1.lvl,s1.age
                   having count(*)>=all(select count(*)
                   from student s2 where s1.age=s2.age group by s2.lvl,s2.age));
