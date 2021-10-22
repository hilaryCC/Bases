-- SP para validar si existe un usuario
-- Entrada: 
--	+ Nombre del usuario
-- Salida:
--	+ Entero: 1 (existe) o 0 (no existe)
USE Proyecto
GO
CREATE PROCEDURE ValidarUser
	@NameUser VARCHAR(40)
	, @outCodeResult INT OUTPUT
	, @Encontrado INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @loOp INT     
			, @hiOP INT
			, @Usuario VARCHAR(40);
		
		SET @outCodeResult=0;
		
		-- Determinar el minimo y el maximo id para iterar por la tabla
		SELECT @loOP=MIN(Id), @hiOP=MAX(Id) FROM dbo.Usuario;
		BEGIN TRANSACTION T1
			-- Iterar todas las filas de la tabla Usuario para determinar si existe el usuario
			WHILE @loOP <= @hiOP
			BEGIN
				-- Se selecciona el Usuario actual (se utiliza el contador y el id del usuario
				SELECT @Usuario = [User] 
				FROM Usuario
				WHERE Id = @loOP
			
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
				SET @loOP = @loOP + 1
			END;
		COMMIT TRANSACTION t1
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		--INSERT EN TABLA DE ERRORES;
		SET @outCodeResult=50005;
	END CATCH
	SET NOCOUNT OFF
END