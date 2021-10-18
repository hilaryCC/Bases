CREATE PROCEDURE ValidarIdentificacion
	@inIdentificacion INT
	, @outCodeResult INT OUTPUT
	, @Encontrado INT OUTPUT
	, @outIdPersona INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @loOp INT     
			, @hiOP INT
			, @IdenActual INT;
		
		SET @outCodeResult=0;
		
		-- Determinar el minimo y el maximo id para iterar por la tabla
		SELECT @loOP=MIN(Id), @hiOP=MAX(Id) FROM dbo.Persona;
		BEGIN TRANSACTION T1
			WHILE @loOP <= @hiOP
			BEGIN
				SELECT @IdenActual = ValorDocumentoIdentidad
				FROM Persona
				WHERE Id = @loOP
				IF @IdenActual = @inIdentificacion
				BEGIN
					-- Si es igual entonces la cedula existe existe
					SET @Encontrado = 1;
					SET @outIdPersona = @loOP;
					print @Encontrado
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