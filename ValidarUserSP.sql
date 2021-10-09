-- SP para validar si existe un usuario
CREATE PROCEDURE ValidarUser
	@NameUser VARCHAR(40)
	, @outCodeResult INT OUTPUT
	, @Encontrado INT OUTPUT
AS 
BEGIN
	SET NOCOUNT OFF
	BEGIN TRY
		DECLARE
			@Contador INT = 1
			, @CantFilasT INT
			, @Usuario VARCHAR(40)
		-- Determinar cantidad de filas para iterar por la tabla
		SELECT @CantFilasT = COUNT(0) FROM dbo.Usuario;
		-- Iterar todas las filas de la tabla Usuario para determinar si existe el usuario
		WHILE @Contador <= @CantFilasT
		BEGIN
			-- Se selecciona el Usuario actual (se utiliza el contador y el id del usuario
			SELECT @Usuario = [User] 
			FROM Usuario
			WHERE @Contador = Id
			-- Se determina si el parametro con el nombre de usuario es igual al usuario actual
			IF @Usuario = @NameUser
			BEGIN
				-- Si es igual entonces el usuario existe
				SET @Encontrado = 1;
				BREAK;
			END ELSE
			BEGIN
				-- Si no es igual entonces no existe por el momento
				SET @Encontrado = 0;
			END
			-- Aumentar contador
			SET @Contador = @Contador + 1
		END;
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		--INSERT EN TABLA DE ERRORES;
		SET @outCodeResult=50005;
	END CATCH
	SET NOCOUNT ON
END