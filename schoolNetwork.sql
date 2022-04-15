drop database SchoolNetwork;
create database SchoolNetwork;
use SchoolNetwork;

CREATE TABLE Schools (
    email VARCHAR(60) PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(50) NOT NULL,
    CHECK (type = 'National'
        OR type = 'International'),
    language VARCHAR(50) NOT NULL,
    address VARCHAR(70) NOT NULL,
    phone_number INT UNIQUE NOT NULL,
    fees REAL NOT NULL,
    general_information VARCHAR(300),
    mission VARCHAR(300),
    vision VARCHAR(300)
);
create table Users
(
	username varchar(50) primary key,
	password varchar(50) default '123456'
);
create table Levels
(
    name varchar(50) primary key
    check (name = 'Elementary' or name = 'Middle' or name = 'High')
);
create table Elementary_Schools
(
    email varchar(60) primary key,
    supplies_list varchar(100)not null,
    name varchar(50),
    foreign key(name) references Levels(name) on delete no action, -- no action rejects deletion
    foreign key(email) references Schools(email) on delete cascade on update cascade
);
create table Middle_Schools
(
    email varchar(60) primary key,
    name varchar(50),
    foreign key(name) references Levels(name) on delete no action,  -- no action rejects deletion
    foreign key(email) references Schools(email) on delete cascade on update cascade
);
create table High_Schools
(
    email varchar(60)primary key,
    name varchar(50),
    foreign key(name) references Levels(name) on delete no action,
    foreign key(email) references Schools(email) on delete  cascade on update cascade
);

 -- drop table Courses;
create table Courses
(
    code varchar(20) primary key,
    name varchar(60) not null,
    grade int not null,
    description varchar(200),
    level_name varchar(20) not null,
    foreign key(level_name) references Levels(name)   -- deleting a level will lead to deleting all courses in that level (bas ma7adesh hay delete levels asln)
);
drop table if exists Employees;
create table Employees
(
    ssn bigint primary key,
    username varchar(50) ,
    first_name varchar(50) not null,
    middle_name varchar(50),
    last_name varchar(50) not null,
    birth_date datetime ,
    address varchar(70),
    email varchar(60) unique,
    gender varchar(6),
    check (gender = 'male' or gender = 'female'),
    salary real,
    school_email varchar(60),
    foreign key(username) references Users(username) on delete set null on update cascade,
    foreign key(school_email) references Schools(email) on delete set null on update cascade
); 
create table Administrators
(
    ssn bigint primary key,
    foreign key(ssn) references Employees(ssn) on delete cascade on update cascade
);
-- salary?
drop table if exists Teachers;
create table Teachers
(
    ssn bigint primary key,
    date_of_hire datetime,
    years_of_experience int as (year('2016/1/1') - year(date_of_hire)),
    supervised_by bigint,
    salary int, -- as (1000 + years_of_experience*500),
    foreign key(ssn) references Employees(ssn) on delete cascade,
    foreign key(supervised_by) references Teachers(ssn) on delete set null
);
update Teachers set salary = (1000 + years_of_experience*500);

create table Parents
(   
    ssn bigint primary key,
	username varchar(50),
    first_name varchar(50) not null,
    last_name varchar(50) not null,
    email varchar(60) unique,                                                            
    home_number int unique,
    address varchar(70) unique,
    foreign key(username) references Users(username) on delete set null on update cascade --  wala cascade?lama hashil el parent men users hakhalih 3andy leh?
    
);
drop table if exists Parents_Mobile_Numbers;
create table Parents_Mobile_Numbers
(
    ssn bigint,
    mobile_number bigint,
    primary key(ssn,mobile_number),
    foreign key(ssn) references Parents(ssn) on delete cascade
);
create table Students
(
    ssn bigint primary key,
    name varchar(50) not null,
	username varchar(50),
    birth_date datetime,
    age int as (year('2016/1/1')- year(birth_date)),
    gender varchar(6),
    grade int,
    school_email varchar(60) default null,
    parent_ssn bigint,
    foreign key(school_email) references Schools(email) on delete set null on update cascade, 
    foreign key(parent_ssn) references Parents(ssn), -- lama amsa7 el parent hamsa7 el student?
    foreign key(username) references Users(username) on delete set null on update cascade
);
create table Announcements
(
    number int auto_increment,
    date datetime,
    primary key (number, date),
    title varchar(50) not null,
    type varchar(50) not null,
    description varchar(100) not null,
    administrator_ssn bigint,
    foreign key(administrator_ssn) references Administrators(ssn) on delete cascade on update cascade -- lama el admin beyemshy el announcement hatefdal
);
create table Activities
(
    id int primary key auto_increment,
    name varchar(50) not null,
    date datetime not null,
    location varchar(50) not null,
    type varchar(50),
    description varchar(50),
    equipment varchar(50),
    administrator_ssn bigint,
    teacher_ssn bigint,
    foreign key(administrator_ssn) references Administrators(ssn) on delete set null, -- I want to know who created the activity even if they left sa7?
	foreign key(teacher_ssn) references Teachers(ssn) on delete set null on update cascade -- yenfa3 actiivity teb2a mawgooda mengher teacher asln?
);

