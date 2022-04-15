use SchoolNetwork;

-- System Administrator

-- #1)Create a school with its information: school name, address, phone number, email, general information,
-- # vision, mission, main language, type(national, international) and fees.
delimiter //
create procedure InsertSchool(email varchar(60), name varchar(50), type varchar(50), language varchar(50),address varchar(70),
phone_number int, fees real, general_information varchar(300), mission varchar(300), vision varchar(300))
begin
	if email is null or name is null or type is null or language is null or address is null or phone_number is null or fees is null
	then select 'We don''t accept null values';
	else
	insert into Schools(email, name, type, language, address, phone_number, fees, general_information, mission, vision)
	values(email, name, type, language, address, phone_number, fees, general_information, mission, vision);
end if;
end//
delimiter ;

-- #2)Add courses to the system with all of its information: course code, course name, course level (elementary,middle, high),
-- #grade, description and prerequisite course(s).
delimiter //
create procedure InsertCourse(code varchar(20), name varchar(60), grade int, description varchar(200), level_name varchar(20))
begin
	if  code is null or name is null or grade is null or level_name is null
	then select 'We don''t accept null values';
	else
	insert into Courses(code, name, grade, description, level_name)
	values(code, name, grade, description, level_name);
end if;
end//
delimiter ;

delimiter //
create procedure InsertPrerequisites(code1 varchar(20),code2 varchar(20))
begin
	if code1 is null or code2 is null
	then select 'Invalid input';
	else
	insert into Courses_havePrerequisite_Courses(code1, code2)
	values(code1,code2);
end if;
end//
delimiter ;


-- #3)Add admins to the system with their information: first name, middle name, last name, birthdate, address, email, username, password, and gender. Given the school name, I should assign admins
-- #  to work in this school. Note that the salary of the admin depends on the type of the school. The salary of an admin working in a national school is 3000 EGP, and that working in an international school is 5000 EGP
-- #  drop procedure InsertAdmins;

delimiter //
create procedure InsertAdmins(ssn bigint, username varchar(50), first_name varchar(50), middle_name varchar(50),
last_name varchar(50), birth_date datetime, address varchar(70), email varchar(60), gender varchar(6),s_email varchar(60))
begin
declare t varchar(50);
	if first_name is null or last_name is null or ssn is null
	then select 'We don''t accept null values';
	else
	insert into Users(username,password)
	values(username,'123456');

	select s.type
	into t
	from Schools s
	where s.email = s_email;

	if t = 'National'
	then
	insert into Employees(ssn , username , first_name , middle_name,last_name , birth_date , address , email , gender,salary,school_email)
	values(ssn , username , first_name , middle_name,last_name , birth_date , address , email , gender,3000,s_email);
	end if;
	if t = 'International'
	then insert into Employees(ssn , username , first_name , middle_name,last_name , birth_date , address , email , gender,salary,school_email)
	values(ssn , username , first_name , middle_name,last_name , birth_date , address , email , gender,5000,s_email);
	end if;

	insert into Administrators(ssn)
	values(ssn);
	end if;
end//
delimiter ;

--#4) Delete a school from the database with all of its corresponding information. Students and employees of this school should not be 
-- # deleted from the system, but should not have a username and password on the system until they are assigned to a new school again.
delimiter //
create procedure DeleteSchool(s_email varchar(60))
begin
    delete 
    from Users
    where username = any(select st.username
						from students st, schools s
                        where st.school_email = s.email and s.email = s_email);
    delete
    from Users
    where username = any(select e.username
						from Employees e, schools s
                        where e.school_email = s.email and s.email = s_email);
    delete 
    from Schools 
	where email = s_email;
end//
delimiter ;


-- ---------------------------------------------------------------------------------------------------------------------
-- #As a system user (registered, or not registered), I should be able to ...

-- #1) Search for any school by its name, address or its type (national/international).
-- drop procedure SearchSchools;
delimiter // 
create procedure SearchSchools(keyword varchar(50))
 begin
	select s.*
	from Schools s
	where s.name = keyword or s.address = keyword or s.type = keyword;
end//
delimiter ;

-- #2) View a list of all available schools on the system categorized by their level.
drop procedure if exists CategorizeSchools;
delimiter //
create procedure CategorizeSchools()
begin
	drop table if exists temp;
	create table temp
	select s.name as schoolName, e.name, s.email
    from Elementary_Schools e join Schools s on 
    e.email = s.email;

    insert into temp
    select  s.name as schoolName, m.name, s.email
    from Middle_Schools m join Schools s on
    m.email = s.email;

    insert into temp
    select s.name as schoolName, h.name, s.email
    from High_Schools h join Schools s on
    h.email = s.email; 
    
	select * from temp;
end//
delimiter ;

-- #3) View the information of a certain school along with the reviews written about it and teachers teaching in this school.
delimiter //
create procedure ViewSchools(email varchar(60))
begin
	select s.*, e.name, r.review
	from Schools s, Teachers t, Employees e, Parents_writeReviews_Schools r
	where s.email = email and e.school_email = s.email and e.ssn = t.ssn and r.email = s.email
	order by s.email;
end//
delimiter ;

-- ------------------------------------------------------------------------------------------------------------------------
-- School Adiministrator

-- #1) View and verify teachers who signed up as employees of the school I am responsible of, and assign to them a unique username and password.
-- #The salary of a teacher is calculated as follows: years of experience * 500 EGP.
delimiter //
create procedure ViewTeachers(my_username varchar(50))
begin
	declare x varchar(60);
	select E.school_email
	into x
	from Employees E
	where E.username = my_username;

	select e.ssn, e.first_name, e.last_name
	from Employees e
	where e.username is null and e.school_email = x; 
