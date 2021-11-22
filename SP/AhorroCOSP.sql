-- SP para procesar el dia de ahorro de las CO

USE Proyecto
GO

CREATE PROCEDURE dbo.AhorroCO
				@InIdCO INT
				,@InFechaActual DATE
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @MontoAhorro MONEY
				,@NumCA INT
				,@SaldoCA MONEY
				,@IdMonedaCA INT 
				,@SaldoCO MONEY
				
		SELECT @MontoAhorro = CO.Cuota
			   ,@SaldoCO = CO.Saldo
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
									,1
									,'Interes Mensual'

		IF((@SaldoCA - @MontoAhorro) < 0)
			SET @MontoAhorro = 0

		EXEC dbo.InsertarMov @InFechaActual
							,'Ahorro Cuenta Objetivo'
							,@IdMonedaCA
							,@MontoAhorro
							,@NumCA
							,14

		EXEC dbo.MovimientoCO @InIdCO
							,@InFechaActual
							,'Ahorro Mensual'
							,1
							,@MontoAhorro

	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
	END CATCH
	SET NOCOUNT OFF
END

