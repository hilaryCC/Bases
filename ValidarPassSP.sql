-- SP para validar la contrase�a de un usuario
CREATE PROCEDURE ValidarPass
	@inNameUser VARCHAR(40)
	, @inContrasena VARCHAR(40)
	, @outCodeResult INT OUTPUT
	, @outCorrectPass INT OUTPUT
AS 
BEGIN
	SET NOCOUNT OFF
	BEGIN TRY
		DECLARE
			@Contrasena VARCHAR(40)
			, @Usuario VARCHAR(40)
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
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		--INSERT EN TABLA DE ERRORES;
		SET @outCodeResult=50005;
	END CATCH
	SET NOCOUNT ON
END
