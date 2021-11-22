USE Proyecto
GO

CREATE PROCEDURE InsBeneficiario2
	@inIdCuenta INT
	, @inIden INT
	, @inParentezo VARCHAR(40)
	, @inPorcentaje INT
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN TRANSACTION T1
			INSERT INTO Beneficiario(IdCuenta, IdPersona, ParentezcoId, Porcentaje, Activo)
			VALUES (@inIdCuenta, (SELECT Id FROM Persona WHERE ValorDocumentoIdentidad=@inIden),
			(SELECT Id FROM Parentezco WHERE Nombre=@inParentezo), @inPorcentaje, 1);
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