end//
delimiter ;

-- years of experience???
-- drop procedure VerifyTeacher;
delimiter //
create procedure VerifyTeacher(ssn1 bigint, username1 varchar(50),myusername varchar(50))
begin
declare x varchar(60);
declare y varchar(60);
	select E.school_email
	into x
	from Employees E
	where E.username = myusername;
    select E.school_email
	into y
	from Employees E
	where E.ssn = ssn1;
	if username1 = any (select u.username from Users u)
	then
	select 'username already exists';
	else if x=y 
    then
	insert into Users(username, password) values (username1, '123456');
	update Employees set username = username1, salary = 1000 where school_email = x and ssn1 = ssn;
	insert into Teachers(ssn, date_of_hire, supervised_by)
	values(ssn1, '2016/1/1', null);
    else select 'Can not verify this teacher';
	end if;
    end if;
end//
delimiter ;

-- #2) View and verify students who enrolled to the school I am responsible of, and assign to them a unique username and password.
drop procedure if exists ViewStudents;
delimiter //
create procedure ViewStudents(my_username varchar(50))
begin
	declare x varchar(60);
	select E.school_email
	into x
	from Employees E
	where E.username = my_username;

	select s.*
	from Parents_Schools_appliesFor_Students a, Students s
	where a.student_ssn = s.ssn and s.username is null and a.email = x and a.accepted = 1; 
end//
delimiter ;

drop procedure if exists VerifyStudents;
delimiter //
create procedure VerifyStudents(ssn1 bigint, username1 varchar(50), my_username varchar(50))
begin

	declare x varchar(60);
    declare enrolled_email varchar(60);
    -- checking that student is not enrolled in another school
    select S.school_email
    into enrolled_email
    from Students S
    where S.ssn = ssn1;
    select E.school_email     -- getting the email of my school
	into x
	from Employees E
	where E.username = my_username;
    if enrolled_email = x
    then
	
    -- giving a student a unique username
	if username1 = any (select u.username from Users u)
	then
	select 'username already exists';
	else
	insert into Users(username, password) values (username1, '123456');
    
	update Students set username = username1 where ssn1 = ssn ;
end if;
end if;
end//
delimiter ;

-- #3)Add other admins to the school I am working in. An admin has first name, middle name, last name, birthdate, address, email, username,
-- #  password, and gender. Note that the salary of the admin depends on the type of the school.
delimiter //
create procedure AddAdmins(my_username varchar(50),ssn bigint, username varchar(50), password varchar(50), first_name varchar(50),
middle_name varchar(50), last_name varchar(50), birth_date datetime, address varchar(70), email varchar(60), gender varchar(6))
begin
	declare x varchar(60);
	declare type varchar(50);
    
	if ssn is null or first_name is null or last_name is null
	then select 'Invalid Input'	;
	else
    
	select E.school_email
	into x
	from Employees E
	where E.username = my_username;
    
	select s.type
	into type
	from Schools s
	where s.email = x;
    
	insert into Users(username,password)
	values(username,password);
	
    if type = 'National'
	then
	insert into Employees(ssn , username , first_name , middle_name,last_name , birth_date , address , email , gender,salary,school_email)
	values(ssn , username , first_name , middle_name,last_name , birth_date , address , email , gender,3000,x);
	end if;
	
    if type = 'International'
	then insert into Employees(ssn , username , first_name , middle_name,last_name , birth_date , address , email , gender,salary,school_email)
	values(ssn , username , first_name , middle_name,last_name , birth_date , address , email , gender,5000,x);
	end if;
	
    insert into Administrators(ssn)
	values(ssn);
	end if;
end//
delimiter ;

-- #4) Delete employees and students from the system.
delimiter //
create procedure DeleteStudents(ssn1 bigint)
begin
	delete
    from Users
    where username = any(select username
						  from Students s
                          where s.ssn = ssn1);
	delete 
    from Students 
    where ssn = ssn1;
end//
delimiter ;

delimiter //
create procedure DeleteEmployees(ssn1 bigint,myusername varchar(50))
begin
	declare semail varchar(60);
    select school_email into semail from Employees where username = myusername;
	delete
    from Users
    where username = any(select username
						  from Employees e
                          where e.ssn = ssn1 and e.school_email = semail);
	delete 
    from Employees 
    where ssn = ssn1;
end//
delimiter ;

