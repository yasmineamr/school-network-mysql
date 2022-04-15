use SchoolNetwork;

call InsertSchool('nefertari@gmail.com', 'Nefertari International School', 'International', 'English', 'Nefertari Street,Ismailia Road, Cairo, Egypt', 0244834484, 40000, 'general info','mission','vision');
call InsertSchool('nefertaribritish@gmail.com',null, 'International', 'English', 'Nefertari Street,Ismailia Road, Cairo, Egypt', 0244834486, 46000, 'general info','mission','vision');
call InsertSchool('dareltarbiah@gmail.com','Dar El Tarbiah IG','International', 'English', 'Midan Aswan,Agouza,Giza,Egypt',0233376454,20000,'general information','mission','vision');
call InsertSchool('portsaidschool@hotmail.com','Port Said School', 'National','English','7 Taha Hussein Street, Zamalek, Cairo, Egypt', 0224569708,15000, 'general information','mission','vision');
call InsertSchool('oasis@hotmail.com','Ecole Oasis Internationale', 'International','French','15 Road 118, Maadi, Cairo, Egypt', 0227564987,60000, 'general information','mission','vision');
call InsertSchool('aisinternationalschool@gmail.com','American International School','International', 'English','10 Road 90 The Fifth Settelment, Cairo, Egypt', 0227589009, 70000,'general information','mission','vision');
call InsertSchool('bashaermaadi@gmail.com','Bashaer National School', 'National', 'English','5 ElNasr Street, Maadi, Cairo, Egypt', 0227685994,10000, 'general information','mission','vision');
call InsertSchool('dsb@gmail.com','Deutsche Schule Der Borromarinnen','International','German','8 Mohamed Mahmoud Street, Downtown, Cairo, Egypt', 0235467812,50000,'general information','mission','vision');
call InsertSchool('lyceefrancaismaadi@hotmail.com', 'Lycee Francais du Caire','International','French', '7 Road 12, Maadi, Cairo, Egypt',0227683021,65000,'general information','mission','vision');
call InsertSchool('mls@gmail.com','Misr Language School', 'National','English','20 Wahat Road, 6th of October, Cairo, Egypt', 0238475609,12000,'general information','mission','vision');
call InsertSchool('mlsfrench@gmail.com','Misr Language School French Division', 'International','French','20 Wahat Road, 6th of October, Cairo, Egypt', 0238475608,32000,'general information','mission','vision');
call InsertSchool('oroubalanguageschool@hotmail.com','Orouba Language School','Nationa','English','23 Kornish ElNile Street, Agouza, Cairo, Egypt',0236589009,6000,'general information','mission','vision');
call InsertSchool('narmermaadi@gmail.com','Narmer Maadi Language School', 'National','English','10 Road 372 Maadi, Cairo, Egypt',0225463765,10000,'general information','mission','vision');

insert into Levels(Name) values ('Elementary');
insert into Levels(Name) values ('Middle');
insert into Levels(Name) values ('High');

-- InsertCourse(code varchar(20), name varchar(60), grade int, description varchar(200), level_name varchar(20))
call InsertCourse('Math1','Math One For Beginners',1,'description','Elementary');
call InsertCourse('English1','The Basics of The English Language',1,'description','Elementary');
call InsertCourse('Science2','Living and Non-living Organisms',2,'description','Elementary');
call InsertCourse('Arabic3','Introduction To Na7w',3,'description','Elementary');
call InsertCourse('Math3', 'Multiplication and Division', 3, 'description','Elementary');
call InsertCourse('English4','Fundamentals of Grammar',4,'description','Elementary');
call InsertCourse('SocialStudies5', 'Earth and Geography', 5,'description', 'Elementary');
call InsertCOurse('Biology1', 'The Human Body',7,'description','Middle');
call InsertCourse('Math7','Basic Algebra',7,'description','Middle');
call InsertCourse('Socialstudies8','The World and History', 8, 'description', 'Middle');
call InsertCourse('Chem9', 'Organic Chemisrty', 9, 'description','Middle');
call InsertCourse('Phys10', 'Mechanics and Motion', 10,'description', 'High');
call InsertCourse('Math11','Calculus II',11,'description','High');
call InsertCourse('Phys12', 'Light and Optics', 12 ,'description', 'High');

call InsertPrerequisites('Math7','Math1');
call InsertPrerequisites('English4','English1');
call InsertPrerequisites('Biology1','Science2');
call InsertPrerequisites('Math11','Math7');
call InsertPrerequisites('Math11','Math1');


