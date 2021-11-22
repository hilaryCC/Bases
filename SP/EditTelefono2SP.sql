USE Proyecto
GO

CREATE PROCEDURE EditTelefono2
	@inNuevoTelefono2 INT
	, @inIdBen INT
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN TRANSACTION T1
			UPDATE Persona 
			SET telefono2=@inNuevoTelefono2 
			WHERE Id=(SELECT IdPersona FROM Beneficiario WHERE Id=@inIdBen)
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
