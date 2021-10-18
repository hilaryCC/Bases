-- SP para validar la contrase�a de un usuario
-- Entrada: 
--	+ Nombre del usuario
--	+ Contrase�a ingresada
-- Salida:
--	+ Entero: 1 (contrase�a correcta) o 0 (contrase�a incorrecta)
CREATE PROCEDURE ValidarPass
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
			-- Se obtiene la contrase�a del usuario digitado
			SELECT @Contrasena = Pass
			FROM Usuario
			WHERE [User] = @inNameUser;
		
			-- Se compara la contrase�a del usuario con el parametro
			IF @Contrasena = @inContrasena
			BEGIN
				-- La contrase�a es correcta
				SET @outCorrectPass = 1;
			END ELSE
			BEGIN
				-- La contrase�a es incorrecta
				SET @outCorrectPass = 0;
			END
		COMMIT TRANSACTION T1
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		--INSERT EN TABLA DE ERRORES;
		SET @outCodeResult=50005;
	END CATCH
	SET NOCOUNT OFF
END
