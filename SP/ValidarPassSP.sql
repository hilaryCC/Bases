-- SP para validar la contraseņa de un usuario
-- Entrada: 
--	+ Nombre del usuario
--	+ Contraseņa ingresada
-- Salida:
--	+ Entero: 1 (contraseņa correcta) o 0 (contraseņa incorrecta)
USE Proyecto
GO

CREATE PROCEDURE dbo.ValidarPass
	@inNameUser VARCHAR(40)
	, @inContrasena VARCHAR(40)
	, @outCodeResult INT OUTPUT
	, @outCorrectPass INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE
			@Contrasena VARCHAR(40)
			, @Usuario VARCHAR(40)
		BEGIN TRANSACTION T1
			-- Se obtiene la contraseņa del usuario digitado
			SELECT @Contrasena = Pass
			FROM Usuario
			WHERE [User] = @inNameUser;
		
			-- Se compara la contraseņa del usuario con el parametro
			IF @Contrasena = @inContrasena
			BEGIN
				-- La contraseņa es correcta
				SET @outCorrectPass = 1;
			END ELSE
			BEGIN
				-- La contraseņa es incorrecta
				SET @outCorrectPass = 0;
			END
		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		--INSERT EN TABLA DE ERRORES;
		SET @outCodeResult=50005;
		SELECT
			ERROR_NUMBER() AS ErrorNumber,
			ERROR_STATE() AS ErrorState,
			ERROR_SEVERITY() AS ErrorSeverity,
			ERROR_PROCEDURE() AS ErrorProcedure,
			ERROR_LINE() AS ErrorLine,
			ERROR_MESSAGE() AS ErrorMessage;
	END CATCH
	SET NOCOUNT OFF
END
