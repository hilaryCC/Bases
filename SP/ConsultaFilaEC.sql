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
	
	-- Obtener informacion
	SELECT @outId = Id 
	, @outFechaI = FechaInicio
	, @outFechaF = FechaFin
	, @outSaldoI = SaldoInicial
	, @outSaldoF = SaldoFinal
	FROM EstadoCuenta 
	WHERE IdCuenta=@inIdCuenta 
	ORDER BY FechaInicio DESC
	OFFSET @inCont ROWS
	FETCH NEXT 1 ROW ONLY;

	SET NOCOUNT OFF
END