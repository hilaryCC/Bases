USE Proyecto
GO
CREATE PROCEDURE ValidarEC
	@inId INT
	, @inIdCuenta INT
	, @outCodeResult INT OUTPUT
	, @outEncontrado INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @loOp INT     
			, @hiOP INT
			, @IdCuenta INT;
		
		SET @outCodeResult=0;
		
		-- Determinar el minimo y el maximo id para iterar por la tabla
		SELECT @loOP=MIN(Id), @hiOP=MAX(Id) FROM dbo.EstadoCuenta;
		BEGIN TRANSACTION T1
			-- Iterar todas las filas de la tabla EstadoCuenta para determinar si existe el usuario
			WHILE @loOP <= @hiOP
			BEGIN
				SELECT @IdCuenta = IdCuenta
				FROM EstadoCuenta
				WHERE Id = @loOP
				IF @inId = @loOP AND @inIdCuenta = @IdCuenta
				BEGIN
					-- Si es igual entonces el estado existe
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