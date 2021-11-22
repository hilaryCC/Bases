-- SP para validar si existe una cuenta de ahorro
-- Entrada: 
--	+ Numero de cuenta
-- Salida:
--	+ Entero: 1 (existe) o 0 (no existe)
USE Proyecto
GO

CREATE PROCEDURE dbo.ValidarCuentaAhorro
	@inNumCuenta INT	
	, @outExiste INT OUTPUT
	, @outIdCuenta INT OUTPUT
	, @outCodeResult INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @loOp INT     
			, @hiOP INT
			, @NumCuenta INT
		SELECT @loOP=MIN(Id), @hiOP=MAX(Id) FROM dbo.CuentaAhorro;
		BEGIN TRANSACTION T1
			WHILE @loOp <= @hiOP
			BEGIN
				SELECT @NumCuenta = NumeroCuenta
				FROM CuentaAhorro
				WHERE Id = @loOp
				IF @NumCuenta = @inNumCuenta
				BEGIN
					-- Si es igual entonces el usuario existe
					SET @outExiste = 1;
					SELECT @outIdCuenta = Id
					FROM CuentaAhorro
					WHERE Id = @loOp 
					BREAK;
				END ELSE
				BEGIN
					-- Si no es igual entonces no existe por el momento
					SET @outExiste = 0;
					SET @outIdCuenta = 0;
				END
				SET @loOp = @loOp + 1
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