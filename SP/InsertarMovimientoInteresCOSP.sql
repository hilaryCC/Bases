-- SP para insertar movimientos Interes CO

USE Proyecto
GO

CREATE PROCEDURE dbo.MovimientoInteresCO
				@InIdCO INT
				,@InFechaActual DATE

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
			   ,@NuevoInteresAcumulado = @InteresAcumulado + @NuevoInteres
		FROM dbo.CuentaObjetivo CO
		INNER JOIN dbo.TasaInteres TI
			ON CO.IdTasaInteres = TI.Id
		WHERE CO.Id = @InIdCO

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION T1;
			INSERT INTO dbo.MovimientosInteresCO(IdCuentaOb, Descripcion, Fecha, Monto, NuevoInteresAcumulado)
			VALUES(@InIdCO, 'Interes Mensual', @InFechaActual, @NuevoInteres, @NuevoInteresAcumulado)

			UPDATE dbo.CuentaObjetivo SET InteresAcumulado = @NuevoInteresAcumulado
			WHERE Id = @InIdCO
		COMMIT TRANSACTION T1;
	END TRY

	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
	END CATCH
	SET NOCOUNT OFF
END