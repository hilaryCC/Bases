-- SP para consulta de una fila de la tabla Cuenta Ahorro
USE Proyecto
GO

CREATE PROCEDURE ConsultaFilaCA2
	@inCont INT
	, @inIdPersona INT
	, @outNombre VARCHAR(40) OUTPUT
	, @outNumeroCuenta VARCHAR(40) OUTPUT
	, @outFechaCreacion VARCHAR(40) OUTPUT
	, @outSaldo FLOAT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON

	-- Obtener informacion
	SELECT @outNombre = T.Nombre
	     , @outNumeroCuenta = C.NumeroCuenta
	     , @outFechaCreacion = C.FechaCreacion
	     , @outSaldo = C.Saldo
	FROM CuentaAhorro C 
	INNER JOIN Usuarios_Ver U ON U.IdCuenta=C.Id
	INNER JOIN TipoCuentaAhorro T ON C.TipoCuentaId = T.Id 
	WHERE IdPersona=@inIdPersona 
	ORDER BY C.Id
	OFFSET @inCont ROWS
	FETCH NEXT 1 ROW ONLY;

	SET NOCOUNT OFF
END

