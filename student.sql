CREATE TABLE STUDENT(
    REGNO VARCHAR2(20),
    NAME VARCHAR2(20),
    MAJOR VARCHAR2(5),
    BDATE DATE,
    PRIMARY KEY(REGNO)
    );
    
CREATE TABLE COURSE(
    COURSE_ID INT,
    CNAME VARCHAR2(20),
    DEPT VARCHAR2(4),
    PRIMARY KEY(COURSE_ID)
    );

CREATE TABLE TEXT(
    ISBN INT,
    BOOK_TITLE VARCHAR2(50),
    PUBLISHER VARCHAR2(20),
    AUTHOR VARCHAR2(20),
    PRIMARY KEY(ISBN)
    );

CREATE TABLE ADOPTION(
    COURSE_ID INT,
    SEM INT,
    ISBN INT,
    PRIMARY KEY(COURSE_ID, ISBN),
    FOREIGN KEY(COURSE_ID) REFERENCES COURSE(COURSE_ID),
    FOREIGN KEY(ISBN) REFERENCES TEXT(ISBN)
    );
    
CREATE TABLE ENROLL(
    REGNO VARCHAR2(20),
    COURSE_ID INT,
    SEM INT,
    MARKS INT,
    PRIMARY KEY(REGNO, COURSE_ID),
    FOREIGN KEY(REGNO) REFERENCES STUDENT(REGNO),
    FOREIGN KEY(COURSE_ID) REFERENCES COURSE(COURSE_ID)
    );
    
insert into student values ('1DB01IS01', 'KIRAN', 'ISE', '02-JAN-84');
insert into student values ('1DB01CS02', 'DIVYA', 'CSE', '12-OCT-85');
insert into student values ('1DBO1ME03', 'BABU', 'MECH', '23-SEP-82');
insert into student values ('1DB01EC04', 'JOHN', 'EC', '21-FEB-84');
insert into student values ('1DB01CS05', 'ASHA', 'CSE', '07-OCT-79');
select * from student;
insert INTO course values (11, 'DCS', 'CSE');
insert INTO course values (22, 'ADA', 'CSE');
insert INTO course values (33, 'CN', 'EC');
insert INTO course values (44, 'TD' ,'MECH');
insert INTO course values (55 ,'MUP', 'EC');
select * from course;
insert INTO text values (7722, 'VB', 'PHI', 'HOLZNER');
insert INTO text values (1144, 'DS WITH C', 'SAPNA', 'NANDAGOPAL');
insert INTO text values (4400, 'C PROG', 'PHI', 'BALAGURU');
insert INTO text values (5566, 'CN', 'PHI', 'TENENBAUM');
insert INTO text values ('3388', 'MP', 'TATA', 'BREY');
select * from text;

insert INTO ADOPTION values (11, 3, 7722);
insert INTO ADOPTION values (22, 4, 7722);
insert INTO ADOPTION values (11, 5, 4400);
insert INTO ADOPTION values (11, 8, 5566);
insert INTO ADOPTION values (55, 4, 3388);
insert INTO ADOPTION values (44, 4, 5566);
insert INTO ADOPTION values (44, 7, 3388);
select * from Adoption;


insert INTO enroll values ('1DB01IS01', 22, 5, 76);
insert INTO enroll values ('1DB01IS01', 11, 3, 90);
insert INTO enroll values ('1DB01CS02', 33, 6, 55);
insert INTO enroll values ('1DBO1ME03', 22, 5, 75);
insert INTO enroll values ('1DB01CS05', 44, 5, 75);
select * from enroll;


INSERT INTO TEXT VALUES('4242', 'PYTHON PROG', 'PHI', 'DAVE R');
INSERT INTO ADOPTION VALUES(40, 4, 4242);

SELECT C.CNAME, T.ISBN, T.BOOK_TITLE 
FROM COURSE C, TEXT T 
WHERE (
)
ORDER BY C.CNAME;

SELECT C.CNAME 
FROM COURSE C, ADOPTION A, TEXT T 
WHERE T.ISBN = A.ISBN AND C.COURSE_ID = A.COURSE_ID  ;