-- #5) edit information of the school i am working in.
-- drop procedure EditEmail;
delimiter //
create procedure EditEmail(new_email varchar(60), my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set email = new_email where email = semail;
end//
delimiter ;

delimiter //
create procedure EditName(new_name varchar(50), my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set name = new_name where email = semail;
end//
delimiter ;

delimiter //
create procedure EditType(new_type varchar(50), my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set type = new_type where email = semail;
end//
delimiter ;

delimiter //
create procedure EditLanguage(new_language varchar(50), my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set language = new_language where email = semail;
end//
delimiter ;

delimiter //
create procedure EditAddress(new_address varchar(70), my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set address = new_address where email = semail;
end//
delimiter ;

delimiter //
create procedure EditPhoneNumber(new_phoneNumber int, my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set phone_number = new_phoneNumber where email = semail;
end//
delimiter ;

delimiter //
create procedure EditFees(new_fees real, my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set fees = new_fees where email = semail;
end//
delimiter ;

delimiter //
create procedure EditGeneralInformation(new_generalInformation varchar(300), my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set general_information = new_generalInformation where email = semail;
end//
delimiter ;


delimiter //
create procedure EditMission(new_mission varchar(300), my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set mission = new_mission where email = semail;
end//
delimiter ;

delimiter //
create procedure EditVision(new_vision varchar(300), my_username varchar(50))
begin
declare semail varchar(60);
select e.school_email into semail from Employees e where e.username = my_username;
update Schools set vision = new_vision where email = semail;
end//
delimiter ;

-- #6) Post announcements with the following information: date, title, description and type (events, news, trips ...etc).
-- drop procedure PostAnnouncements;
delimiter //
create procedure PostAnnouncements(date datetime, title varchar(50),type varchar(50), description varchar(100), myusername varchar(50)) -- USERNAME NOT SSN?
begin
	declare myssn bigint;
	if date is null or title  is null or type is null or description is null or myusername is null
	then select 'We don''t accept null values';
	else
    select ssn into myssn from Employees where myusername = username;
	insert into Announcements(date, title ,type, description, administrator_ssn)
	values (date, title ,type, description, myssn);
	end if;
end //
delimiter ;

-- #7)Create activities and assign every activity to a certain teacher. An activity has its own date, location in school,
-- #  type, equipment(if any), and description.
delimiter //
create procedure Create_AssignActivities(name varchar(50),date datetime,location varchar(50),type varchar(50),
description varchar(50), equipment varchar(50), administrator_ssn bigint, teacher_ssn bigint)
begin
	if name is null or date is null or location is null
	then select 'We don''t accept null values';
	else
	insert into Activities(name,date,location,type,description, equipment, administrator_ssn ,teacher_ssn)
	values (name,date,location,type,description, equipment, administrator_ssn ,teacher_ssn);
	end if;
end//
delimiter ;

-- #8) Change the teacher assigned to an activity.
drop procedure if exists ChangeTeacherActivity;
delimiter //
create procedure ChangeTeacherActivity(my_username varchar(50), id1 int)
begin
declare my_ssn bigint;
select ssn into my_ssn from Employees where my_username = username;

	update Activities
	set teacher_ssn = my_ssn
	where id = id1;
end//
delimiter ;

-- #9) Assign teachers to courses that are taught in my school based on the levels it offers.
drop procedure if exists AssignTeacherCourses;
delimiter //
create procedure AssignTeacherCourses(my_username varchar(50), teacher_username varchar(50), code varchar(50),student_username varchar(50)) -- USERNAME NOT SSN
begin
declare ssn_teacher bigint;
declare ssn_student bigint;
declare g int; -- course grade
declare sg int; -- student grade
declare email1 varchar(60); -- teacher's email
declare admin_email varchar(60); -- administrator's email
select ssn into ssn_teacher from Employees where username = teacher_username;
select ssn into ssn_student from Students where username = student_username;
select grade into g from Courses c where c.code = code;
select grade into sg from Students s where s.ssn = ssn_student;
select e.school_email into email1 from Employees e where e.ssn = ssn_teacher;
select e.school_email into admin_email from Employees e where my_username = e.username;

	if g = sg
	then
	if g between 1 and 6 and email1 = admin_email
	then
	if email1 in (select es.email from Elementary_Schools es
					 where es.email = email1 and es.name = 'Elementary')
	then 
    insert into Courses_Students_taughtBy_Teachers(student_ssn, course_code,teacher_ssn) values(ssn_student,code,ssn_teacher);
    end if;
    elseif g between 7 and 9 and email1 = admin_email
	then
	if email1 = any (select es.email from Employees e, Middle_Schools es
					 where e.school_email = es.email and e.ssn = ssn_teacher and es.name = 'Middle')
	then 
    insert into Courses_Students_taughtBy_Teachers(student_ssn, course_code,teacher_ssn) values(ssn_student,code,ssn_teacher);
    end if;
	elseif g between 10 and 12 and email1 = admin_email
	then
	if email1 = any (select es.email from Employees e, High_Schools es
					 where e.school_email = es.email and e.ssn = ssn_teacher and es.name = 'High')
	then
    insert into Courses_Students_taughtBy_Teachers(student_ssn, course_code,teacher_ssn) values(ssn_student,code,ssn_teacher);
end if;
end if;
end if;
end//
delimiter ;

-- #10) Assign teachers to be supervisors to other teachers.
-- fdrop procedure if exists AssignSupervisors;
delimiter //
create procedure AssignSupervisors(t_username varchar(50), supervisor_username varchar(50))
begin
declare t_ssn bigint;
declare supervisor_ssn bigint;
select ssn into t_ssn from Employees e where t_username = e.username;
select ssn into supervisor_ssn from Employees e where supervisor_username = e.username;
if t_ssn is null or supervisor_ssn is null
then
select 'Invalid input';
elseif supervisor_ssn in (select t.ssn from Teachers t where t.years_of_experience > 15)
then
update Teachers set supervised_by = supervisor_ssn
where ssn = t_ssn;
end if;
end//
delimiter ; 

-- #11) Accept or reject the application submitted by parents to their children.
-- drop procedure AcceptStudent;
delimiter //
create procedure AcceptStudent(my_username varchar(50),ssn bigint)
begin
declare x varchar(60);

	select E.school_email into x
	from Employees E
	where E.username = my_username;
    
	update Parents_Schools_appliesFor_Students s
	set s.accepted = 1
	where s.student_ssn = ssn and s.email = x;
end//
delimiter ;

-- drop procedure RejectStudent;
delimiter //
create procedure RejectStudent(my_username varchar(60), ssn bigint)
begin
declare x varchar(60);

	select E.school_email into x
	from Employees E
	where E.username = my_username;
    
	update Parents_Schools_appliesFor_Students s
	set s.accepted = 0
	where s.student_ssn = ssn and s.email = x;
end//
delimiter ;        


drop procedure if exists ViewReviews;
delimiter //
create procedure ViewReviews(school_email varchar(70))
begin
select review from Parents_writeReviews_Schools where email = school_email;
end //
delimiter ;

drop procedure if exists ViewAnnouncements;
delimiter //
create procedure ViewAnnouncements(school_email varchar(70))
begin
select a.* from Announcements a, Employees e where a.administrator_ssn = e.ssn and e.school_email = school_email;
end//
delimiter ;

-- -------------------------------------------------------------------------------------------------------------
-- #Teacher

-- #1 Sign up by providing my first name, middle name, last name, birthdate, address, email, and gender.
-- drop procedure TeacherSignUp;
delimiter //
create procedure TeacherSignUp(ssn bigint, first_name varchar(50), middle_name varchar(50),last_name varchar(50),
birth_date datetime, address varchar(70),email varchar(60), gender varchar(6), school_email varchar(60))
begin
if first_name is null or last_name is null or ssn is null
then select 'Incomplete Input';
else
insert into Employees(ssn, first_name, middle_name, last_name, birth_date, address, email, gender, school_email)
values (ssn, first_name, middle_name,  last_name,birth_date, address, email, gender, school_email);
end if;
end//
delimiter ;

-- #2 View a list of courses’ names I teach categorized by level and grade.
drop procedure if exists ViewCoursesToTeacher;
delimiter //
create procedure ViewCoursesToTeacher(username varchar(50))
begin
declare s bigint;
select ssn into s 
from Employees e 
where e.username = username;

select distinct c.grade, c.name
from Courses_Students_taughtBy_Teachers t inner join Courses c on t.course_code = c.code 
where t.teacher_ssn = s order by c.grade;
end//
delimiter ;

-- #3 Post assignments for the course(s) I teach. Every assignment has a posting date, due date and content.
drop procedure if exists PostAssignments;
delimiter //
create procedure PostAssignments(my_username varchar(50), number int, post_date datetime, course_code varchar(20),
due_date timestamp, content varchar(800))
begin
declare ssn_teacher bigint;
select ssn into ssn_teacher from Employees e where e.username = my_username;
if number is null or post_date is null or course_code is null or due_date is null or content is null
then
select 'Incomplete Input';
else
if course_code = any(select t.course_code from Courses_Students_taughtBy_Teachers t where t.teacher_ssn = ssn_teacher)
then
insert into Assignments(number, date, course_code, due_date, content)
values (number, post_date, course_code, due_date, content);
insert into Assignments_givenBy_Teachers(ssn, post_date, number, code)
values(ssn_teacher, post_date, number, course_code);
else
select 'cannot post assignment';
end if;
end if;
end//
delimiter ;

-- #4 View the students’ solutions for the assignments I posted ordered by students’ ids.
drop procedure if exists ViewSolutions;
delimiter //
create procedure ViewSolutions(my_username varchar(50), course_code varchar(20))
begin
declare ssn_teacher bigint;
select ssn into ssn_teacher from Employees e where e.username = my_username;
select s.username, a.solution from Assignments_Students_solveAndGrade_Teachers a, Students s
where a.ssn = s.ssn and a.teacher_ssn = ssn_teacher and a.code = course_code order by a.ssn;
end//
delimiter ;

-- #5 Grade the students’ solutions for the assignments I posted.
drop procedure if exists GradeAssignments;
delimiter //
create procedure GradeAssignments(my_username varchar(50), ssn_student bigint,
grade real, course_code varchar(20), number int, date datetime)
begin
declare ssn_teacher bigint;
select ssn into ssn_teacher from Employees e where e.username = my_username;
if ssn_teacher = any(select a.ssn from Assignments_givenBy_Teachers a where a.code = course_code and a.number = number and a.post_date = date)
then
update Assignments_Students_solveAndGrade_Teachers a set a.grade = grade
where a.teacher_ssn = ssn_teacher and a.ssn = ssn_student and a.code = course_code and a.number = number and a.post_date = date;
end if;
end//
delimiter ;

-- #6 Delete assignments.
drop procedure if exists DeleteAssignment;
delimiter //
create procedure DeleteAssignment(my_username varchar(50), n int, c varchar(20), p_date datetime)
begin
declare ssn_teacher bigint;
select ssn into ssn_teacher from Employees e where e.username = my_username;
delete from Assignments where number = n and course_code = c and date = p_date;
end//
delimiter ;

-- #7 write monthly report about every student i teach. a report is issued on a specific date to a specific student and contains my comment.
-- drop procedure WriteReport;
delimiter //
create procedure WriteMonthlyReport(my_username varchar(50), student_username varchar(50), date datetime, comment varchar(150))
begin
declare ssn_teacher bigint;
declare ssn_student bigint;
if my_username is null or student_username is null or date is null or comment is null
then
select 'invalid input';
else
select ssn into ssn_teacher from Employees e where e.username = my_username;
select ssn into ssn_student from Students s where s.username = student_username;
insert into Reports(date, ssn, teacher_ssn, comment)
values (date, ssn_student, ssn_teacher, comment);
end if;
end//
delimiter ; 

-- check if i give this student
drop procedure if exists checkStudent;
delimiter //
create procedure checkStudent(my_username varchar(50), student_username varchar(50))
begin
select * from Courses_Students_taughtBy_Teachers c ,Students s, Employees e
where c.teacher_ssn = e.ssn and c.student_ssn = s.ssn and s.username = student_username and e.username = my_username;
end//
delimiter ;

-- call checkStudent('sherif.hamdyy','zayd.elnaggar');

-- #8 View Questions asked by the students for each course i teach
drop procedure if exists ViewQuestionsToTeachers;
delimiter //
create procedure ViewQuestionsToTeachers(my_username varchar(50), code varchar(20))
begin
declare ssn_teacher bigint;
select ssn into ssn_teacher from Employees e where e.username = my_username;
if ssn_teacher = any (select teacher_ssn from Courses_Students_taughtBy_Teachers where course_code = code)
then
select q.text, q.time_stamp,q.ssn, s.name from Questions q, Students s where code = course_code and q.ssn = s.ssn;
end if;
end//
delimiter ;

drop procedure if exists ViewCoursesQuestions;
delimiter //
create procedure ViewCoursesQuestions(my_username varchar(50))
begin
declare ssn_teacher bigint;
select ssn into ssn_teacher from Employees e where e.username = my_username;

select c.course_code from Courses_Students_taughtBy_Teachers c, Questions q
where ssn_teacher = c.teacher_ssn and c.course_code = q.course_code;
end//
delimiter ;


-- #9 Answer the questions asked by the students for each course i teach.
drop procedure if exists AnswerQuestions;
delimiter //
create procedure AnswerQuestions(my_username varchar(50), code1 varchar(20), answer1 varchar(200),
ssn_student bigint, time_stamp timestamp)
begin
declare ssn_teacher bigint;
select ssn into ssn_teacher from Employees e where e.username = my_username;
if time_stamp is null or code1 is null or ssn_student is null or ssn_teacher is null or answer1 is null
then
select 'invalid input';
else
if ssn_teacher = any (select teacher_ssn from Courses_Students_taughtBy_Teachers where course_code = code1)
then
insert into Questions_answeredBy_Teachers(time_stamp, code, ssn, teacher_ssn, answer)
values (time_stamp, code1,ssn_student, ssn_teacher, answer1);
-- update Questions_answeredBy_Teachers set answer = answer1
-- where teacher_ssn = ssn_teacher and ssn = ssn_student and code = code1;
end if;
end if;
end//
delimiter ;



drop procedure if exists ListStudents;
-- #10 view a list of students that i teach categorized by the grade and ordered by their name(first name and last name).
delimiter //
create procedure ListStudents(my_username varchar(50))
begin
declare ssn_teacher bigint;
select ssn into ssn_teacher from Employees e where e.username = my_username;
select distinct s.name, s.grade, t.course_code from Courses_Students_taughtBy_Teachers t, Students s
where s.ssn = t.student_ssn and t.teacher_ssn = ssn_teacher order by s.grade, s.name;
end//
delimiter ;


-- #11 View a list of students that did not join any activity.
-- students ana badeehom wla ay students?
drop procedure if exists NotInActivity;
delimiter //
create procedure NotInActivity(my_username varchar(50))
begin
declare teacher_email varchar(60);
select school_email into teacher_email from Employees where username = my_username;
select s.*
from Students s
where s.ssn not in (select a.ssn from Activities_participatedInBy_Students a) and s.school_email = teacher_email;
end//
delimiter ;

-- #12 Display the name of the high school student who is currently a member of the greatest number of clubs.
drop procedure if exists HighestClubParticipation;
delimiter //
create procedure HighestClubParticipation(my_username varchar(50))
begin
declare teacher_email varchar(60);
select school_email into teacher_email from Employees where username = my_username; 
create table tmp select count(*) as 'c' from Clubs_joinedBy_Students group by ssn;

select s.name, s.ssn,count(s.ssn) from Clubs_joinedBy_Students c, Students s
where c.ssn = s.ssn and c.email = s.school_email group by s.ssn
having  count(s.ssn) = (select max(tmp.c) from tmp);
end//
delimiter ;


-- -------------------------------------------------------------------------------------------------------------------

-- Parents

-- 1) Sign up by providing my name (first name and last name), contact email, mobile number(s), address, home phone number, a unique username and password.
delimiter //
create procedure SignUp(ssn bigint,first_name varchar(50), last_name varchar(50),email varchar(60), address varchar(70),
home_number int, username varchar(50), password varchar(50))
begin
	if ssn is null or first_name is null or last_name is null 
	then select 'Invalid Input';
	end if;
	if username = any (select u.username from Users u where u.username = username)
	then select 'Oops!! Username already exists';
	else
	insert into Users(username, password)
				values (username,password);
	insert into Parents(ssn, username, first_name, last_name,email,home_number, address)
				values(ssn, username, first_name, last_name,email,home_number, address);
	end if;
end//
delimiter ;

delimiter //
create procedure AddMobileNumbers(ssn bigint, mobile_number bigint)
begin
insert into Parents_Mobile_Numbers(ssn, mobile_number)
							values(ssn, mobile_number);
end//
delimiter ;


-- 2)Apply for my children in any school. For each child I should provide his/her social security number(SSN), name, birthdate, and gender
drop procedure if exists ApplyFor;
delimiter //
create procedure ApplyFor(my_username varchar(50),s_email varchar(60),ssn bigint, name varchar(50),
birth_date datetime, gender varchar(6),grade int)
begin
declare me bigint;
	select P.ssn into me
	from Parents P
	where P.username = my_username;

	if ssn is null or name is null or s_email is null
	then select 'Incomplete Input';
	else
		if ssn not in (select s.ssn from Students s where s.ssn = ssn)
        then
		insert into Students(ssn,name,birth_date,gender,grade,parent_ssn)
		values(ssn,name,birth_date,gender,grade,me);
		end if;
		insert into Parents_Schools_appliesFor_Students(parent_ssn, email,student_ssn)
		values (me,s_email,ssn);
	end if;
end//
delimiter ;

-- 3) View a list of schools that accepted my children categorized by child
drop procedure if exists ViewSchoolsThatAccepted;
delimiter //
create procedure ViewSchoolsThatAccepted(my_username varchar(50))
begin
	declare x bigint;

	select P.ssn into x
	from Parents P
	where P.username = my_username;

	select S.name, S.email, St.name as 'Student Name', St.ssn
	from Parents_Schools_appliesFor_Students A join Schools S on A.email = S.email join Students St on St.ssn = A.student_ssn
	where x = A.parent_ssn and A.accepted = 1  
	order by A.student_ssn;

end//
delimiter ;


-- 4) Choose one of the schools that accepted my child to enroll him/her. 
-- The child remains unverified(no username and password, refer to user story 2 for the administrator) until the admin verifies him.
drop procedure if exists EnrollChild;
delimiter //
create procedure EnrollChild(my_username varchar(50), chosen_school_email varchar(50), child_ssn bigint)
begin
	declare me bigint;
    
	select P.ssn into me
	from Parents P
	where P.username = my_username;
    
	if chosen_school_email =  any (select A.email 
								   from Parents_Schools_appliesFor_Students A  
								   where A.email = chosen_school_email and A.accepted = 1 and A.student_ssn = child_ssn and A.parent_ssn = me)
	and 
       child_ssn in (select S.ssn
						 from Students S
						 where school_email is null)
	then
       update Students S set school_email = chosen_school_email where S.ssn = child_ssn;
    else 
    select 'Invalid Input';
    
    end if;
end//
delimiter ;

-- 5) View reports written about my children by their teachers
-- view one child or all my children at once?
drop procedure if exists ViewReports;
delimiter //
create procedure ViewReports(my_username varchar(50))
begin
	declare x bigint;

	select P.ssn into x
	from Parents P
	where P.username = my_username;
	
    select distinct S.name, concat(E.first_name,E.last_name) as 'Teacher', R.comment, S.ssn, R.date, E.ssn as 't_ssn'
    from Parents P  join Students S on S.parent_ssn = x  
				    join Reports R on S.ssn = R.ssn
                    join Employees E on E.ssn = R.teacher_ssn
    order by S.ssn;
end//
delimiter ;


--  6) Reply to reports written about my children by their teachers.
delimiter //
create procedure replyToReport(my_username varchar(50),date datetime,ssn bigint,teacher_ssn bigint,reply varchar(200))
begin
    declare me bigint;

	if ssn is null or teacher_ssn is null or date is null
    then select 'Invalid Report';
    else
    
	select P.ssn into me
	from Parents P
	where P.username = my_username;
    
    insert into Parents_viewAndReply_Report(date,ssn,teacher_ssn,parent_ssn,reply)
    values(date,ssn,teacher_ssn,me,reply);
    
    end if;
end//
delimiter ;


-- 7)View a list of all schools of all my children ordered by its name.
drop procedure if exists ViewChildrensSchools;
delimiter //
create procedure ViewChildrensSchools(my_username varchar(50))
begin
	declare me bigint;
    
	select P.ssn into me
	from Parents P
	where P.username = my_username;
    
    select distinct Sc.name, Sc.email
    from Students St, Schools Sc
    where St.parent_ssn = me and St.school_email = Sc.email
    order by Sc.name;
end//
delimiter ;
 
-- 8) View the announcements posted within the past 10 days about a school if one of my children is enrolled in it.
delimiter //
create procedure View10PastAnnouncementsByParent(my_username varchar(50), currentDate datetime)
begin
	declare me bigint;
	select P.ssn into me
	from Parents P
	where P.username = my_username;
    
	select an.* from Announcements an, Admimistrator ad, Employees e, Students s
	where s.parent_ssn = me and an.administrator_ssn = ad.ssn and ad.ssn = e.ssn and e.school_email = s.school_email and currentDate -an.date <= 10 ;
end//
delimiter ;	

-- 9) Rate any teacher that teaches my children.
drop procedure if exists RateTeacher;
delimiter //
create procedure RateTeacher(my_username varchar(50),teacher_ssn bigint, rating int)
begin
	declare me bigint;
	
    select P.ssn into me
	from Parents P
	where P.username = my_username;
    
    
    if  teacher_ssn in (select E2.teacher_ssn
					from Courses_Students_taughtBy_Teachers E2, Students S
					where S.parent_ssn = me )
    then
    insert into Parent_Rates_Teacher(teacher_ssn,parent_ssn,rating)
    values(teacher_ssn,me,rating);
    else
    select 'Teacher doesn''t teach any of your children';
