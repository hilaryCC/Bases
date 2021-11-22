-- SP que indica la cantidad de filas de la tabla Cuenta Ahorro y Usuarios_Ver
-- Entrada: 
--	+ Id de la cuenta
-- Salida:
--	+ Cantidad de filas
USE Proyecto
GO

CREATE PROCEDURE dbo.ConsultarFilasCuentaAhorro2
	@inId INT
	, @outCantFilas INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON

	SELECT @outCantFilas = COUNT(0) 
	FROM CuentaAhorro C 
	INNER JOIN Usuarios_Ver U ON U.IdCuenta=C.Id 
	INNER JOIN TipoCuentaAhorro T ON C.TipoCuentaId = T.Id
	WHERE U.IdUser= @inId;
	
	SET NOCOUNT OFF
END

