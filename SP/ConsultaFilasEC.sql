USE Proyecto1
GO

CREATE PROCEDURE ConsultarFilasEC
	@inId INT
	, @outCantFilas INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	SELECT @outCantFilas = COUNT(0) 
	FROM EstadoCuenta
	WHERE IdCuenta= @inId;
	SET NOCOUNT OFF
END