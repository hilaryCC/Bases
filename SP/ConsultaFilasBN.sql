-- SP que indica la cantidad de filas de la tabla Beneficiario y Persona
-- Entrada: 
--	+ Id de la cuenta
-- Salida:
--	+ Cantidad de filas
USE Proyecto
GO

CREATE PROCEDURE dbo.ConsultarFilasBN
	@inId INT
	, @outCantFilas INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON

	SELECT @outCantFilas = COUNT(0) 
	FROM dbo.Persona P 
	INNER JOIN dbo.Beneficiario B ON P.Id=B.IdPersona
	INNER JOIN dbo.Parentezco Pa ON B.ParentezcoId=Pa.Id 
	
	SET NOCOUNT OFF
END