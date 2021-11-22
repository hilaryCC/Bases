USE Proyecto
GO

CREATE PROCEDURE InsBeneficiario2
	@inIdCuenta INT
	, @inIden INT
	, @inParentezo VARCHAR(40)
	, @inPorcentaje INT
	, @inIdUsuario INT
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		DECLARE @XMLNuevo XML
				,@XMLActual XML

		DECLARE @Temp TABLE(
			[NumC] [int],
			[Parentezco] [int],
			[Porcentaje] [int],
			[Iden] [int]
		);
		INSERT INTO @Temp(NumC, Parentezco, Porcentaje, Iden)
		SELECT C.NumeroCuenta
				,Pa.Id
				,@inPorcentaje
				,@inIden
		FROM dbo.CuentaAhorro C
		INNER JOIN dbo.Parentezco Pa
			ON Pa.Nombre = @inParentezo
		WHERE C.Id = @inIdCuenta

		SET @XMLNuevo = (SELECT NumC AS NumeroCuenta
								,Parentezco AS ParentezcoId
								,Porcentaje AS Porcentaje
								,Iden AS ValorDocumentoIdentidadBeneficiario
							FROM @Temp AS Beneficiario
							FOR XML AUTO) 
		SET @XMLActual = ''

		BEGIN TRANSACTION T1
			INSERT INTO Beneficiario(IdCuenta, IdPersona, ParentezcoId, Porcentaje, Activo)
			VALUES (@inIdCuenta, (SELECT Id FROM Persona WHERE ValorDocumentoIdentidad=@inIden),
			(SELECT Id FROM Parentezco WHERE Nombre=@inParentezo), @inPorcentaje, 1);

			INSERT INTO dbo.Eventos(IdTipoEvento,IdUser,[IP], Fecha, XMLAntes, XMLDespues)
			VALUES(1, @InIdUsuario, 0, GETDATE(), @XMLActual, @XMLNuevo)
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