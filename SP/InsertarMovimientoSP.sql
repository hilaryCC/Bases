-- SP para ingresar un movimiento

USE Proyecto
GO

CREATE PROCEDURE dbo.InsertarMov
				@InFecha DATE
				,@InDescripcion VARCHAR(50)
				,@InIdMoneda INT
				,@InMonto FLOAT
				,@InNumeroCuenta INT
				,@InTipoMov INT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @IdCuenta INT
				,@Accion INT
				,@IdEstadoCuenta INT
				,@IdTipoCambio INT
				,@nuevoSaldo FLOAT
				,@SaldoActual FLOAT
				,@MonedaCuenta INT
				,@MontoMismaMoneda FLOAT 
				,@OutResultCode INT 
				,@SaldoMinimo FLOAT
				,@ValorCompra INT
				,@ValorVenta INT
				,@CantOpATM INT
				,@CantOpVentana INT

		SELECT @IdCuenta = C.Id 
			   ,@SaldoActual = C.Saldo
			   ,@MonedaCuenta = TCA.IdTipoMoneda
			   ,@Accion = TM.Operacion
			   ,@IdEstadoCuenta = EC.Id
			   ,@IdTipoCambio = TC.Id
			   ,@ValorCompra = TC.ValorCompra
			   ,@ValorVenta = TC.ValorVenta
		FROM dbo.CuentaAhorro C 
		INNER JOIN dbo.Tipo_Movimiento TM 
			ON TM.Id = @InTipoMov
		INNER JOIN dbo.EstadoCuenta EC
			ON EC.IdCuenta = C.Id
		INNER JOIN dbo.TipoCambio TC
			ON	TC.Fecha = @InFecha
		INNER JOIN dbo.TipoCuentaAhorro TCA
			ON TCA.Id = C.TipoCuentaId
		WHERE (C.NumeroCuenta = @InNumeroCuenta)
			AND (EC.Activo = 1)

		SET @CantOpATM = 0
		SET @CantOpVentana = 0
		
		IF (@InIdMoneda = 1) AND (@MonedaCuenta = 2) --Movimiento en colones, cuenta en dolares
			SET @MontoMismaMoneda = @InMonto / @ValorCompra
			
		ELSE IF ((@InIdMoneda = 2) AND (@MonedaCuenta = 1)) --Movimiento en dolares, cuenta en colones
			SET @MontoMismaMoneda = @InMonto * @ValorVenta
			
		ELSE --Movimiento y cuenta de la misma moneda
			SET @MontoMismaMoneda = @InMonto 

		IF (@Accion = 1) --Suma o resta segun el tipo de movimiento
			SET @nuevoSaldo = @SaldoActual + @MontoMismaMoneda
		ELSE
			SET @nuevoSaldo = @SaldoActual - @MontoMismaMoneda

		IF (@InTipoMov = 2) OR (@InTipoMov = 6) OR (@InTipoMov = 10) --Aumento contador de operaciones en cajero Automatico
			SET @CantOpATM = 1
			
		ELSE IF(@InTipoMov = 1) OR (@InTipoMov = 7) OR (@InTipoMov = 9) --Aumento contador de operaciones en ventana
			SET @CantOpVentana = 1
				
		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION T1;
			INSERT INTO dbo.Movimiento(Fecha, IdCuenta, IdEstadoCuenta, Descripcion, 
								IdMoneda, monto, MontoCambioAplicado, nuevoSaldo, IdTipoMov, IdTipoCambio)
			VALUES(@InFecha, @IdCuenta, @IdEstadoCuenta, @InDescripcion, @InIdMoneda,
					@InMonto, @MontoMismaMoneda, @nuevoSaldo, @InTipoMov, @IdTipoCambio)
					
			SELECT @SaldoMinimo = MIN(nuevoSaldo) FROM dbo.Movimiento --Busca el saldo menor de los movimientos
				WHERE IdEstadoCuenta = @IdEstadoCuenta

			UPDATE dbo.CuentaAhorro SET Saldo = @nuevoSaldo 
				WHERE Id = @IdCuenta --Actualiza el saldo de la cuenta

			UPDATE dbo.EstadoCuenta --Actualiza el estado de cuenta, saldo minimo y contadores
				SET SaldoMin = @SaldoMinimo
					,OpATM = OpATM+@CantOpATM
					,OpVentana = OpVentana+@CantOpVentana
				WHERE Id = @IdEstadoCuenta 
		COMMIT TRANSACTION T1;

		SET @OutResultCode = 0;
	END TRY

	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		SET @OutResultCode = 50005;
	END CATCH
	SET NOCOUNT OFF
END

