-- SP para validar que existe un beneficiario
USE Proyecto
GO

CREATE PROCEDURE ValidarBeneficiario
	@inIdBeneficiario INT
	, @inIdCuenta INT
	, @outCodeResult INT OUTPUT
	, @Encontrado INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @loOp INT     
			, @hiOP INT
			, @IdActual VARCHAR(40);
		
		SET @outCodeResult=0;
		
		-- Determinar el minimo y el maximo id para iterar por la tabla
		SELECT @loOP=MIN(Id), @hiOP=MAX(Id) FROM dbo.Beneficiario;
		BEGIN TRANSACTION T1
			-- Iterar todas las filas de la tabla Usuario para determinar si existe el usuario
			WHILE @loOP <= @hiOP
			BEGIN
				-- Se selecciona el Id actual 
				SELECT @IdActual = Id FROM Beneficiario 
				WHERE Id=@loOP 
				AND Activo=1 AND IdCuenta=@inIdCuenta
			
				IF @IdActual = @inIdBeneficiario
				BEGIN
					-- Si es igual entonces el beneficiario existe
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