-- SP para ingresar un nuevo evento

USE Proyecto
GO

CREATE PROCEDURE dbo.InsertarEvento
				@InTipoEvento INT
				,@InIdUsuario INT
				,@InIP INT
				,@InFecha DATE
				,@InXMLA XML 
				,@InXMLD XML
				,@outCodeResult INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION T1;
			INSERT INTO dbo.Eventos(IdTipoEvento,IdUser,[IP], Fecha, XMLAntes, XMLDespues)
			VALUES(@InTipoEvento, @InIdUsuario, @InIP, @InFecha, @InXMLA, @InXMLD)
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