end if;
end//
delimiter ;
  
-- 10) Write reviews about my children’s school(s).
-- drop procedure WriteReview;
delimiter //
create procedure WriteReview(my_username varchar(50),school_email varchar(60),review varchar(100))
begin
	declare me bigint;
    declare check_email varchar(60);
	if review is null or school_email is null or my_username is null
    then select 'Incomplete Input';
    else
    
    select P.ssn into me
	from Parents P
	where P.username = my_username;
    -- check that I'm reviewing a school of my child
    if me in ( select S.parent_ssn
			   from Students S
			   where S.parent_ssn = me and S.school_email = school_email)
    then
    insert into parents_writereviews_schools(ssn,email,review)
    values (me,school_email,review);
 end if;
 end if;
end//
delimiter ;

-- 11) Delete a review that i have written. (Assuming that a parent writes 1 review per school)
delimiter //
create procedure deleteReview(my_username varchar(50),school_email varchar(60))
begin
declare me bigint;
    
	select P.ssn into me
	from Parents P
	where P.username = my_username;
    
	delete from  Parents_writeReviews_Schools  where ssn = me and email = school_email;
end//
delimiter ;


 -- 12) View the overall rating of a teacher, where the overall rating is calculated as the average of ratings provided by parents to that teacher.
drop procedure if exists ViewOverAllRating;
 delimiter // 
 create procedure ViewOverallRating(teacher_username varchar(50)) 
 begin
 declare t_ssn bigint;
    
	select T.ssn into t_ssn
	from Employees T
	where T.username = teacher_username;
    
    select concat(E.first_name, E.last_name) as 'Teacher' , avg(PRT.rating) as 'rating'
    from Parent_rates_Teacher PRT, Employees E
    where PRT.teacher_ssn = t_ssn and t_ssn = E.ssn
    group by teacher_ssn;