create table Assignments
(
    number int,
    date datetime,
    course_code varchar(20) not null,
    primary key(number,course_code,date),
    due_date timestamp not null,
    content varchar(800) not null,
    foreign key(course_code) references Courses(code) on delete cascade -- law ana shelt el course da men el madrasa hasheel ay related assignments
);
create table Reports
(
    date datetime,
    ssn bigint,
    teacher_ssn bigint not null,
    primary key(date,ssn,teacher_ssn),
    comment varchar(150) not null,
    foreign key(ssn) references Students(ssn) on delete cascade on update cascade, -- do I need to keep the record of a student after he leaves the school? In reality schools keep all old records
    foreign key(teacher_ssn) references Teachers(ssn) on update cascade 
);

create table Questions
(
    time_stamp timestamp,
    course_code varchar(20),
    ssn bigint,
    primary key(time_stamp,course_code,ssn),
    text varchar(150) not null,
    foreign key(ssn) references Students(ssn) on delete cascade on update cascade,
    foreign key(course_code) references Courses(code) on update cascade on delete cascade
);
create table Clubs
(
    name varchar(50),
    school_email varchar(60),
    primary key(name,school_email),
    purpose varchar(200) not null,
    foreign key(school_email) references High_Schools(email) on delete cascade on update cascade
);
create table Parents_writeReviews_Schools
(
    ssn bigint,
    email varchar(60),
    primary key(ssn,email),
    review varchar(100) not null,
    foreign key(ssn) references Parents(ssn) on delete cascade, -- law ana shelt el parent, hakhali el review bta3to sa7?
    foreign key(email) references Schools(email) on delete cascade on update cascade -- law shelt el school hasheel el reviews beta3etha
);

create table Parents_Schools_appliesFor_Students
(
    parent_ssn bigint,
    email varchar(60),
    student_ssn bigint,
    primary key (parent_ssn,email,student_ssn),
    accepted tinyint(1) default null, --      	  <<<<<----------------------------------------------------
    foreign key(parent_ssn) references Parents(ssn), -- on delete eh?
    foreign key(email) references Schools(email) on delete cascade on update cascade,
    foreign key(student_ssn) references Students(ssn) on delete cascade on update cascade-- on delete eh?
);
create table Courses_havePrerequisite_Courses
(
    code1 varchar(20),
    code2 varchar(20),
    primary key(code1,code2),
    foreign key(code1) references Courses(code) on delete cascade,
    foreign key(code2) references Courses(code) on delete cascade on update cascade
);
create table Courses_Students_taughtBy_Teachers
(
    student_ssn bigint,
    course_code varchar(20),
    primary key(student_ssn,course_code),
    teacher_ssn bigint,
    foreign key(student_ssn) references Students(ssn) on delete cascade on update cascade,
    foreign key(course_code) references Courses(code) on delete cascade on update cascade,
    foreign key(teacher_ssn) references Teachers(ssn) on delete cascade on update cascade
);
create table Parent_rates_Teacher
(
    teacher_ssn bigint,
    parent_ssn bigint,
    primary key (teacher_ssn,parent_ssn),
    rating int not null,
    foreign key(parent_ssn) references Parents(ssn) on delete cascade,
    foreign key(teacher_ssn) references Teachers(ssn) on delete cascade
);

create table Clubs_joinedBy_Students
(
    ssn bigint,
    name varchar(50),
    email varchar(60),
    primary key(ssn,name,email),
    foreign key(ssn) references Students(ssn) on delete cascade on update cascade,
    foreign key(name,email) references Clubs(name,school_email) on delete cascade
); 
drop table if exists Assignments_Students_solveAndGrade_Teachers;

create table Assignments_Students_solveAndGrade_Teachers
(
    ssn bigint,
    number int,
    post_date datetime,
    code varchar(20),
    primary key(ssn,number,post_date,code),
    teacher_ssn bigint,
    grade double,
    solution varchar(1200) not null,
    foreign key(ssn) references Students(ssn),
    foreign key(number,code,post_date) references Assignments(number,course_code,date) on delete cascade on update cascade,
    foreign key(teacher_ssn) references Teachers(ssn) on delete set null
);
create table Activities_participatedInBy_Students
(
    ssn bigint,
    id int,
    primary key(ssn,id),
    foreign key(ssn) references Students(ssn) on delete cascade on update cascade, -- Do I need to keep a record of the activities a student participated in after he left? 
    foreign key(id) references Activities(id) on delete cascade
);
create table Assignments_givenBy_Teachers
(
    ssn bigint,
    post_date datetime,
    number int,
    code varchar(20),
    primary key(ssn,post_date,number,code),
    foreign key(ssn) references Teachers(ssn) on delete cascade,
    foreign key(number,code,post_date) references Assignments(number,course_code,date) on delete cascade
);
create table Questions_answeredBy_Teachers
(
    time_stamp timestamp,
    code varchar(20),
    ssn bigint,
    primary key(ssn, time_stamp, code),
    teacher_ssn bigint,
    answer varchar(200) not null,
    foreign key(teacher_ssn) references Teachers(ssn) on delete no action,
    foreign key(time_stamp,code,ssn) references Questions(time_stamp,course_code,ssn) on delete cascade on update cascade
);
create table Parents_viewAndReply_Report
(
    date datetime,
    ssn bigint,
    teacher_ssn bigint,
    parent_ssn bigint,
    primary key(date,ssn,teacher_ssn,parent_ssn),
    reply varchar(200),
    foreign key(parent_ssn) references Parents(ssn), -- on delete on update
    foreign key(date,ssn,teacher_ssn) references Reports(date,ssn,teacher_ssn) on delete cascade on update cascade -- on delete on update
);
    
    
    

    
    

    
    

