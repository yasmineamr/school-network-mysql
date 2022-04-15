use SchoolNetwork;


call DeleteSchool('oasis@hotmail.com');

call SearchSchools('Nefertari International School');
call SearchSchools('National');
call SearchSchools('8 Mohamed Mahmoud Street, Downtown, Cairo, Egypt');

call CategorizeSchools();

-- TeacherSignUp(ssn bigint, first_name varchar(50), middle_name varchar(50),last_name varchar(50),
-- birth_date datetime, address varchar(70),email varchar(60), gender varchar(6), school_email varchar(60))

call TeacherSignUp(1564398250,'Laila','Ahmed','Khallaf','1990/3/5','19 Dr. Ahmed Seoud Street Agouza, Cairo, Egypt','lailakhallaf@hotmail.com','female','portsaidschool@hotmail.com');
call TeacherSignUp(65748494870988,'Hoda','Mohamed','Adham','1965/12/10','19 Dr. Mohamed Shaheen Agouza, Cairo, Egypt','hodaadham@hotmail.com','female','aisinternationalschool@gmail.com');
call TeacherSignUp(76845342540980,'Reem','Gomaa','Safaan','1970/10/9','G1 Sondos, Golf City, Obour City, Egypt','reemgomaa@gmail.com','female','mls@gmail.com');
call TeacherSignUp(65748907654435, 'Samah', 'Atta','Fathy','1972/3/4', '21 Road 265, New Maadi, Cairo, Egypt','samah_fathy@hotmail.com','female', 'dsb@gmail.com');
call TeacherSignUp(54637890876543,'Ahmed','Mohamed','Salah','1985/3/3','Villa 33A Beverly Hills, 6th of October,Cairo, Egypt','ahmedsalah85@gmail.com','male','aisinternationalschool@gmail.com');
call TeacherSignUp(75645342908713,'Sherif','Hamdy','AbdelHameed','1990/3/6','201 Road 8, Maadi, Cairo, Egypt','sherifhameed@gmail.com','male','mls@gmail.com');
call TeacherSignUp(65790987654678,'Sameer','Maged','Shenawy','1960/5/5','35 Shehab Street, Mohandseen, Cairo, Egypt','sameershenawy@hotmail.com','male','mls@gmail.com');

call TeacherSignUp(22222222222222,'yasmine','amr','ahmad','2011/11/11','maadi','yasmine@gmail.com','female','school_email@gmail.com');

call ViewTeachers('mohamed.khattab');
call ViewTeachers('mahmoud.elsayad');
call ViewTeachers('fawzy.sobhy');
call ViewTeachers('mina.sameh');

call VerifyTeacher(65790987654678,'sameer.shenawyy','mohamed.khattab');
call VerifyTeacher(75645342908713,'sherif.hamdyy','mohamed.khattab');
call VerifyTeacher(1564398250,'laila.khallaf1','mohamed.khattab');
call VerifyTeacher(65748907654435, 'samah.atta','mohamed.khattab');
call VerifyTeacher(1564398250, 'laila.lola', 'mahmoud.elsayad');
call VerifyTeacher(65748494870988, 'dodo.adham','fawzy.sobhy');
call VerifyTeacher(54637890876543, 'ahmad.saloha', 'fawzy.sobhy');
call VerifyTeacher(76845342540980, 'reembow.safaan','mohamed.khattab');
call VerifyTeacher(65748907654435, 'samah.atta', 'mina.sameh');


call AddAdmins('mohamed.khattab',25463789076543,'ahmed.salem',123456,'Ahmed','Mohamed','Salem','1988/4/5','4 Ahmed Kamal Street, Mohandseen, Cairo, Egypt','ahmedsalem@gmail.com','male');


call PostAnnouncements('2016/10/1','6th of October Holiday','Holiday','Next Thursday is a national holiday','ahmed.salem');
call PostAnnouncements('2016/11/20','End of Semester','Holiday','Last day of classes is 10/12','ahmed.salem');


call EditEmail('mls2@gmail.com', 'ahmed.salem');
call EditName('Misr Languages School','ahmed.salem');
call EditType('International', 'ahmed.salem');
call EditFees(20000, 'ahmed.salem');
call EditGeneralInformation('general information NEW','ahmed.salem');
call EditVision('vision2','ahmed.salem');
call EditMission('mission2','ahmed.salem');
call EditLanguage('English, Spanich','ahmed.salem');
call EditPhoneNumber(0235467589,'ahmed.salem');

