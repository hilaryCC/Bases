CREATE PROCEDURE InsCuentaObjetivo
	@inIdCuenta INT
	, @inFechaInicio VARCHAR(40)
	, @inFechaFinal VARCHAR(40)
	, @inCuota INT
	, @inObjetivo VARCHAR(40)
	, @inSaldo INT
	, @inInteresAcumulado INT
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN TRANSACTION T1
			INSERT INTO CuentaObjetivo(IdCuenta, FechaInicio, FechaFinal, Cuota, Objetivo, Saldo, InteresAcumulado, Activo)
			VALUES (@inIdCuenta, @inFechaInicio, @inFechaFinal, @inCuota, @inObjetivo, @inSaldo, @inInteresAcumulado, 1);
		COMMIT TRANSACTION t1
		SET @outCodeResult = 0;
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