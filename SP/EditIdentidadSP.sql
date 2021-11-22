USE Proyecto
GO

CREATE PROCEDURE dbo.EditIdentidad
	@inNuevaIden INT
	, @inIdBen INT
	, @inIdUsuario INT 
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @XMLActual XML
				,@XMLNuevo XML

		DECLARE @Temp TABLE(
			[Email] [varchar](40),
			[FechaNacimiento] [date], 
			[Nombre] [varchar](40),
			[telefono1] [int],
			[telefono2] [int],
			[TipoDocuIdentidad] [int],
			[ValorDocumentoIdentidad] [int]
		);

		INSERT INTO @Temp(Email, FechaNacimiento, Nombre, telefono1, 
				telefono2, TipoDocuIdentidad, ValorDocumentoIdentidad)
		SELECT P.Email
			   ,P.FechaNacimiento
			   ,P.Nombre
			   ,P.telefono1
			   ,P.telefono2
			   ,P.TipoDocuIdentidad
			   ,P.ValorDocumentoIdentidad
		FROM dbo.Beneficiario B
		INNER JOIN dbo.Persona P 
			ON B.IdPersona = P.Id
		WHERE B.Id = @inIdBen

		SET @XMLActual = (SELECT * FROM @Temp AS Persona FOR XML AUTO)
		UPDATE @Temp SET ValorDocumentoIdentidad = @inNuevaIden
		SET @XMLNuevo = (SELECT * FROM @Temp AS Persona FOR XML AUTO)

		BEGIN TRANSACTION T1
			UPDATE Persona SET ValorDocumentoIdentidad=@inNuevaIden 
			WHERE Id=(SELECT IdPersona FROM Beneficiario WHERE Id=@inIdBen)

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