-- Create_AssignActivities(name varchar(50),date datetime,location varchar(50),type varchar(50), description varchar(50),
-- equipment varchar(50), administrator_ssn bigint, teacher_ssn bigint)
call Create_AssignActivities('Football Tournament', '2016/12/3','Football Field','sports','The AIS boys team vs our boys team','Footballs and whistles',25463789076543, 75645342908713);
call Create_AssignActivities('Football Tournament', '2016/12/3','Football Field','sports','The AIS girls team vs our girls team','Footballs and whistles',25463789076543, 75645342908713);
call Create_AssignActivities('MLS Got Talent', '2016/12/3','MLS Theater','entertainment','It''s time to show your talented side','Microphones and speakers',25463789076543, 75645342908713);
call Create_AssignActivities('MLS Drama', '2016/12/3','MLS Theater','entertainment','Our Annual Winter Drama','Microphones and speakers',25463789076543, 75645342908713);


call ChangeTeacherActivity('sameer.shenawyy',1);

update Teachers
set date_of_hire = '1996/1/1'
where ssn = 75645342908713;

-- call AssignSupervisors(65790987654678,75645342908713);
call AssignSupervisors('sameer.shenawyy','sherif.hamdyy');

--  SignUp(ssn int,first_name varchar(50), last_name varchar(50),email varchar(60), address varchar(70),
-- home_number int, username varchar(50), password varchar(50))

call SignUp(19078695009867,'Osama','Shams','oshams@gmail.com','12 Taha Hussein Street, Zamalek, Cairo, Egypt',0227645209,'osama.shams',123456);
call SignUp(16574890657488,'Salma','Seyam','salma82@hotmail.com','11 Mohamed Ayoub Street, Mohandseen, Cairo, Egypt',0237689934,'salma.seyam',123456);
call SignUp(98765365890987, 'Reem','Waheed','reemw@hotmail.com','20 Gamet El Dowal Street, Mohandseen, Cairo, Egypt',0235467655,'reem.waheed',123456);
call SignUp(54657789098324,'Nada','Sameh','nadasameh92@gmail.com','196 Buildings C AlAshgar City, 6th of October, Cairo, Egypt',0235434321,'nada.sameh',123456);
call SignUp(45367890987654,'Menna','Monir','mannonaelamora@hotmail.com','21 Road 200, Maadi, Cairo, Egypt',0225465789,'menna.monir',123456);
call SignUp(89098763542154,'Laila','Malatawy','lailalola@gmail.com','1 Ramo Appartment House El Nasr Road, Nasr City, Cairo, Egypt',0224191570,'lailamalatawy',123456);
call SignUp(564738909876312, 'Wafaa','Adham','wafaadham@hotmail.com','14A Anas ebn Malk Street, Giza, Egypt',0233369302,'wafaadham',123456);
call SignUp(78786534209876,'Legolas','GreenLeaf','legolasgl@hotmail.com','Middle Earth Mirkood, Cairo, Egypt',0234453676,'legoleaf',123456);
call SignUp(79810665271275,'Abeer', 'Khaled', 'abeer.khaled@gmail.com','417 Haram St., Giza, Egypt', 0233876195,'abeer.khaled',123456); 

-- call SignUp(222,'yasmine','amr','yasmine@gmail.com','maadi','1','y','a');

-- delete from Parents where ssn = 222;
-- delete from Users where username = 'a';

-- call AddMobileNumbers(222,1);
-- call AddMobileNumbers(222,2);
-- call AddMobileNumbers(222,3);

