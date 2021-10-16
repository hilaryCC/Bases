-- SP para validar la contraseña de un usuario
-- Entrada: 
--	+ Nombre del usuario
--	+ Contraseña ingresada
-- Salida:
--	+ Entero: 1 (contraseña correcta) o 0 (contraseña incorrecta)
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
			-- Se obtiene la contraseña del usuario digitado
			SELECT @Contrasena = Pass
			FROM Usuario
			WHERE [User] = @inNameUser;
		
			-- Se compara la contraseña del usuario con el parametro
			IF @Contrasena = @inContrasena
			BEGIN
				-- La contraseña es correcta
				SET @outCorrectPass = 1;
			END ELSE
			BEGIN
				-- La contraseña es incorrecta
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
