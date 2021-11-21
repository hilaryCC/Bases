USE Proyecto
GO

CREATE PROCEDURE InsPersona
	@inTipoD INT
	, @inNombre VARCHAR(40)
	, @inIdent INT
	, @inFecha VARCHAR(40)
	, @inEmail VARCHAR(40)
	, @inTelefono1 INT
	, @inTelefono2 INT
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN TRANSACTION T1
			INSERT INTO dbo.Persona(TipoDocuIdentidad, Nombre, ValorDocumentoIdentidad, FechaNacimiento, Email, telefono1, telefono2)
			VALUES(@inTipoD, @inNombre, @inIdent, @inFecha, @inEmail, @inTelefono1, @inTelefono2)
		COMMIT TRANSACTION t1
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		--INSERT EN TABLA DE ERRORES;
		SET @outCodeResult=50005;
	END CATCH
	SET NOCOUNT OFF
END			