end//
delimiter ;

   
-- 13) View the top 10 schools with the highest number of reviews or highest number of enrolled students. This should exclude schools that my children are enrolled in.
delimiter //
create procedure Top10SchoolsByReviews(my_username varchar(50))
begin
declare me bigint;
    
 	select P.ssn into me
 	from Parents P
 	where P.username = my_username;
    
	select S.*,count(PWR.review) as 'Number of Reviews' 
	from Schools S join Parents_writeReviews_Schools PWR on S.email = PWR.email
	where S.email not in (select S2.school_email
 						  from students S2
                          where S2.parent_ssn = me)
   group by S.email
   order by count(PWR.review) desc
   limit 10;

    
end//
delimiter ;


delimiter //
create procedure Top10SchoolsByStudents(my_username varchar(50))
begin
declare me bigint;
select ssn into me from Parents where username = my_username;
	select S.*, count(*) as 'Number of Students'
    from Students St, Schools S 
    where S.email = St.school_email and S.email not in (select S2.school_email
														from Students S2
														where S2.parent_ssn = me)
    group by S.email
    order by count(*) desc limit 10;
    
end//
delimiter ;	

-- 14) Find the international school which has a reputation higher than all national schools, i.e. has the highest number of reviews.

delimiter //
create procedure InternationalsHigherThanAllNationals()
begin
declare x int;

