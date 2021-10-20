CREATE PROCEDURE InsCuentaObjetivo
	@inIdCuenta INT
	, @inFechaInicio VARCHAR(40)
	, @inFechaFinal VARCHAR(40)
	, @inCuota INT
	, @inObjetivo VARCHAR(40)
	, @inSaldo INT
	, @inInteresAnual INT
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN TRANSACTION T1
			INSERT INTO CuentaObjetivo(IdCuenta, FechaInicio, FechaFinal, Cuota, Objetivo, Saldo, InteresAnual, Activo)
			VALUES (@inIdCuenta, @inFechaInicio, @inFechaFinal, @inCuota, @inObjetivo, @inSaldo, @inInteresAnual, 1);
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