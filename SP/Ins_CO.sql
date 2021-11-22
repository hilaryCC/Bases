CREATE PROCEDURE dbo.InsCuentaObjetivo
	@inIdCuenta INT
	, @inFechaInicio VARCHAR(40)
	, @inFechaFinal VARCHAR(40)
	, @inCuota INT
	, @inObjetivo VARCHAR(40)
	, @inDiaAhorro INT 
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
			[Cuota] [int]
		);

		INSERT INTO @Temp(CuentaMaestra, Objetivo, DiaAhorro, FechaInicio, FechaFinal, Cuota)
		SELECT C.NumeroCuenta
			   ,@inObjetivo
			   ,@inDiaAhorro
			   ,@inFechaInicio
			   ,@inFechaFinal
			   ,@inCuota
		FROM dbo.CuentaAhorro C
		WHERE C.Id = @inIdCuenta

		SET @XMLActual = ''
		SET @XMLNuevo = (SELECT * FROM @Temp AS CuentaCO FOR XML AUTO)

		BEGIN TRANSACTION T1
			INSERT INTO dbo.CuentaObjetivo(IdCuenta, Cuota, FechaInicio, FechaFinal, 
					DiaAhorro, Objetivo, Saldo, IdTasaInteres, InteresAcumulado, Activo)
			VALUES (@inIdCuenta
					, @inCuota
					, @inFechaInicio
					, @inFechaFinal
					, @inDiaAhorro
					, @inObjetivo
					, 0
					, DATEDIFF(MONTH, @inFechaInicio, @inFechaFinal)
					, 0
					, 1);

			INSERT INTO dbo.Eventos(IdTipoEvento,IdUser,[IP], Fecha, XMLAntes, XMLDespues)
			VALUES(4, @InIdUsuario, 0, GETDATE(), @XMLActual, @XMLNuevo)
		COMMIT TRANSACTION t1
		SET @outCodeResult = 0;
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		--INSERT EN TABLA DE ERRORES;
		SET @outCodeResult=50005;
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