select count(PWR2.review) into x
from  Schools S2 join Parents_writeReviews_Schools PWR2 on S2.email = PWR2.email
where S2.type = 'National' group by S2.email
order by count(PWR2.review) desc limit 1;
                                                                 

	select S.*
    from Schools S join Parents_writeReviews_Schools PWR on S.email = PWR.email
    where S.type = 'International'
    group by PWR.email
    having  count(PWR.review) > x ; 
    
end//
delimiter ;
   

-- ---------------------------------------------------------------------------------------------------------------------------
-- #STUDENT

-- As an enrolled student, I should be able to ...
-- 1  Update my account information except for the username.
-- Update my ssn 
delimiter //
create procedure UpdateSsn(username1 varchar(50), ssn2 bigint)
begin
if username1 is null or ssn2 is null
then select 'Invalid input';
else update Students 
	 set ssn = ssn2
     where username = username1;
end if;
end//
delimiter ;

-- Update my name
delimiter //
create procedure UpdateName(username1 varchar(50), name2 varchar(50))
begin
if username1 is null or name2 is null
then select 'Invalid input';
else update Students 
	 set name = name2
     where username= username1;
end if;
end//
delimiter ;

-- Update my password
delimiter //
create procedure UpdatePassword(username1 varchar(50), password2 varchar(50))
begin
if username1 is null or password2 is null
then select 'Invalid input';
else update Users 
	 set password = password2
     where username = username1;
