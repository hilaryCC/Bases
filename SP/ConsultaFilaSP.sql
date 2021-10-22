-- Consulta una fila de la tabla Cuenta Ahorro
USE Proyecto
GO

CREATE PROCEDURE ConsultaFilaCA
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
	FROM CuentaAhorro C INNER JOIN TipoCuentaAhorro T 
	ON C.TipoCuentaId = T.Id
	WHERE  C.Id= @inId
	-- Obtener Numero de Cuenta
	SELECT @outNumeroCuenta = C.NumeroCuenta
	FROM CuentaAhorro C INNER JOIN TipoCuentaAhorro T 
	ON C.TipoCuentaId = T.Id
	WHERE  C.Id= @inId
	-- Obtener Fecha de Creacion
	SELECT @outFechaCreacion = C.FechaCreacion
	FROM CuentaAhorro C INNER JOIN TipoCuentaAhorro T 
	ON C.TipoCuentaId = T.Id
	WHERE  C.Id= @inId
	-- Obtener Saldo
	SELECT @outSaldo = C.Saldo
	FROM CuentaAhorro C INNER JOIN TipoCuentaAhorro T 
	ON C.TipoCuentaId = T.Id
	WHERE  C.Id= @inId
	SET NOCOUNT OFF
END