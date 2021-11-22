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
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY

		SET TRANSACTION ISOLATION LEVEL READ COMMITTED
		BEGIN TRANSACTION T1;
			INSERT INTO dbo.Eventos(IdTipoEvento,IdUser,[IP], Fecha, XMLAntes, XMLDespues)
			VALUES(@InTipoEvento, @InIdUsuario, @InIP, @InFecha, @InXMLA, @InXMLD)
		COMMIT TRANSACTION T1;

	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
	END CATCH
	SET NOCOUNT OFF
END