USE Proyecto
GO

CREATE PROCEDURE ConsultarFilasCEC
	@inId INT
	, @outCantFilas INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	SELECT @outCantFilas = COUNT(0) 
	FROM Movimiento
	WHERE IdEstadoCuenta= @inId;
	SET NOCOUNT OFF
END