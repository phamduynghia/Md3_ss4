create table class(
Id int primary key auto_increment,
className varchar(100) not null unique,
startDate datetime not null,
status bit(1) not null
);

create table student(
id int primary key auto_increment,
studentName varchar(100) not null,
address varchar(255) not null,
phone varchar(11) not null,
classId int not null,
foreign key (classId) references class(Id),
status bit(1) not null
);

create table subject(
id int primary key auto_increment,
subjectName varchar (100),
credit int not null,
status bit(1) not null
);

create table mark (
markId int auto_increment primary key ,
studentId int not null ,
subjectId int not null ,
mark double not null,
examTime datetime not null  
);

insert into class (className,startDate,status)
values ("bodoi",'2022-01-30',1),
("congan",'2024-02-21',1),
("canhsat",'2021-06-19',1);
insert into student (studentName,address,phone,classId,status)
values ("ho da dung","ha noi","0123456789",1,1),
("phan van giang","da nang","0987123456",1,1),
("duong my huyen","ha noi","0987654321",2,1),
("hoang minh hieu","nghe an","0987654321",2,1),
("nguyen vinh","ha noi","0987654321",2,1),
("nam cao","ha tinh","0987654321",2,1),
("nguyen du","nghe an","0987654321",2,1);
insert into subject (subName,credit,status)
values ("Toan",3,1),
("Van",3,1),
("Anh",2,1);
select * from subject;
insert into mark (studentId,subjectId,mark,examTimes)
values (1,1,6,'2020-05-19 00:00:00'),
(1,1,7,'2022-03-30 00:00:00'),
(2,2,8,'2024-05-23 00:00:00'),
(2,3,9,'2020-03-24 00:00:00'),
(3,3,10,'2021-02-21 00:00:00');
 select * from mark;
select * from class
order by className desc ;

select * from student
where address = "Hà Nội" ;

select * from student
inner join class on student.classId = class.classId
where className = "HN-JV231103" ;

select * from subject
where credit > 2 ;

select * from student
where phone like '09%';

select address,count(classId) as 'tong so hoc sinh' from student group by address ;

select subject.subName,max(mark.mark) as diem_cao
from mark join subject on mark.subjectId = subject.subId
group by subject.subName
order by diem_cao desc;

select student.studentName, avg(mark.mark) as diem_tb
from student join mark on student.studentId = mark.studentId
group by student.studentName;

select student.studentName,avg(mark.mark) as diem_tb
from student join mark on student.studentId = mark.studentId
group by student.studentName having diem_tb < 7;

select student.studentName ,avg(mark.mark) as dtb_max
from student join mark on student.studentId = mark.studentId
group by student.studentName 
order by dtb_max desc limit 1;

select student.studentName, avg(mark.mark) as diem_tb
from student join mark on student.studentId = mark.studentId
group by student.studentName order by diem_tb desc;
