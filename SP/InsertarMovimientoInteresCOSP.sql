-- SP para insertar movimientos Interes CO

USE Proyecto
GO

CREATE PROCEDURE dbo.MovimientoInteresCO
				@InIdCO INT
				,@InFechaActual DATE
				,@InTipoMov INT
				,@InDescripcion VARCHAR(50)
				,@outCodeResult INT OUTPUT

AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @NuevoInteresAcumulado MONEY
				,@InteresAcumulado MONEY
				,@NuevoInteres MONEY
				,@TasaInteres FLOAT
				,@SaldoCO MONEY

		SELECT @InteresAcumulado = CO.InteresAcumulado
			   ,@NuevoInteres = CO.Saldo * (TI.Tasa / 100)
		FROM dbo.CuentaObjetivo CO
		INNER JOIN dbo.TasaInteres TI
			ON CO.IdTasaInteres = TI.Id
		WHERE CO.Id = @InIdCO

		IF(@InTipoMov = 1) --Agregar interes
			SET @NuevoInteresAcumulado = @InteresAcumulado + @NuevoInteres
		ELSE --Trasladar interes
		BEGIN
			SET @NuevoInteres = @InteresAcumulado
			SET @NuevoInteresAcumulado = @InteresAcumulado - @NuevoInteres
		END

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION T1;
			INSERT INTO dbo.MovimientosInteresCO(IdCuentaOb, Descripcion, Fecha, Monto, NuevoInteresAcumulado)
			VALUES(@InIdCO, @InDescripcion, @InFechaActual, @NuevoInteres, @NuevoInteresAcumulado)

			UPDATE dbo.CuentaObjetivo SET InteresAcumulado = @NuevoInteresAcumulado
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