end if;
end//
delimiter ;

-- Update my gender
delimiter //
create procedure UpdateGender(username1 varchar(50), gender2 varchar(6))
begin
if username1 is null or gender2 is null
then select 'Invalid input';
else update Students 
	 set gender = gender2
     where username= username1;
end if;
end//
delimiter ;
-- Update my birth date
delimiter //
create procedure UpdateBirthDate(username1 varchar(50), birthdate datetime)
begin
if username1 is null or birthdate is null
then select 'Invalid input';
else update Students 
	 set birth_date = birthdate
     where username= username1;
end if;
end//
delimiter ;


-- 2 View a list of courses’ names assigned to me based on my grade ordered by name.
drop procedure if exists ViewCoursesToStudent;
delimiter // 
create procedure ViewCoursesToStudent(myusername varchar(50))
begin
declare g int;
declare ssn bigint;
if myusername is null 
then select 'Invalid input';
else
select s.ssn into ssn from Students s where s.username = myusername;
select s.grade into g from Students s where s.username = myusername;
select c.name,c.code
from Courses_Students_taughtBy_Teachers x join Courses c on c.code = x.course_code
where x.student_ssn = ssn and c.grade = g
order by c.name;
end if;
end//
delimiter ;

-- 3 Post questions I have about a certain course.
-- drop procedure PostQuestions;
delimiter // 
create procedure PostQuestions(myusername varchar(50), code varchar(20), text varchar(150), date timestamp)
begin
declare s bigint;
if myusername is null
then select 'Invalid input';
else
select ssn into s from Students where username = myusername;
insert into Questions(time_stamp,course_code,ssn,text)
values(date,code,s,text);
end if;
end//
delimiter ;

