USE Proyecto1
GO

CREATE PROCEDURE ConsultarFilasAdmin
	@inId INT
	, @outCantFilas INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON

	SELECT @outCantFilas = COUNT(*)
	FROM dbo.Movimiento 
	WHERE IdTipoMov = 14 
	AND monto = 0 


	SET NOCOUNT OFF
END