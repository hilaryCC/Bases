-- SP para cierre y apertura de estados de cuenta

USE Proyecto
GO

CREATE PROCEDURE dbo.CerrarEC
				@InIdCuenta INT
				,@InFechaActual DATE
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @IdEstadoCuenta INT
				,@InteresCuenta FLOAT
				,@IdTipoCuenta INT
				,@SaldoMinimoTC MONEY
				,@SaldoMinimoMes MONEY
				,@OpATMCuenta INT
				,@OpVentanaCuenta INT
				,@OpATMTC INT
				,@OpVentanaTC INT
				,@MontoMovimiento MONEY
				,@IdMonedaCuenta INT 
				,@NumeroCuenta INT
				,@Exceso INT
				,@SaldoCuenta MONEY

		-- Seleccion de variables --
		SELECT @IdEstadoCuenta = EC.Id
			   ,@SaldoMinimoMes = EC.SaldoMin
			   ,@OpATMCuenta = EC.OpATM
			   ,@OpVentanaCuenta = EC.OpVentana
			   ,@IdTipoCuenta = C.TipoCuentaId
			   ,@NumeroCuenta = C.NumeroCuenta
			   ,@InteresCuenta = TC.Interes
			   ,@IdMonedaCuenta = TC.IdTipoMoneda
			   ,@SaldoMinimoTC = TC.SaldoMinimo
			   ,@OpATMTC = TC.NumRetirosAutomatico
			   ,@OpVentanaTC = TC.NumRetirosHumano
		FROM dbo.EstadoCuenta EC
		INNER JOIN dbo.CuentaAhorro C 
			ON C.Id = EC.IdCuenta
		INNER JOIN dbo.TipoCuentaAhorro TC
			ON TC.Id = C.TipoCuentaId
		WHERE EC.IdCuenta = @InIdCuenta
			AND EC.Activo = 1

		-- Interes al saldo minimo --
		SET @MontoMovimiento = @SaldoMinimoMes * ((@InteresCuenta / 12) /100) -- Interes anual entre 12
		EXEC InsertarMov @InFechaActual
			,'Interes mensual'
			,@IdMonedaCuenta
			,@MontoMovimiento
			,@NumeroCuenta
			,13

		--Cobro mensual cargo por servicio
		SELECT @MontoMovimiento = CargoServicios
			FROM dbo.TipoCuentaAhorro C WHERE C.Id = @IdTipoCuenta 
		EXEC InsertarMov @InFechaActual
			,'Cargo mensual por servicio'
			,@IdMonedaCuenta
			,@MontoMovimiento
			,@NumeroCuenta
			,12

		--Para comision por Operaciones en Retiros automaticos
		IF (@OpATMCuenta > @OpATMTC)
		BEGIN
			SET @Exceso = @OpATMCuenta - @OpATMTC
			SELECT @MontoMovimiento = (C.ComisionAutomatico * @Exceso)
				FROM dbo.TipoCuentaAhorro C WHERE C.Id = @IdTipoCuenta 
			EXEC InsertarMov @InFechaActual
				,'Comision Cajero Automatico'
				,@IdMonedaCuenta
				,@MontoMovimiento
				,@NumeroCuenta
				,10
		END

		--Para comision por Operaciones en Retiros automaticos
		IF (@OpVentanaCuenta > @OpVentanaTC)
		BEGIN
			SET @Exceso = @OpVentanaCuenta - @OpVentanaTC
			SELECT @MontoMovimiento = (C.ComisionHumano * @Exceso)
				FROM dbo.TipoCuentaAhorro C WHERE C.Id = @IdTipoCuenta 
			EXEC InsertarMov @InFechaActual
				,'Comision Cajero Humano'
				,@IdMonedaCuenta
				,@MontoMovimiento
				,@NumeroCuenta
				,9
		END

		--Para Multa por saldo minimo
		IF (@SaldoMinimoMes < @SaldoMinimoTC) 
		BEGIN
			SELECT @MontoMovimiento = MultaSaldoMin
				FROM dbo.TipoCuentaAhorro WHERE Id = @IdTipoCuenta
			EXEC InsertarMov @InFechaActual
				,'Multa por incumplimiento del saldo minimo'
				,@IdMonedaCuenta
				,@MontoMovimiento
				,@NumeroCuenta
				,17
		END

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION T1;
			--Cierre y apertura de Estado de Cuenta
			SELECT @SaldoCuenta = C.Saldo 
			FROM  dbo.CuentaAhorro C
			WHERE C.Id = @InIdCuenta

			UPDATE dbo.EstadoCuenta SET Activo = 0
									,FechaFin = @InFechaActual
									,SaldoFinal = @SaldoCuenta
					WHERE Id = @IdEstadoCuenta

			INSERT INTO dbo.EstadoCuenta(FechaInicio, FechaFin, SaldoInicial, 
							SaldoFinal, IdCuenta, OpATM, OpVentana, Activo, SaldoMin)
				SELECT DATEADD(DAY, 1, @InFechaActual), NULL, C.Saldo, NULL, C.Id, 0, 0, 1, C.Saldo 
					FROM dbo.CuentaAhorro C WHERE C.Id = @InIdCuenta
		COMMIT TRANSACTION T1;
	END TRY

	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
	END CATCH
	SET NOCOUNT OFF
END