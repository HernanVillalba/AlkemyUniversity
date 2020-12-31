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

CREATE PROCEDURE SP_New_Subject(
@subject_name varchar(100),
@maximum_capacity int,
@day varchar(100),
@start_time time,
@end_time time,
@teacher_id int
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO Subjects(Subject_Name, Maximum_Capacity, Places_Available)
			VALUES(@subject_name, @maximum_capacity, @maximum_capacity)
			DECLARE @ultID int
			SET @ultID = @@IDENTITY

			INSERT INTO Schedules(Subject_ID,Day,Start_Time,End_Time)
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
SELECT ISNULL(S.ID, 0) AS Subject_ID,
	   ISNULL(S.Subject_Name, '---') AS Subject_Name,
	   ISNULL(S.Places_Available,ISNULL(S.Maximum_Capacity,0)) AS Places_Availables,
	   ISNULL(S.Maximum_Capacity,0) AS Maximum_Capacity,
	   ISNULL(T.ID, 0) AS Teacher_ID,
	   ISNULL(T.Lastname, '---') AS Lastname, 
	   ISNULL(T.Names, '---') AS Names, 
	   ISNULL(SCH.Day, '---') AS Day,
	   ISNULL(SCH.Start_Time,'00:00') AS Start_Time,
	   ISNULL(SCH.End_Time,'00:00') AS End_Time
FROM Subjects AS S
full join Teachers_by_Subject AS tbs ON TBS.Subject_ID = S.ID
left join Teachers AS T ON T.ID = TBS.Teacher_ID
left join Schedules AS SCH ON SCH.Subject_ID = S.ID

GO

SELECT*FROM VW_Subject_Info 
ORDER BY Subject_Name ASC, Day ASC, Start_Time ASC, End_Time ASC 

GO

CREATE PROCEDURE SP_Subject_Search(
@keyword varchar(100)
)
AS
BEGIN
	SELECT * FROM VW_Subject_Info AS VW
	WHERE VW.Subject_Name like '%'+ @keyword + '%' OR
		  VW.Lastname like '%'+ @keyword + '%' or
		  VW.Names like '%'+ @keyword + '%' OR
		  VW.Day like '%'+ @keyword + '%'
END

GO

CREATE VIEW VW_List_Teachers
AS
SELECT T.ID,T.Lastname,T.Names,T.DNI,T.Active,
(
SELECT count(TBS.Teacher_ID) FROM Teachers_by_Subject AS TBS
WHERE TBS.Teacher_ID = T.ID
) AS 'Cantidad de materias'
FROM Teachers AS T

GO

CREATE PROCEDURE SP_Teachers_Search(
@keyword varchar(100)
)
AS
BEGIN
	SELECT*FROM VW_List_Teachers AS VW
	WHERE VW.Lastname LIKE '%'+@keyword+'%' OR
	VW.Names LIKE '%'+@keyword+'%' OR
	VW.DNI LIKE '%'+@keyword+'%'
END

GO

CREATE PROCEDURE SP_Search_Teacher_by_ID(
@id int
)
AS
BEGIN
	SELECT*FROM VW_List_Teachers AS VW
	WHERE VW.ID = @id
END

GO

CREATE PROCEDURE SP_Update_Teacher(
@teacher_id int,
@lastname varchar(100),
@names varchar(100),
@dni int,
@active bit
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE Teachers
			SET Lastname = @lastname,
			Names = @names,
			DNI = @dni,
			Active = @active
			WHERE ID = @teacher_id
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('No se pudo actualizar los datos del profesor.',16,1);
	END CATCH
END

GO

CREATE PROCEDURE SP_Search_Subject_by_ID( @subject_id int )
AS
BEGIN
	SELECT*FROM VW_Subject_Info AS VW
	WHERE VW.Subject_ID = @subject_id
END

GO

CREATE PROCEDURE SP_List_Schedules_by_ID(
	@subject_id int
)
AS
BEGIN
	SELECT*FROM Schedules WHERE Subject_ID = @subject_id
	ORDER BY Day ASC, Start_Time ASC, End_Time ASC 
END

Exec SP_List_Schedules_by_ID 2

GO

CREATE PROCEDURE SP_Save_Schedule(
	@subject_id int,
	@day varchar(100),
	@start_time time,
	@end_time time
)
AS
BEGIN
	INSERT INTO Schedules(Subject_ID,Day,Start_Time,End_Time)
	VALUES (@subject_id,@day,@start_time,@end_time)
END

GO

CREATE PROCEDURE SP_Update_Subject(
	@subject_id int,
	@subject_name varchar(100),
	@maximum_capacity int,
	@old_teacher_id	int,
	@new_teacher_id int
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			UPDATE Subjects
			SET Subject_Name = @subject_name,
			Maximum_Capacity = @maximum_capacity
			WHERE ID = @subject_id
			IF(@old_teacher_id = 0)
				BEGIN
					INSERT INTO Teachers_by_Subject(Subject_ID,Teacher_ID)
					VALUES (@subject_id, @new_teacher_id)
				END
			ELSE
				BEGIN
					UPDATE Teachers_by_Subject
					SET Teacher_ID = @new_teacher_id
					WHERE Subject_ID = @subject_id AND
					Teacher_ID = @old_teacher_id
				END
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('No se pudo actualizar los datos de la materia.',16,1);
	END CATCH
END

GO

CREATE PROCEDURE SP_Delete_Schedule(
	@schedule_id int
)
AS
BEGIN
   DELETE FROM Schedules
   WHERE ID = @schedule_id
END

GO

CREATE PROCEDURE SP_Delete_Teacher_From_Subject(
	 @subject_id int,
	 @teacher_id int
)
AS
BEGIN
   DELETE FROM Teachers_by_Subject
   WHERE Subject_ID = @subject_id AND
   Teacher_ID = @teacher_id
END

GO

CREATE VIEW	VW_List_Student
AS
select U.ID, S.Docket, PD.Lastname, PD.Names, PD.DNI, U.Administrator
from Users as U
join Personal_Data as PD on PD.User_ID = U.ID
join Students as S on S.User_ID = U.ID

GO

CREATE VIEW VW_List_Administrators
AS
select U.ID, PD.Lastname, PD.Names,PD.DNI, U.Administrator
from Users as U
join Personal_Data as PD on PD.User_ID = U.ID
join Administrator as A on A.User_ID = U.ID

GO

CREATE PROCEDURE SP_List_Ordered_Admin
AS
SELECT*FROM VW_List_Administrators AS VW
ORDER BY VW.ID, VW.Lastname, VW.Names

GO

CREATE PROCEDURE SP_List_Ordered_Student
AS
SELECT*FROM VW_List_Student AS VW
ORDER BY VW.Docket ASC, VW.Lastname ASC, VW.Names ASC


GO

CREATE PROCEDURE SP_Register_Student(
	@dni int,
	@lastname varchar(100),
	@names varchar(100)
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
				INSERT INTO Users(Administrator)
				VALUES ('0')
				DECLARE @ult_user_id int
				SET @ult_user_id = @@IDENTITY
				INSERT INTO Students (User_ID)
				VALUES (@ult_user_id)
				INSERT INTO Personal_Data(User_ID,DNI,Lastname,Names)
				VALUES(@ult_user_id, @dni,@lastname,@names)
		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('No se pudo registrar al estudiante.',16,1);
	END CATCH
END

GO

CREATE PROCEDURE SP_Register_Admin(
	@password varchar(100),
	@lastname varchar(100),
	@names varchar(100),
	@dni int
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO Users(Administrator)
			VALUES (1)
			DECLARE @ult_user_id int
			SET @ult_user_id = @@IDENTITY
			INSERT INTO Administrator(User_ID, Password)
			VALUES (@ult_user_id, @password)
			INSERT INTO Personal_Data(User_ID, DNI, Lastname,Names)
			VALUES(@ult_user_id, @dni,@lastname,@names)
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('No se pudo registrar al usuario administrador.',16,1);
	END CATCH
END

-----------------------------------------------------------------------------------------------
--                                      ALUMNO                                              ---

GO

CREATE PROCEDURE SP_Login_Student(
	@docket int,
	@dni int
)
AS
BEGIN
	Select U.ID, S.Docket, PD.Lastname, PD.Names, PD.DNI, U.Administrator
	from Users as U
	join Personal_Data as PD on PD.User_ID = U.ID
	join Students as S on S.User_ID = U.ID
	Where S.Docket = @docket AND
	PD.DNI = @dni
END

GO

CREATE VIEW VW_List_Subjects_Student
AS
SELECT S.ID, S.Subject_Name
FROM Subjects AS S

GO

CREATE PROCEDURE SP_Enroll_in_a_Subject(
	@subject_id int,
	@student_docket int
)
AS
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION
			INSERT INTO Inscriptions_by_Student(Subject_ID, Student_Docket,Enrollment_Date)
			VALUES(@subject_id, @student_docket, GETDATE())
			UPDATE Subjects
			SET Places_Available = Places_Available-1
			WHERE ID = @subject_id
		COMMIT TRANSACTION
	END TRY
	BEGIN CATCH
		ROLLBACK TRANSACTION
		RAISERROR('No se pudo inscribir al usuario en la materia seleccionada.',16,1);
	END CATCH
END

GO

CREATE PROCEDURE SP_List_my_Enrollments(
	@student_docket int
)
AS
BEGIN
	select S.Subject_Name, IbS.Enrollment_Date
	from Inscriptions_by_Student as IbS
	join Subjects as S on S.ID = IbS.Subject_ID
	where IbS.Student_Docket = @student_docket
END

