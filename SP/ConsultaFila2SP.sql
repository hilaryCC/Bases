-- SP para consulta de una fila de la tabla Cuenta Ahorro
CREATE PROCEDURE ConsultaFilaCA2
	@inId INT
	, @outNombre VARCHAR(40) OUTPUT
	, @outNumeroCuenta VARCHAR(40) OUTPUT
	, @outFechaCreacion VARCHAR(40) OUTPUT
	, @outSaldo FLOAT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	-- Obtener nombre 
	SELECT @outNombre = T.Nombre
	FROM CuentaAhorro C INNER JOIN Usuarios_Ver U 
	ON U.IdCuenta=C.Id INNER JOIN TipoCuentaAhorro T 
	ON C.TipoCuentaId = T.Id 
	WHERE U.Id= @inId
	-- Obtener Numero de Cuenta
	SELECT @outNumeroCuenta = C.NumeroCuenta
	FROM CuentaAhorro C INNER JOIN Usuarios_Ver U 
	ON U.IdCuenta=C.Id INNER JOIN TipoCuentaAhorro T 
	ON C.TipoCuentaId = T.Id 
	WHERE U.Id= @inId
	-- Obtener Fecha de Creacion
	SELECT @outFechaCreacion = C.FechaCreacion
	FROM CuentaAhorro C INNER JOIN Usuarios_Ver U 
	ON U.IdCuenta=C.Id INNER JOIN TipoCuentaAhorro T 
	ON C.TipoCuentaId = T.Id 
	WHERE U.Id= @inId
	-- Obtener Saldo
	SELECT @outSaldo = C.Saldo
	FROM CuentaAhorro C INNER JOIN Usuarios_Ver U 
	ON U.IdCuenta=C.Id INNER JOIN TipoCuentaAhorro T 
	ON C.TipoCuentaId = T.Id 
	WHERE U.Id= @inId
	SET NOCOUNT OFF
END