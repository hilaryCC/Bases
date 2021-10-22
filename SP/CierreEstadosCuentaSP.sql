-- SP para cierre y apertura de estados de cuenta

USE Proyecto
GO

CREATE PROCEDURE CierreEstadosCuenta
				@FechaActual DATE		
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @IdEstadoCuenta INT
				,@FechaEC DATE
				,@DiaCreacion INT
				,@ECActual INT
				,@ECUltimo INT
				,@IdCuenta INT
				,@InteresCuenta FLOAT
				,@IdTipoCuenta INT
				,@SaldoMinimoTC FLOAT
				,@SaldoMinimoMes FLOAT
				,@OpATMCuenta INT
				,@OpVentanaCuenta INT
				,@OpATMTC INT
				,@OpVentanaTC INT
				,@MontoMovimiento FLOAT
				,@IdMonedaCuenta INT 
				,@NumeroCuenta INT
				,@Exceso INT

		DECLARE @EstadosActivos TABLE(
			[Id] [int] PRIMARY KEY IDENTITY(1,1),
			[IdEC] [int]
		);
		
		INSERT INTO @EstadosActivos (IdEC)
			SELECT EC.Id FROM dbo.EstadoCuenta EC 
				WHERE Activo = 1 
				ORDER BY IdCuenta

		SELECT @ECActual = MIN(Id), @ECUltimo = MAX(Id) FROM @EstadosActivos
		BEGIN TRANSACTION T1;
			WHILE (@ECActual <= @ECUltimo)
			BEGIN
				-- Seleccion de variables
				SELECT @IdEstadoCuenta = IdEC FROM @EstadosActivos 
					WHERE Id = @ECActual

				SELECT @IdCuenta = IdCuenta
						,@FechaEC = FechaInicio
						,@SaldoMinimoMes = SaldoMin
						,@OpATMCuenta = OpATM
						,@OpVentanaCuenta = OpVentana
					FROM dbo.EstadoCuenta WHERE Id = @IdEstadoCuenta

				SELECT @DiaCreacion = DAY(FechaCreacion)
						,@IdTipoCuenta = TipoCuentaId
						,@NumeroCuenta = NumeroCuenta
					FROM dbo.CuentaAhorro WHERE Id = @IdCuenta

				SELECT @InteresCuenta = Interes
						,@IdMonedaCuenta = IdTipoMoneda
						,@SaldoMinimoTC = SaldoMinimo
						,@OpATMTC = NumRetirosAutomatico
						,@OpVentanaTC = NumRetirosHumano
					FROM dbo.TipoCuentaAhorro WHERE Id = @IdTipoCuenta


				--Verificacion de fechas
				IF (@DiaCreacion = DAY(@FechaActual))
							AND (@FechaEC < @FechaActual)
				BEGIN
					--Aplicacion de interes al saldo minimo
					SET @MontoMovimiento = @SaldoMinimoMes * ((@InteresCuenta / 12) /100) -- Interes anual entre 12
					EXEC InsertarMov @FechaActual
						,'Interes mensual'
						,@IdMonedaCuenta
						,@MontoMovimiento
						,@NumeroCuenta
						,13

					--Cobro cargos por servicio
					--Falta de revisar los datos--
					------------------------------

					--Para comision por Operaciones en Retiros automaticos
					IF (@OpATMCuenta > @OpATMTC)
					BEGIN
						SET @Exceso = @OpATMCuenta - @OpATMTC
						SELECT @MontoMovimiento = (C.ComisionAutomatico * @Exceso)
							FROM dbo.TipoCuentaAhorro C WHERE C.Id = @IdTipoCuenta 
						EXEC InsertarMov @FechaActual
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
						EXEC InsertarMov @FechaActual
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
						EXEC InsertarMov @FechaActual
							,'Multa por incumplimiento del saldo minimo'
							,@IdMonedaCuenta
							,@MontoMovimiento
							,@NumeroCuenta
							,17
					END


					--Cierre y apertura de Estado de Cuenta
					UPDATE dbo.EstadoCuenta SET Activo = 0
											,FechaFin = @FechaActual
											,SaldoFinal = (SELECT Saldo 
												FROM dbo.CuentaAhorro 
												WHERE Id = @IdCuenta)
							WHERE Id = @IdEstadoCuenta
					INSERT INTO dbo.EstadoCuenta(FechaInicio, FechaFin, SaldoInicial, 
									SaldoFinal, IdCuenta, OpATM, OpVentana, Activo, SaldoMin)
						SELECT DATEADD(DAY, 1, @FechaActual), NULL, C.Saldo, NULL, C.Id, 0, 0, 1, C.Saldo 
							FROM dbo.CuentaAhorro C WHERE C.Id = @IdCuenta
				END

				SET @ECActual = @ECActual + 1
			END
		COMMIT TRANSACTION T1;
	END TRY

	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
	END CATCH
	SET NOCOUNT OFF
END