-- 4 View all questions asked by other students on a certain course along with their answers.
-- drop procedure ViewQuestionsToStudent;
delimiter //
create procedure ViewQuestionsToStudent(code varchar(20),myusername varchar(50))
begin
declare s_ssn bigint;
declare semail varchar(50);
if code is null or myusername is null
then select 'Invalid input';
else
select school_email into semail
from Students where username = myusername;
select ssn into s_ssn 
from Students S where username = myusername;
select q.text,a.answer
from Questions q join Questions_answeredBy_Teachers a on a.time_stamp = q.time_stamp and a.code = q.course_code
and a.ssn = q.ssn join Students s on a.ssn = s.ssn
where a.code = code and s.school_email = semail;

end if;
end//
delimiter ;

-- 5 View the assignments posted for the courses I take.
drop procedure if exists ViewAssignments;
delimiter //
create procedure ViewAssignments(myusername varchar(50), course_code varchar(20))
begin
declare s bigint;
if myusername is null
then select 'Invalid input';
else select ssn into s from Students where username = myusername;
select a.*
from Assignments a, Courses_Students_taughtBy_Teachers t
where a.course_code = course_code and a.course_code = t.course_code and s= t.student_ssn
order by a.course_code;
end if;
end//
delimiter ;

-- 6 Solve assignments posted for courses I take.
delimiter //
create procedure SolveAssignment(myusername varchar(50), number int, post_date datetime, code varchar(20), solution varchar(1200))
begin
declare t_ssn bigint;
declare s_ssn bigint;
if myusername is null or number is null or post_date is null or code is null or solution is null
then select 'Invalid input';
else select ssn into s_ssn from Students where myusername = username;
select teacher_ssn into t_ssn from Courses_Students_taughtBy_Teachers 
where student_ssn = s_ssn and code = course_code;
insert into Assignments_Students_solveAndGrade_Teachers(ssn, number,post_date,code,
teacher_ssn,solution)
values(s_ssn,number,post_date,code,t_ssn,solution);
end if;
end//
delimiter ;

-- 7 View the grade of the assignments I solved per course.
delimiter //
create procedure ViewGrades(myusername varchar(50))
begin
declare s_ssn bigint;
if myusername is null
then select 'Invalid input';
else select ssn into s_ssn from Students where myusername = username;
select code,number, grade
from Assignments_Students_solveAndGrade_Teachers
where ssn = s_ssn
order by code;
end if;
end//
delimiter ;

-- 8 View the announcements posted within the past 10 days about the school I am enrolled in.
-- drop procedure if exists ViewAnnouncementToStudent;
delimiter //
create procedure ViewAnnouncementToStudent(myusername varchar(50),date datetime)
begin
declare s_email varchar(60);
if myusername is null
then 
select 'Invalid input';
else
select school_email into s_email from Students where myusername = username;
select an.* from Announcements an, Administrators ad, Employees e
where an.administrator_ssn = ad.ssn and ad.ssn = e.ssn and e.school_email = s_email and date-an.date <= 10;
end if;
end//
delimiter ;

-- 9 View all the information about activities offered by my school, as well as the teacher responsible for it.
delimiter //
create procedure ViewActivities(myusername varchar(50))
begin
declare semail varchar(70);
if myusername is null
then select 'Invalid input';
else select school_email into semail from Students where myusername = username;
select a.id, a.name, a.date, a.location, a.type, a.description, a.equipment, e.first_name, e.last_name 
from Activities a join Employees e on e.ssn = a.teacher_ssn 
where e.school_email = semail;
end if;
end//
delimiter ;

-- 10 Apply for activities in my school on the condition that I can not join two activities of the same type on the same date.
-- drop procedure ApplyForActivities;
delimiter //
create procedure ApplyForActivities(myusername varchar(50), activityid int)
begin
declare semail varchar(70);
declare tsemail varchar(50);
declare ssn bigint;
declare atype varchar(50);
declare adate datetime;
if myusername is null or activityid is null
then select 'Invalid input';
else 
select date into adate from Activities where activityid = id;
select type into atype from Activities where activityid = id;
select s.ssn into ssn from Students s where myusername = s.username;
select school_email into semail from Students where myusername = username;
select e.school_email into tsemail 
from Employees e join Activities a on a.teacher_ssn = e.ssn
where a.id = activityid;
if semail = tsemail
then if adate = any( select a.date from Activities a join Activities_participatedInBy_Students s
on a.id = s.id
where s.ssn = ssn and a.type = atype)
then select 'Can not join two activities of the same type on the same date.';
else insert into Activities_participatedInBy_Students(ssn,id)
values(ssn,activityid);
end if;
end if;
end if;
end//
delimiter ;

-- 11 Join clubs offered by my school, if I am a highschool student.
-- drop procedure JoinClubs;
delimiter //
create procedure JoinClubs(myusername varchar(50), clubname varchar(50))
begin 
declare semail varchar(70);
declare s_ssn bigint;
declare g int;
if myusername is null or clubname is null
then select 'Invalid input';
else 
select ssn into s_ssn from Students where myusername = username;
select school_email into semail from Students where myusername = username;
select grade into g from Students where myusername = username;
if g between 10 and 12
then insert into Clubs_joinedBy_Students(ssn,name,email) 
values(s_ssn,clubname,semail);
else select 'You are not a high school student';
end if; 
end if;
end//
delimiter ;

-- 12 Search in a list of courses that i take by its name or code.
delimiter //
create procedure SearchCourses(myusername varchar(50), keyword varchar(50))
begin
declare s_ssn bigint;
if myusername is null or keyword is null
then select 'Invalid input';
else select ssn into s_ssn from Students where myusername = username;
select c.* from Courses c join Courses_Students_taughtBy_Teachers a on a.course_code = code
where s_ssn = student_ssn and (c.code = keyword or c.name = keyword);
end if;
end//
delimiter ;





















   
   











      













 
 