call ApplyFor('nada.sameh', 'mls2@gmail.com', 19736287619873, 'Zayd Elnaggar', '2007/8/28','Male', 3);
call ApplyFor('nada.sameh', 'mls2@gmail.com', 71965208910954, 'Mirna Elnaggar', '2008/8/28','Female', 2);
call ApplyFor('legoleaf', 'aisinternationalschool@gmail.com', 38491758495432, 'Aragorn Legolas', '2010/3/5','Male', 1);
call ApplyFor('osama.shams', 'portsaidschool@hotmail.com', 10293847564738, 'Mohamed Osama', '2004/7/4', 'Male', 7);
call ApplyFor('osama.shams', 'portsaidschool@hotmail.com', 73890618293749,'Hamdeya Osama','2006/5/5' ,'Female', 5);
call ApplyFor('salma.seyam', 'dsb@gmail.com', 48906491572908, 'Carla Hamdy', '2010/7/3', 'Female', 1);
call ApplyFor('reem.waheed', 'bashaermaadi@gmail.com', 74390126876490, 'Hamada Ayman', '2001/4/2', 'Male',10);
call ApplyFor('menna.monir', 'bashaermaadi@gmail.com', 47895621008744, 'Celine Menshawy', '2002/12/12', 'Female',9);
call ApplyFor('lailamalatawy','nefertari@gmail.com',22746054028379,'Ahmos Shabrawy', '2000/12/2', 'Male' ,12);
call ApplyFor('wafaadham','lyceefrancaismaadi@hotmail.com', 46373847264728, 'Mahdy Slim El Mougy', '2003/3/3','Male', 8);
call ApplyFor('salma.seyam', 'lyceefrancaismaadi@hotmail.com', 48906491572908, 'Carla Hamdy', '2010/7/3', 'Female', 1);
call ApplyFor('abeer.khaled', 'mls2@gmail.com', 97654733219076, 'Menna Ahmed', '2001/6/24', 'Female', 11);
call ApplyFor('lailamalatawy','mls2@gmail.com',11967543908001, 'Salma Karim', '2007/10/28','Female', 3);
call ApplyFor('abeer.khaled', 'lyceefrancaismaadi@hotmail.com', 56478765343423, 'Carmen Ahmed', '2010/7/3', 'Female', 1);
call ApplyFor('abeer.khaled', 'mls2@gmail.com', 87645376509876, 'Sara Ahmed', '2000/6/24', 'Female', 12);
call ApplyFor('nada.sameh','mls2@gmail.com',64537689076523,'Aisha Elnaggar','2002/10/3','Female',10);
call ApplyFor('legoleaf', 'bashaermaadi@gmail.com', 26839286382017, 'Frodo Baggins', '2003/3/5','Male', 8);
call ApplyFor('legoleaf', 'lyceefrancaismaadi@hotmail.com', 12345678910237, 'Kili Oakenshield', '2003/4/7','Male', 8);

call AcceptStudent('mohamed.khattab', 19736287619873);
call AcceptStudent('sara.hesham', 46373847264728);
call AcceptStudent('ahmed.farouk', 47895621008744);
call AcceptStudent('sara.hesham', 48906491572908);
call AcceptStudent('mina.sameh',48906491572908);
call AcceptStudent('ahmed.farouk', 74390126876490);
call AcceptStudent('mohamed.khattab',71965208910954);
call AcceptStudent('mohamed.khattab',97654733219076);
call AcceptStudent('fawzy.sobhy',38491758495432);
call AcceptStudent('mohamed.khattab',11967543908001); -- this
call AcceptStudent('sara.hesham',56478765343423);
call AcceptStudent('mohamed.khattab',87645376509876);
call AcceptStudent('mohamed.khattab',64537689076523);
call AcceptStudent('ahmed.farouk',26839286382017);
call AcceptStudent('sara.hesham', 12345678910237);

call RejectStudent('mahmoud.elsayad',10293847564738);

call ViewSchoolsThatAccepted('menna.monir');
call ViewSchoolsThatAccepted('salma.seyam');
call ViewSchoolsThatAccepted('osama.shams');
call ViewSchoolsThatAccepted('legoleaf');
call ViewSchoolsThatAccepted('nada.sameh');
call ViewSchoolsThatAccepted('lailamalatawy'); -- this

