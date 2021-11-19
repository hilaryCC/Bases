-- SP para insertar movimientos CO

USE Proyecto
GO

CREATE PROCEDURE dbo.MovimientoCO
				@InIdCO INT
				,@InFechaActual DATE
				,@InDescripcion VARCHAR(50)
				,@InTipoMov INT
				,@InMonto MONEY

AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @Accion INT
				,@SaldoCO MONEY
				,@NuevoSaldo MONEY
				,@SaldoCA MONEY
				,@IdMonedaCA INT 
				,@NumCA INT 

		SELECT @SaldoCO = CO.Saldo
			   ,@Accion = TM.Operacion
			   ,@SaldoCA = CA.Saldo
			   ,@NumCA = CA.NumeroCuenta
			   ,@IdMonedaCA = TCA.IdTipoMoneda
		FROM dbo.CuentaObjetivo CO
		INNER JOIN dbo.TipoMovCO TM
			ON TM.Id = @InTipoMov
		INNER JOIN dbo.CuentaAhorro CA
			ON CA.Id = CO.IdCuenta
		INNER JOIN dbo.TipoCuentaAhorro TCA
			ON TCA.Id = CA.TipoCuentaId
		WHERE CO.Id = @InIdCO

		IF(@Accion = 1)
			SET @NuevoSaldo = @SaldoCO + @InMonto
		ELSE 
			SET @NuevoSaldo = @SaldoCO - @InMonto

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION T1;
			INSERT INTO dbo.MovimientosCO(IdCuentaOb, IdTipoMov, Descripcion, Fecha, Monto, NuevoSaldo)
			VALUES(@InIdCO, @InTipoMov, @InDescripcion, @InFechaActual, @InMonto, @NuevoSaldo)

			UPDATE dbo.CuentaObjetivo SET Saldo = @NuevoSaldo
			WHERE Id = @InIdCO
		COMMIT TRANSACTION T1;
	END TRY

	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
	END CATCH
	SET NOCOUNT OFF
END