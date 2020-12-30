/*
use master
drop database AlkemyUniversity
*/

CREATE DATABASE AlkemyUniversity
GO
USE AlkemyUniversity
GO
CREATE TABLE Subjects(
ID int not null identity(1,1),
Subject_Name varchar(100) not null unique,
Places_Available int null,
Maximum_Capacity int not null
)
GO 
ALTER TABLE Subjects
ADD CONSTRAINT PK_Subjects_ID PRIMARY KEY(ID)

-------------------------

GO
CREATE TABLE Schedules(
ID int not null identity(1,1),
Subject_ID int not null,
Day varchar(100) not null,
Start_Time time not null,
End_Time time not null
)
GO
ALTER TABLE Schedules
ADD CONSTRAINT PK_Schedules_IDSubject PRIMARY KEY(ID)
GO
ALTER TABLE Schedules
ADD CONSTRAINT FK_Schedules_IDSubject FOREIGN KEY(SUbject_ID) REFERENCES Subjects(ID)

-------------------------

GO
CREATE TABLE Users(
ID int not null identity(1,1),
Administrator bit not null
)
GO
ALTER TABLE Users
ADD CONSTRAINT PK_USERS PRIMARY KEY (ID)

-------------------------
CREATE TABLE Administrator(
User_ID int not null,
Password varchar(100) not null
)
GO
ALTER TABLE Administrator
ADD CONSTRAINT PK_Admin_IDUser PRIMARY KEY(User_ID)
GO
ALTER TABLE	Administrator
ADD CONSTRAINT FK_Admin_IDUser FOREIGN KEY(User_ID) REFERENCES Users(ID)
-------------------------

GO
CREATE TABLE Personal_Data(
User_ID int not null,
DNI int not null unique,
Lastname varchar(100) not null,
Names varchar(100) not null
)
GO
ALTER TABLE Personal_Data 
ADD CONSTRAINT PK_PerData_IDUser PRIMARY KEY(User_ID)
GO
ALTER TABLE Personal_Data
ADD CONSTRAINT FK_PerData_IDUser FOREIGN KEY (User_ID) REFERENCES Users(ID)

-------------------------

GO
CREATE TABLE Students(
User_ID int not null, 
Docket int not null identity(1,1) unique
)
GO
ALTER TABLE Students
ADD CONSTRAINT PK_Students_IDUser PRIMARY KEY(User_ID)
GO
ALTER TABLE Students
ADD CONSTRAINT FK_Students_IDUser FOREIGN KEY(User_ID) REFERENCES Users(ID)

-------------------------

GO
CREATE TABLE Inscriptions_by_Student(
Subject_ID int not null,
Student_Docket int not null,
Enrollment_Date datetime not null
)
GO
ALTER TABLE Inscriptions_by_Student
ADD CONSTRAINT PK_InsByStudent_IDSubjIDStud PRIMARY KEY(Subject_ID,Student_Docket)
GO
ALTER TABLE	Inscriptions_by_Student
ADD CONSTRAINT FK_InscByStudent_IDSubject FOREIGN KEY(Subject_ID) REFERENCES Subjects(ID)
GO
ALTER TABLE Inscriptions_by_Student
ADD CONSTRAINT FK_InscByStudent_StudentDocket FOREIGN KEY(Student_Docket) REFERENCES Students(Docket)

-------------------------

GO
CREATE TABLE Teachers(
ID int not null identity(1,1),
Lastname varchar(100) not null,
Names varchar(100) not null,
DNI int not null unique,
Active bit not null
)
GO
ALTER TABLE Teachers
ADD CONSTRAINT PK_Teachers_ID PRIMARY KEY(ID)

-------------------------

GO
CREATE TABLE Teachers_by_Subject(
Subject_ID int not null,
Teacher_ID int not null
)
GO
ALTER TABLE Teachers_by_Subject
ADD CONSTRAINT PK_TeacBySubj_IDSubjIDTeac PRIMARY KEY(Subject_ID,Teacher_ID)
GO
ALTER TABLE Teachers_by_Subject
ADD CONSTRAINT FK_TeacBySubj_IDSubject FOREIGN KEY(Subject_ID) REFERENCES Subjects(ID)
GO
ALTER TABLE Teachers_by_Subject
ADD CONSTRAINT FK_TeacBySubj_IDTeacher FOREIGN KEY(Teacher_ID) REFERENCES Teachers(ID)

-----------------------------------------------------------------------------------------
--INSERT DEL PRIMER ADMINISTRADOR PARA LA PAGINA--
GO
INSERT INTO Users(Administrator)
VALUES (1)
GO
INSERT INTO Administrator(User_ID,Password)
VALUES (1,'admin') 
GO
INSERT INTO Subjects(Subject_Name,Maximum_Capacity)
VALUES('Pro I',30)
GO
INSERT INTO Subjects(Subject_Name,Maximum_Capacity)
VALUES('Lab III',90)
GO
INSERT INTO Teachers(Lastname,Names,DNI,Active)
VALUES ('Lopez', 'Juan andres', 2020, 1)
GO
INSERT INTO Teachers_by_Subject(Subject_ID, Teacher_ID)
VALUES(1,1)
GO
INSERT INTO Schedules(Subject_ID,Day,Start_Time,End_Time)
VALUES(1, 'Martes', '21:00', '23:15')
GO
INSERT INTO Schedules(Subject_ID,Day,Start_Time,End_Time)
VALUES(1, 'Viernes', '11:00', '12:30')
GO
INSERT INTO Schedules(Subject_ID,Day,Start_Time,End_Time)
VALUES(2,'Domingo','08:00', '10:00')

