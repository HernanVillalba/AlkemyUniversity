
CREATE PROCEDURE SP_LoginAdmin(
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
CREATE PROCEDURE SP_NewTeacher(
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
