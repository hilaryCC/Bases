USE Proyecto1
GO
CREATE PROCEDURE ConsultaFilaEC
	@inCont INT
	, @inIdCuenta INT
	, @outId INT OUTPUT
	, @outFechaI VARCHAR(40) OUTPUT
	, @outFechaF VARCHAR(40) OUTPUT
	, @outSaldoI FLOAT OUTPUT
	, @outSaldoF FLOAT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	
	-- Obtener el Id
	SELECT @outId = Id FROM EstadoCuenta 
	WHERE IdCuenta=@inIdCuenta 
	ORDER BY FechaInicio DESC
	OFFSET @inCont ROWS
	FETCH NEXT 1 ROW ONLY;

	-- Obtener fecha inicio
	SELECT @outFechaI = FechaInicio FROM EstadoCuenta 
	WHERE IdCuenta=@inIdCuenta 
	ORDER BY FechaInicio DESC
	OFFSET @inCont ROWS
	FETCH NEXT 1 ROW ONLY;

	-- Obtener fecha fin
	SELECT @outFechaF = FechaFin FROM EstadoCuenta 
	WHERE IdCuenta=@inIdCuenta 
	ORDER BY FechaInicio DESC
	OFFSET @inCont ROWS
	FETCH NEXT 1 ROW ONLY;

	-- Obtener saldo inicial
	SELECT @outSaldoI = SaldoInicial FROM EstadoCuenta 
	WHERE IdCuenta=@inIdCuenta 
	ORDER BY FechaInicio DESC
	OFFSET @inCont ROWS
	FETCH NEXT 1 ROW ONLY;

	-- Obtener saldo final
	SELECT @outSaldoF = SaldoFinal FROM EstadoCuenta 
	WHERE IdCuenta=@inIdCuenta 
	ORDER BY FechaInicio DESC
	OFFSET @inCont ROWS
	FETCH NEXT 1 ROW ONLY;

	SET NOCOUNT OFF
END