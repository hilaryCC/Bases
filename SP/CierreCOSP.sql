-- SP para procesar el dia de ahorro de las CO

USE Proyecto
GO

CREATE PROCEDURE dbo.CierreCO
				@InIdCO INT
				,@InFechaActual DATE
				,@outCodeResult INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @InteresAcumulado MONEY
				,@NumCA INT
				,@SaldoCA MONEY
				,@IdMonedaCA INT 
				,@TotalSaldoCO MONEY
				,@Salida INT 
				
		SELECT @InteresAcumulado = CO.InteresAcumulado
			   ,@TotalSaldoCO = CO.Saldo + CO.InteresAcumulado
			   ,@IdMonedaCA = TCA.IdTipoMoneda
			   ,@NumCA = CA.NumeroCuenta
			   ,@SaldoCA = CA.Saldo
		FROM dbo.CuentaObjetivo CO
		INNER JOIN dbo.CuentaAhorro CA
			ON CA.Id = CO.IdCuenta
		INNER JOIN dbo.TipoCuentaAhorro TCA
			ON CA.TipoCuentaId = TCA.Id
		WHERE CO.Id = @InIdCO
		
		EXEC dbo.MovimientoInteresCO @InIdCO
									,@InFechaActual
									,2
									,'Debito Interes Acumulados'
									,@Salida

		EXEC dbo.MovimientoCO @InIdCO
							,@InFechaActual
							,'Credito redencion Intereses'
							,2
							,@InteresAcumulado
							,@Salida

		EXEC dbo.MovimientoCO @InIdCO
							,@InFechaActual
							,'Debito Redencion Cuenta Objetivo'
							,3
							,@TotalSaldoCO
							,@Salida

		EXEC dbo.InsertarMov @InFechaActual
							,'Credito Redencion Cuenta Objetivo'
							,@IdMonedaCA
							,@TotalSaldoCO
							,@NumCA
							,15
							,@Salida

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION T1;
			UPDATE dbo.CuentaObjetivo SET Activo = 0
			WHERE Id = @InIdCO
		COMMIT TRANSACTION T1;
		SET @outCodeResult = 0;
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		SET @outCodeResult = 50005;
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