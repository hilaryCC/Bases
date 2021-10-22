-- SP para ingresar un movimiento

USE Proyecto
GO

CREATE PROCEDURE InsertarMov
				@Fecha DATE
				,@Descripcion VARCHAR(50)
				,@IdMoneda INT
				,@Monto FLOAT
				,@NumeroCuenta INT
				,@TipoMov INT
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

		SELECT @IdCuenta = Id FROM dbo.CuentaAhorro C 
			WHERE C.NumeroCuenta = @NumeroCuenta
		SELECT @Accion = Operacion FROM dbo.Tipo_Movimiento T 
			WHERE T.Id = @TipoMov 
		SELECT @IdEstadoCuenta = Id FROM dbo.EstadoCuenta EC 
			WHERE EC.IdCuenta = @IdCuenta AND EC.Activo = 1
		SELECT @IdTipoCambio = Id FROM dbo.TipoCambio TC 
			WHERE TC.Fecha = @Fecha
		SELECT @MonedaCuenta = IdTipoMoneda FROM dbo.TipoCuentaAhorro TCA 
			WHERE TCA.Id = (SELECT TipoCuentaId FROM dbo.CuentaAhorro C 
								WHERE C.Id = @IdCuenta)
		SELECT @SaldoActual = Saldo FROM dbo.CuentaAhorro C 
			WHERE C.Id = @IdCuenta
			
		BEGIN TRANSACTION T1;
			IF (@IdMoneda = 1) AND (@MonedaCuenta = 2) --Movimiento en colones, cuenta en dolares
				SET @MontoMismaMoneda = @Monto / (SELECT ValorCompra 
												FROM dbo.TipoCambio T 
												WHERE T.Id = @IdTipoCambio)
			
			ELSE IF ((@IdMoneda = 2) AND (@MonedaCuenta = 1)) --Movimiento en dolares, cuenta en colones
				SET @MontoMismaMoneda = @Monto * (SELECT ValorVenta 
												FROM dbo.TipoCambio T 
												WHERE T.Id = @IdTipoCambio)
			
			ELSE --Movimiento y cuenta de la misma moneda
				SET @MontoMismaMoneda = @Monto 

			IF (@Accion = 1) --Suma o resta segun el tipo de movimiento
				SET @nuevoSaldo = @SaldoActual + @MontoMismaMoneda
			ELSE
				SET @nuevoSaldo = @SaldoActual - @MontoMismaMoneda

			IF (@TipoMov = 2) OR (@TipoMov = 6) OR (@TipoMov = 10) --Aumento contador de operaciones en cajero Automatico
				UPDATE dbo.EstadoCuenta SET OpATM = (OpATM + 1) 
					WHERE Id = @IdEstadoCuenta 
			
			ELSE IF(@TipoMov = 1) OR (@TipoMov = 7) OR (@TipoMov = 9) --Aumento contador de operaciones en ventana
				UPDATE dbo.EstadoCuenta SET OpVentana = (OpVentana + 1) 
					WHERE Id = @IdEstadoCuenta

			INSERT INTO dbo.Movimiento(Fecha, IdCuenta, IdEstadoCuenta, Descripcion, 
									IdMoneda, monto, nuevoSaldo, IdTipoMov, IdTipoCambio)
				VALUES(@Fecha, @IdCuenta, @IdEstadoCuenta, @Descripcion, @IdMoneda,
						@Monto, @nuevoSaldo, @TipoMov, @IdTipoCambio)	

			UPDATE dbo.CuentaAhorro SET Saldo = @nuevoSaldo 
				WHERE Id = @IdCuenta --Actualiza el saldo de la cuenta

			SELECT @SaldoMinimo = MIN(nuevoSaldo) FROM dbo.Movimiento --Busca el saldo menor de los movimientos
				WHERE IdEstadoCuenta = @IdEstadoCuenta

			UPDATE dbo.EstadoCuenta --Actualiza el menor saldo hasta el momento según los movimientos realizados
				SET SaldoMin = @SaldoMinimo
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


