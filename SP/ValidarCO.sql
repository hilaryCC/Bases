CREATE PROCEDURE ValidarCO
	@inId INT
	, @outCodeResult INT OUTPUT
	, @outEncontrado INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @loOp INT     
			, @hiOP INT
			, @IdActual INT;
		
		SET @outCodeResult=0;
		
		-- Determinar el minimo y el maximo id para iterar por la tabla
		SELECT @loOP=MIN(Id), @hiOP=MAX(Id) FROM dbo.CuentaObjetivo;
		BEGIN TRANSACTION T1
			-- Iterar todas las filas de la tabla CuentaObjetivo para determinar si existe la cuenta
			WHILE @loOP <= @hiOP
			BEGIN
				-- Se selecciona el Usuario actual (se utiliza el contador y el id del usuario
				SELECT @IdActual = Id
				FROM CuentaObjetivo
				WHERE Id = @loOP
			
				IF @IdActual = @inId
				BEGIN
					-- Si es igual entonces la cuenta existe
					SET @outEncontrado = 1;
					BREAK;
				END ELSE
				BEGIN
					-- Si no es igual entonces no existe por el momento
					SET @outEncontrado = 0;
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