call EnrollChild('nada.sameh', 'mls2@gmail.com',19736287619873);
call EnrollChild('legoleaf', 'aisinternationalschool@gmail.com', 38491758495432);
call EnrollChild('nada.sameh','mls2@gmail.com',71965208910954);
call EnrollChild('abeer.khaled','mls2@gmail.com',97654733219076);
call EnrollChild('lailamalatawy','mls2@gmail.com', 11967543908001);
call EnrollChild('abeer.khaled','lyceefrancaismaadi@hotmail.com',56478765343423);
call EnrollChild('abeer.khaled','mls2@gmail.com',87645376509876);
call EnrollChild('nada.sameh','mls2@gmail.com',64537689076523);
call EnrollChild('wafaadham','lyceefrancaismaadi@hotmail.com',46373847264728);
call EnrollChild('salma.seyam','lyceefrancaismaadi@hotmail.com',48906491572908);
call EnrollChild('legoleaf','bashaermaadi@gmail.com', 26839286382017);
call EnrollChild('legoleaf','lyceefrancaismaadi@hotmail.com', 12345678910237);
call EnrollChild('wafaadham','lyceefrancaismaadi@hotmail.com',46373847264728);

call ViewStudents('mohamed.khattab');
call ViewStudents('fawzy.sobhy');
call ViewStudents('sara.hesham');
call ViewStudents('mahmoud.elsayad');

call VerifyStudents(19736287619873,'zayd.elnaggar','mohamed.khattab');
call VerifyStudents(71965208910954,'mirna.elnaggar','mohamed.khattab');
call VerifyStudents(97654733219076,'menna.ahmed', 'mohamed.khattab');
call VerifyStudents(46373847264728, 'mahdy.elmougy','sara.hesham');
call VerifyStudents(47895621008744, 'celine,menshawy', 'ahmed.farouk');
call VerifyStudents(48906491572908, 'carla.hamdy', 'sara.hesham');
call VerifyStudents(74390126876490, 'hamada.ayman', 'ahmed.farouk');
call VerifyStudents(38491758495432, 'aragornlego', 'fawzy.sobhy');
call VerifyStudents(11967543908001,'salma.karim','mohamed.khattab');
call VerifyStudents(56478765343423,'carmen.ahmed','sara.hesham');
call VerifyStudents(87645376509876,'sara.ahmed','mohamed.khattab');
call VerifyStudents(64537689076523,'aisha.elnaggar','mohamed.khattab');
call VerifyStudents(26839286382017,'frodo.baggins','ahmed.farouk');
call VerifyStudents(12345678910237,'kili.oakenshield','sara.hesham');

-- AssignTeacherCourses(my_username varchar(50), teacher_username varchar(50), code varchar(50),student_username varchar(50)) -- USERNAME NOT SSN

-- call DeleteEmployees(18670976467465,'sara.hesham');

call AssignTeacherCourses('mohamed.khattab', 'sherif.hamdyy','Arabic3','zayd.elnaggar');
call AssignTeacherCourses('mohamed.khattab', 'sherif.hamdyy','Math3','zayd.elnaggar');
call AssignTeacherCourses('mohamed.khattab', 'sherif.hamdyy','Arabic3','salma.karim'); -- this
call AssignTeacherCourses('mohamed.khattab', 'sameer.shenawyy', 'Science2','mirna.elnaggar');
call AssignTeacherCourses('mohamed.khattab', 'sameer.shenawyy', 'Math11','menna.ahmed');
call AssignTeacherCourses('fawzy.sobhy', 'ahmad.saloha', 'Math1', 'aragornlego');
call AssignTeacherCourses('fawzy.sobhy', 'ahmad.saloha', 'English1', 'aragornlego');

call ViewCoursesToTeacher('sherif.hamdyy');
call ViewCoursesToTeacher('sameer.shenawyy');
call ViewCoursesToTeacher('ahmad.saloha');

--  PostAssignments(my_username varchar(50), number int, post_date datetime, course_code varchar(20),
-- due_date timestamp, content varchar(800))

