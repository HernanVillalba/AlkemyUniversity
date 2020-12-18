CREATE DATABASE AlkemyUniversity
GO
USE AlkemyUniversity
GO
CREATE TABLE Subjects(
ID int not null identity(1,1),
Subject_Name varchar(100) not null,
Places_Available int not null,
Maximum_Capacity int not null
)
GO 
ALTER TABLE Subjects
ADD CONSTRAINT PK_Subjects_ID PRIMARY KEY(ID)

-------------------------

GO
CREATE TABLE Schedules(
ID_Subject int not null,
Day varchar(100) not null,
Start_Time time not null,
End_Time time not null
)
GO
ALTER TABLE Schedules
ADD CONSTRAINT PK_Schedules_IDSubject PRIMARY KEY(ID_Subject)
GO
ALTER TABLE Schedules
ADD CONSTRAINT FK_Schedules_IDSubject FOREIGN KEY(ID_SUbject) REFERENCES Subjects(ID)

-------------------------

GO
CREATE TABLE Users(
ID int not null identity(1,1),
Administrator bit not null,
Pass varchar(100) not null
)
GO
ALTER TABLE Users
ADD CONSTRAINT PK_USERS PRIMARY KEY (ID)

-------------------------

GO
CREATE TABLE Personal_Data(
ID_User int not null,
DNI int not null unique,
Lastname varchar(100) not null,
Names varchar(100) not null
)
GO
ALTER TABLE Personal_Data 
ADD CONSTRAINT PK_PerData_IDUser PRIMARY KEY(ID_User)
GO
ALTER TABLE Personal_Data
ADD CONSTRAINT FK_PerData_IDUser FOREIGN KEY (ID_User) REFERENCES Users(ID)

-------------------------

GO
CREATE TABLE Students(
ID_User int not null, 
Docket int not null identity(1,1) unique
)
GO
ALTER TABLE Students
ADD CONSTRAINT PK_Students_IDUser PRIMARY KEY(ID_User)
GO
ALTER TABLE Students
ADD CONSTRAINT FK_Students_IDUser FOREIGN KEY(ID_User) REFERENCES Users(ID)

-------------------------

GO
CREATE TABLE Inscriptions_by_Student(
ID_Subject int not null,
Student_Docket int not null,
Enrollment_Date datetime not null
)
GO
ALTER TABLE Inscriptions_by_Student
ADD CONSTRAINT PK_InsByStudent_IDSubjIDStud PRIMARY KEY(ID_Subject,Student_Docket)
GO
ALTER TABLE	Inscriptions_by_Student
ADD CONSTRAINT FK_InscByStudent_IDSubject FOREIGN KEY(ID_Subject) REFERENCES Subjects(ID)
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

/*

use master
drop database AlkemyUniversity

*/