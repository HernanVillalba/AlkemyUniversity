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

CREATE VIEW VW_Ative_Teachers
AS
select T.ID, T.Lastname, t.Names, T.DNI, T.Active,
T.Lastname +' '+ T.Names as 'FullName'
from Teachers as T where Active=1

GO

exec SP_New_Subject 'PRO ppp', 350,'miercoles','20:00', '22:15', 2

CREATE PROCEDURE SP_New_Subject(
@subject_name varchar(100),
@maximum_capacity int,
@day varchar(100),
@start_time varchar(6),
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
			VALUES(@ultID, @day, @start_time, @end_time)

			INSERT INTO Teachers_by_Subject(Subject_ID,Teacher_ID)
			VALUES(@ultID, @teacher_id)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('No se pudo agregar la materia.',16,1);
	END CATCH

END

GO

/*
--	LO VOY A USAR PARA SABER LA CANTIDAD DE CUPOS RESTANTES
CREATE PROCEDURE SP_Places_Available(
@subject_id int
)
as
begin 
	select COUNT(@subject_id) from Inscriptions_by_Student
end
*/

GO

CREATE VIEW VW_Subject_Info
AS
SELECT S.ID AS Subject_ID,
	   S.Subject_Name,
	   ISNULL(S.Places_Available,S.Maximum_Capacity) AS Places_Availables,
	   S.Maximum_Capacity,
	   T.ID AS Teacher_ID,
	   T.Lastname, 
	   T.Names, 
	   SCH.Day, 
	   SCH.Start_Time,
	   SCH.End_Time
FROM Subjects AS S
join Teachers_by_Subject AS tbs ON TBS.Subject_ID = S.ID
join Teachers AS T ON T.ID = TBS.Teacher_ID
join Schedules AS SCH ON SCH.ID_Subject = S.ID

GO

CREATE PROCEDURE SP_Subject_Search(
@keyword varchar(100)
)
AS
BEGIN
	SELECT S.ID AS Subject_ID,
		   S.Subject_Name,
		   ISNULL(S.Places_Available,S.Maximum_Capacity) AS Places_Availables,
		   S.Maximum_Capacity,
		   T.ID AS Teacher_ID,
		   T.Lastname, 
		   T.Names, 
		   SCH.Day, 
		   SCH.Start_Time,
		   SCH.End_Time
	FROM Subjects AS S
	join Teachers_by_Subject AS tbs ON TBS.Subject_ID = S.ID
	join Teachers AS T ON T.ID = TBS.Teacher_ID
	join Schedules AS SCH ON SCH.ID_Subject = S.ID
	WHERE S.Subject_Name like '%'+ @keyword + '%' OR
		  T.Lastname like '%'+ @keyword + '%' or
		  T.Names like '%'+ @keyword + '%' OR
		  SCH.Day like '%'+ @keyword + '%'
END

GO

CREATE VIEW VW_List_Teachers
Select T.ID,T.Lastname,T.Names,T.DNI,T.Active,
(
select count(TBS.Teacher_ID) from Teachers_by_Subject as TBS
where TBS.Teacher_ID = T.ID
) as 'Cantidad de materias'
from Teachers AS T


select*from 





