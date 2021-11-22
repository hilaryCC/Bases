CREATE PROCEDURE dbo.EditFecha2CO
	@inNuevaFechaF VARCHAR(40)
	, @inIdCO INT
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
		WHERE CO.Id = @inIdCO

		SET @XMLActual = (SELECT * FROM @Temp AS CuentaCO FOR XML AUTO)
		UPDATE @Temp SET FechaFinal = @inNuevaFechaF
		SET @XMLNuevo = (SELECT * FROM @Temp AS CuentaCO FOR XML AUTO)

		BEGIN TRANSACTION T1
			UPDATE CuentaObjetivo SET FechaFinal=@inNuevaFechaF 
			WHERE Id=@inIdCO;

			INSERT INTO dbo.Eventos(IdTipoEvento,IdUser,[IP], Fecha, XMLAntes, XMLDespues)
			VALUES(5, @InIdUsuario, 0, GETDATE(), @XMLActual, @XMLNuevo)
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