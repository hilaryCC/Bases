-- Consulta una fila de la tabla Cuenta Ahorro
USE Proyecto
GO

CREATE PROCEDURE dbo.ConsultaFilaCA
	@inId INT
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
	FROM CuentaAhorro C INNER JOIN TipoCuentaAhorro T 
	ON C.TipoCuentaId = T.Id
	WHERE  C.Id= @inId
	
	SET NOCOUNT OFF
END