insert into Elementary_Schools(email, supplies_list,name) values('nefertari@gmail.com','1 Copybook, 1 Pen','Elementary');
insert into Elementary_Schools(email, supplies_list,name) values('dareltarbiah@gmail.com','1 Copybook, 1 Pen','Elementary');
insert into Elementary_Schools(email, supplies_list,name) values('mls@gmail.com','1 Copybook, 1 Pen','Elementary');
insert into Elementary_Schools(email, supplies_list,name) values('portsaidschool@hotmail.com','1 Copybook, 1 Pen','Elementary');
insert into Elementary_Schools(email, supplies_list,name) values('aisinternationalschool@gmail.com','1 Copybook, 1 Pen','Elementary');
insert into Elementary_Schools(email, supplies_list,name) values('bashaermaadi@gmail.com','1 Copybook, 1 Pen','Elementary');
insert into Elementary_Schools(email, supplies_list,name) values('lyceefrancaismaadi@hotmail.com','1 Copybook, 1 Pen','Elementary');

insert into Middle_Schools(email,name) values('dareltarbiah@gmail.com','Middle');
insert into Middle_Schools(email,name) values('mlsfrench@gmail.com','Middle');
insert into Middle_Schools(email,name) values('portsaidschool@hotmail.com','Middle');
insert into Middle_Schools(email,name) values('aisinternationalschool@gmail.com','Middle');
insert into Middle_Schools(email,name) values('bashaermaadi@gmail.com','Middle');
insert into Middle_Schools(email,name) values('lyceefrancaismaadi@hotmail.com','Middle');

insert into High_Schools(email,name) values('dsb@gmail.com','High');
insert into High_Schools(email,name) values('nefertari@gmail.com','High');
insert into High_Schools(email,name) values('mls@gmail.com','High');
insert into High_Schools(email,name) values('portsaidschool@hotmail.com','High');
insert into High_Schools(email,name) values('aisinternationalschool@gmail.com','High');
insert into High_Schools(email,name) values('bashaermaadi@gmail.com','High');
insert into High_Schools(email,name) values('lyceefrancaismaadi@hotmail.com','High');



insert into Users(username) values('ahmed.farouk');
insert into Users(username) values('sara.hesham');
insert into Users(username) values('mohamed.khattab');
insert into Users(username) values('mahmoud.elsayad');
insert into Users(username) values('mina.sameh'); 
insert into Users(username) values('fawzy.sobhy');
insert into Employees(ssn,username,first_name,middle_name,last_name,birth_date,address,email,gender,school_email,salary) 
values(29567486778907,'ahmed.farouk','Ahmed','Mohamed','Farouk', '1985/12/5','7 Road 9 , Maadi, Cairo, Egypt','ahmedmohamed@gmail.com','male','bashaermaadi@gmail.com',3000);
insert into Employees(ssn,username,first_name,middle_name,last_name,birth_date,address,email,gender,school_email,salary) 
values(18670976467465,'sara.hesham','Sara','Mohamed','Hesham','1980/4/5','13 Syria Street, Mohandseen, Cairo, Egypt', 'sarahesham@hotmail.com','female','lyceefrancaismaadi@hotmail.com',5000);
insert into Employees(ssn,username,first_name,middle_name,last_name,birth_date,address,email,gender,school_email,salary) 
values(17564980878900,'mohamed.khattab','Mohamed','Ahmed','Khattab','1975/9/7','22 Mohamed Ammar Street, Nasr City, Cairo, Egypt','mohamedkhattab@gmail.com','male','mls@gmail.com',3000);
insert into Employees(ssn,username,first_name,middle_name,last_name,birth_date,address,email,gender,school_email,salary) 
values(19873600977532, 'mahmoud.elsayad','Mahmoud','Tamer','ElSayad','1972/8/31', '20 Marghany Street, Masr ElGdida, Cairo, Egypt', 'mahmoudelsayad72@gmail.com','male', 'portsaidschool@hotmail.com',3000);
insert into Employees(ssn,username,first_name,middle_name,last_name,birth_date,address,email,gender,school_email,salary) 
values(61198547226090, 'mina.sameh', 'Mina', 'Gamal', 'Sameh', '1983/11/10','9 Abou El Feda St., Zamalek, Cairo, Egypt','minasameh11@hotmail.com','male','dsb@gmail.com',5000);
insert into Employees(ssn,username,first_name,middle_name,last_name,birth_date,address,email,gender,school_email,salary) 
values(38901278566453, 'fawzy.sobhy', 'Fawzy', 'Foda', 'Sobhy', '1987/12/3','59 Lebanon St., Moahndeseen, Giza, Egypt', 'fawzy.foda@gmail.com', 'male', 'aisinternationalschool@gmail.com',5000);
insert into Administrators(ssn) values(29567486778907);
insert into Administrators(ssn) values(18670976467465);
insert into Administrators(ssn) values(17564980878900);
insert into Administrators(ssn) values(19873600977532);
insert into Administrators(ssn) values(61198547226090);
insert into Administrators(ssn) values(38901278566453);