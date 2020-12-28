USE AlkemyUniversity
GO
CREATE PROCEDURE SP_Login_Admin(
@id int,
@password varchar(100)
)
AS
BEGIN
	select U.ID, U.Administrator from Administrator as A
	join Users as U on U.ID=A.User_ID
	where A.User_ID=@id and A.Password=@password and U.Administrator=1;
END

GO

CREATE PROCEDURE SP_New_Teacher(
@dni int,
@lastName varchar(200),
@names varchar(200),
@active bit
)
AS
BEGIN 
	BEGIN TRY
		INSERT INTO Teachers(DNI,Lastname, Names,Active)
		VALUES (@dni,@lastName,@names,@active)
	END TRY
	BEGIN CATCH
		RAISERROR('No se pudo agregar al profesor en la base de datos.',16,1);
	END CATCH
END	

GO

CREATE VIEW VW_Teachers_Activos
AS
select T.ID, T.Lastname, t.Names, T.DNI, T.Active,
T.Lastname +' '+ T.Names as 'FullName'
from Teachers as T where Active=1

GO

CREATE PROCEDURE SP_New_Subject(
@subject_name varchar(100),
@maximum_capacity int,
@day varchar(100),
@star_time varchar(6),
@end_time varchar(6),
@teacher_id int
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO Subjects(Subject_Name, Maximum_Capacity)
			VALUES(@subject_name, @maximum_capacity)
			DECLARE @ultID int
			SET @ultID = @@IDENTITY

			INSERT INTO Schedules(ID_Subject,Day,Start_Time,End_Time)
			VALUES(@ultID, @day, @star_time, @end_time)

			INSERT INTO Teachers_by_Subject(Subject_ID,Teacher_ID)
			VALUES(@ultID, @teacher_id)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('No se pudo agregar la materia.',16,1);
	END CATCH

END


select*from Subjects
select*from Schedules
select*From Teachers_by_Subject
select*from Teachers

Select S.Subject_Name, T.Lastname+T.Names as Profesor, Sc.Day, Sc.Start_Time, Sc.End_Time
from Subjects as S
join Teachers_by_Subject as tbs on tbs.Subject_ID = S.ID
join Teachers as T on T.ID = tbs.Teacher_ID
join Schedules as Sc on Sc.ID_Subject = S.ID
