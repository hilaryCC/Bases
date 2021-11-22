USE Proyecto
GO

CREATE PROCEDURE EliminarBeneficiario
	@inIdBen INT
	, @inIdUsuario INT 
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @XMLActual XML
				,@XMLNuevo XML

		DECLARE @Temp TABLE(
			[NumeroCuenta] [int],
			[ParentezcoId] [int],
			[Porcentaje] [int],
			[ValorDocumentoIdentidadBeneficiario] [int]
		);
		INSERT INTO @Temp(NumeroCuenta, ParentezcoId, Porcentaje, ValorDocumentoIdentidadBeneficiario)
		SELECT C.NumeroCuenta
			   ,Beneficiario.ParentezcoId
			   ,Beneficiario.Porcentaje
			   ,P.ValorDocumentoIdentidad
		FROM dbo.Beneficiario AS Beneficiario
		INNER JOIN dbo.CuentaAhorro C
			ON C.Id = Beneficiario.IdCuenta
		INNER JOIN dbo.Persona P
			ON P.Id = Beneficiario.IdPersona
		WHERE Beneficiario.Id = @inIdBen

		SET @XMLActual = (SELECT * FROM @Temp AS Beneficiario FOR XML AUTO)
		SET @XMLNuevo = ''

		BEGIN TRANSACTION T1
			UPDATE dbo.Beneficiario 
			SET Activo=0 
			WHERE Id=@inIdBen
			UPDATE dbo.Beneficiario 
			SET FechaDesactivacion=GETDATE() 
			WHERE Id=@inIdBen

			INSERT INTO dbo.Eventos(IdTipoEvento,IdUser,[IP], Fecha, XMLAntes, XMLDespues)
			VALUES(3, @InIdUsuario, 0, GETDATE(), @XMLActual, @XMLNuevo)
		COMMIT TRANSACTION t1
		SET @outCodeResult = 0;
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		--INSERT EN TABLA DE ERRORES;
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
