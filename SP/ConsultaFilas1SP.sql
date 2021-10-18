-- Consulta la cantidad de filas de la tabla CuentaAhorro con
-- inner join en TipoCuentaAhorro
-- Salida:
--	+ Cantidad de filas 
CREATE PROCEDURE ConsultaFilasCuentaAhorro
	@outCantFilas INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	SELECT @outCantFilas = COUNT(0) FROM CuentaAhorro C INNER JOIN TipoCuentaAhorro T ON C.TipoCuentaId = T.Id;
	SET NOCOUNT OFF
END