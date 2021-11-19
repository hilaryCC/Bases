-- SP para procesar el dia de ahorro de las CO

USE Proyecto
GO

CREATE PROCEDURE dbo.CierreCO
				@InIdCO INT
				,@InFechaActual DATE
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @InteresAcumulado MONEY
				,@NumCA INT
				,@SaldoCA MONEY
				,@IdMonedaCA INT 
				,@SaldoCO MONEY
				
		SELECT @InteresAcumulado = CO.InteresAcumulado
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

		EXEC dbo.MovimientoCO @InIdCO
							,@InFechaActual
							,'Credito redencion Intereses'
							,2
							,@InteresAcumulado

		SELECT @SaldoCO = CO.Saldo
		FROM dbo.CuentaObjetivo CO
		WHERE CO.Id = @InIdCO

		EXEC dbo.MovimientoCO @InIdCO
							,@InFechaActual
							,'Debito Redencion Cuenta Objetivo'
							,3
							,@SaldoCO

		EXEC dbo.InsertarMov @InFechaActual
							,'Credito Redencion Cuenta Objetivo'
							,@IdMonedaCA
							,@SaldoCO
							,@NumCA
							,15

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION T1;
			UPDATE dbo.CuentaObjetivo SET Activo = 0
			WHERE Id = @InIdCO
		COMMIT TRANSACTION T1;

	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
	END CATCH
	SET NOCOUNT OFF
END