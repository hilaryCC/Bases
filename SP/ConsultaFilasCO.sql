CREATE PROCEDURE dbo.ConsultaFilasCO
	@inId INT
	, @outCantFilas INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	SELECT @outCantFilas = COUNT(0) 
	FROM CuentaObjetivo 
	SET NOCOUNT OFF
END
