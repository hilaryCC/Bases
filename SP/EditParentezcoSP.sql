USE Proyecto
GO

CREATE PROCEDURE dbo.EditParentezco
	@inNuevoParentezco VARCHAR(40)
	, @inIdBen INT
	, @inIdUsuario INT 
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @XMLNuevo XML
				,@XMLActual XML

		DECLARE @Temp TABLE(
			[NumeroCuenta] [int],
			[Parentezco] [int],
			[Porcentaje] [int],
			[ValorDocumentoIdentidadBeneficiario] [int]
		);
		INSERT INTO @Temp(NumeroCuenta, Parentezco, Porcentaje, ValorDocumentoIdentidadBeneficiario)
		SELECT C.NumeroCuenta
				,B.ParentezcoId
				,B.Porcentaje
				,P.ValorDocumentoIdentidad
		FROM dbo.Beneficiario B
		INNER JOIN dbo.CuentaAhorro C
			ON C.Id = B.IdCuenta
		INNER JOIN dbo.Persona P
			ON P.Id = B.IdPersona
		WHERE B.Id = @inIdBen


		SET @XMLActual = (SELECT * FROM @Temp AS Beneficiario FOR XML AUTO)
		UPDATE @Temp SET Parentezco = (SELECT Id FROM Parentezco WHERE Nombre=@inNuevoParentezco) 
		SET @XMLNuevo = (SELECT * FROM @Temp AS Beneficiario FOR XML AUTO)
		
		BEGIN TRANSACTION T1
			UPDATE Beneficiario 
			SET ParentezcoId=(SELECT Id FROM Parentezco WHERE Nombre=@inNuevoParentezco) 
			WHERE Id=@inIdBen

			INSERT INTO dbo.Eventos(IdTipoEvento,IdUser,[IP], Fecha, XMLAntes, XMLDespues)
			VALUES(2, @InIdUsuario, 0, GETDATE(), @XMLActual, @XMLNuevo)
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