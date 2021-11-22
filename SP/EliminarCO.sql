CREATE PROCEDURE dbo.EliminarCO
	@inId INT
	, @inIdUsuario INT 
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @XMLActual XML
				,@XMLNuevo XML

		DECLARE @Temp TABLE(
			[CuentaMaestra] [int],
			[Objetivo] [varchar](50),
			[DiaAhorro] [int],
			[FechaInicio] [date],
			[FechaFinal] [date],
			[Cuota] [int],
			[Saldo] [money],
			[InteresAcumulado] [money]
		);

		INSERT INTO @Temp(CuentaMaestra, Objetivo, DiaAhorro, FechaInicio, FechaFinal, Cuota, Saldo, InteresAcumulado)
		SELECT C.NumeroCuenta
			   ,CO.Objetivo
			   ,CO.DiaAhorro
			   ,CO.FechaInicio
			   ,CO.FechaFinal
			   ,CO.Cuota
			   ,CO.Saldo
			   ,CO.InteresAcumulado
		FROM dbo.CuentaObjetivo CO
		INNER JOIN dbo.CuentaAhorro C
			ON C.Id = CO.IdCuenta
		WHERE CO.Id = @inId

		SET @XMLActual = (SELECT * FROM @Temp AS CuentaCO FOR XML AUTO)
		SET @XMLNuevo = ''

		BEGIN TRANSACTION T1
			UPDATE dbo.CuentaObjetivo 
			SET Activo=0 
			WHERE Id=@inId

			INSERT INTO dbo.Eventos(IdTipoEvento,IdUser,[IP], Fecha, XMLAntes, XMLDespues)
			VALUES(6, @InIdUsuario, 0, GETDATE(), @XMLActual, @XMLNuevo)
		COMMIT TRANSACTION t1
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