call PostAssignments('sherif.hamdyy', 1,'2016/11/23', 'Arabic3', '2016/12/1 11:59:59',
'question 1 question 2 question 3');
call PostAssignments('sherif.hamdyy', 2, '2016/12/2', 'Arabic3','2016/12/10 11:59:59',
'question 1 question 2 question 3');
call PostAssignments('sherif.hamdyy',1,'2016/11/25', 'Math3','2016/12/2 11:59:59',
'question 1 question 2 question 3');
call PostAssignments('sameer.shenawyy',1,'2016/11/23', 'Science2','2016/12/1 11:59:59',
'question 1 question 2');
call PostAssignments('sameer.shenawyy',2,'2016/12/2', 'Science2','2016/12/7 11:59:59',
'question 1 question 2');
call PostAssignments('sameer.shenawyy',1,'2016/11/24', 'Math11','2016/12/4 11:59:59',
'question 1 question 2 question 3');
call PostAssignments('sameer.shenawyy',2,'2016/12/6', 'Math11','2016/12/12 11:59:59',
'question 1 question 2 question 3');
call PostAssignments('ahmad.saloha', 1, '2016/11/25','Math1','2016/11/29 11:59:59',
'question 1');
call PostAssignments('ahmad.saloha',2,'2016/12/1','Math1', '2016/12/5 11:59:59',
'question 1');
call PostAssignments('ahmad.saloha',1,'2016/11/23','English1','2016/11/30 11:59:59',
'question 1');
call PostAssignments('ahmad.saloha',2,'2016/12/2','English1','2016/12/10 11:59:59',
'question 1');

call PostAssignments('sherif.hamdyy',3,'2016/12/02','Arabic3','2016/12/25 11:59:59','q1 q2 q3');

delete from Assignments where number = 3 and course_code = 'Arabic3';

call PostAssignments('laila.lola',2,'2016/12/2','English1','2016/12/10 11:59:59',
'question 1');

call DeleteAssignment('ahmad.saloha',2,'English1','2016/12/2');

call  ViewAssignments('mirna.elnaggar','Science2');
call  ViewAssignments('zayd.elnaggar','Arabic3');
call  ViewAssignments('salma.karim','Arabic3');

call SolveAssignment('zayd.elnaggar', 2,'2016/12/2' , 'Arabic3', 'answer for question 1');
call SolveAssignment('mirna.elnaggar',1,'2016/11/23', 'Science2','Lion, Rabbit, Mami');
call SolveAssignment('menna.ahmed',1,'2016/11/24', 'Math11','35x^2, 228, limit does not exist');
call SolveAssignment('salma.karim', 2, '2016/12/2','Arabic3','answers');

-- ViewSolutions(my_username varchar(50), student_username varchar(50), course_code varchar(20))
call ViewSolutions('sherif.hamdyy','Arabic3');
call ViewSolutions('sameer.shenawyy','Science2');
call ViewSolutions('sameer.shenawyy','Math11');

-- GradeAssignments(my_username varchar(50), student_username varchar(50),
-- grade real, course_code varchar(20), number int, date datetime)

call GradeAssignments('sherif.hamdyy', 19736287619873, 0,'Arabic3', 2,'2016/12/2');
call GradeAssignments('sherif.hamdyy',11967543908001, 5,'Arabic3',2,'2016/12/2');
call GradeAssignments('sameer.shenawyy',71965208910954,12,'Science2',1,'2016/11/23');
call GradeAssignments('sameer.shenawyy',97654733219076,20,'Math11',1,'2016/11/24');

call ViewGrades('zayd.elnaggar');
call ViewGrades('salma.karim');

-- WriteMonthlyReport(my_username varchar(50), student_username varchar(50), date datetime, comment varchar(150))
call WriteMonthlyReport('sherif.hamdyy', 'zayd.elnaggar', '2016/11/25','good');
call WriteMonthlyReport('sameer.shenawyy', 'mirna.elnaggar', '2016/11/25','excellent');
call WriteMonthlyReport('sameer.shenawyy','menna.ahmed','2016/11/25','bad');
call WriteMonthlyReport('ahmad.saloha','aragornlego','2016/11/25','eshta');

-- Students Procedures

call UpdateSsn('aragornlego',35467898765309);
call UpdateName('aragornlego','Aragorn Thorin Legolas');
call UpdateBirthDate('aragornlego','2010/3/6');
call UpdatePassword('aragornlego','bilbo');

call ViewCoursesToStudent('zayd.elnaggar');

call PostQuestions('zayd.elnaggar','Math3','Mr can you help? What is 10/4?','2016/11/23 16:51:04');
call PostQuestions('mirna.elnaggar','Science2','What is today''s homework?','2016/11/23 16:51:04');
call PostQuestions('mirna.elnaggar','Science2','The plant is a living or non living organism?','2016/11/23 16:54:07');

-- teacher
call ViewCoursesQuestions('sherif.hamdyy');

call ViewQuestionsToTeachers('sherif.hamdyy', 'Math3');
call ViewQuestionsToTeachers('sameer.shenawyy','Science2');

-- AnswerQuestions(my_username varchar(50), course_code varchar(20), answer1 varchar(200),
-- student_username varchar(50), time_stamp timestamp)

call AnswerQuestions('sameer.shenawyy', 'Science2', 'malkeesh da3wa',71965208910954, '2016-11-23 16:54:07');
call AnswerQuestions('sherif.hamdyy','Math3','use calculator',19736287619873,'2016-11-23 16:51:04');
call AnswerQuestions('sameer.shenawyy','Science2','you should concentrate in the class next time',71965208910954,'2016-11-23 16:51:04');

delete from Questions_answeredBy_Teachers where answer = 'helw';
call AnswerQuestions('sherif.hamdyy','Math3','helw',19736287619873,'2016-11-23 16:51:04');

call ViewQuestionsToStudent('Science2','mirna.elnaggar');

call ListStudents('sameer.shenawyy');
call ListStudents('sherif.hamdyy');

call SearchCourses('zayd.elnaggar','Arabic3');
call SearchCourses('zayd.elnaggar','Multiplication and Division');

call ApplyForActivities('zayd.elnaggar',1);
call ApplyForActivities('zayd.elnaggar',2);
call ApplyForActivities('zayd.elnaggar',3);

call NotInActivity('sherif.hamdyy');
call NotInActivity('sameer.shenawyy');
call NotInActivity('ahmad.saloha');

call ViewActivities('zayd.elnaggar');

insert into Clubs(name,school_email,purpose) values('MLS MUN','mls2@gmail.com','Delegates of Today, Leaders of Tomorrow');
insert into Clubs(name,school_email,purpose) values('MLS AYB','mls2@gmail.com','Feel the joy of giving back to the community');

call JoinClubs('menna.ahmed','MLS MUN');
call JoinClubs('zayd.elnaggar','MLS MUN');
call JoinClubs('aisha.elnaggar','MLS MUN');
call JoinClubs('aisha.elnaggar','MLS AYB');
call JoinClubs('sara.ahmed','MLS MUN');

call HighestClubParticipation('sherif.hamdyy');

call ViewAnnouncementToStudent('zayd.elnaggar','2016/11/23');

#PARENT
call  ViewReports('nada.sameh');

call replyToReport('nada.sameh','2016/11/25',19736287619873,75645342908713,'Take care of my baby, or else.');

call ViewChildrensSchools('legoleaf');
call ViewChildrensSchools('nada.sameh');

-- call View10PastAnnouncements('nada.sameh','2016/11/24'); Doen't work in mysql

call RateTeacher('nada.sameh','sherif.hamdyy',3);
call RateTeacher('nada.sameh','sameer.shenawyy',2);
call RateTeacher('abeer.khaled','sameer.shenawyy',5);
call RateTeacher('nada.sameh','ahmad.saloha',5);

call WriteReview('legoleaf','bashaermaadi@gmail.com','The School is academically good , however there is no fun!'); --
call WriteReview('abeer.khaled','mls2@gmail.com','The school was much better in the past years! I am very sad!'); --
call WriteReview('salma.seyam','lyceefrancaismaadi@hotmail.com','J''aime l''ecole'); --
call WriteReview('legoleaf','lyceefrancaismaadi@hotmail.com','This is to address the school of my kin. May the wind sail your ships with the tide'); --
call DeleteReview('nada.sameh','mls2@gmail.com');
call WriteReview('abeer.khaled','lyceefrancaismaadi@hotmail.com','I love how the school broadens the students'' minds'); --
call WriteReview('wafaadham','lyceefrancaismaadi@hotmail.com','I honestly love everything about the school, could''t have found a better one!'); --
call WriteReview('legoleaf','aisinternationalschool@gmail.com','The students think my kids are weird! :( '); -- 
call WriteReview('nada.sameh','mls2@gmail.com','Bgd el madrasa WOW!'); --

call ViewOverallRating('sameer.shenawyy');

call Top10SchoolsByReviews('legoleaf');
call Top10SchoolsByReviews('wafaadham');

call Top10SchoolsByStudents('legoleaf');

call InternationalsHigherThanAllNationals();

call ViewReviews('mls2@gmail.com');

call ViewAnnouncements('mls2@gmail.com');

