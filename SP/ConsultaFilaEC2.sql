USE Proyecto1
GO
CREATE PROCEDURE ConsultaFilaEC2
	@inId INT
	, @outFechaI VARCHAR(40) OUTPUT
	, @outFechaF VARCHAR(40) OUTPUT
	, @outSaldoM FLOAT OUTPUT
	, @outSaldoI FLOAT OUTPUT
	, @outSaldoF FLOAT OUTPUT
	, @outOpATM INT OUTPUT
	, @outOpHumano INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	
	-- Obtener fecha inicio
	SELECT @outFechaI = FechaInicio 
	FROM EstadoCuenta 
	WHERE Id=@inId

	-- Obtener fecha final
	SELECT @outFechaF = FechaFin 
	FROM EstadoCuenta 
	WHERE Id=@inId

	-- Obtener saldo minimo
	SELECT @outSaldoM = SaldoMin 
	FROM EstadoCuenta 
	WHERE Id=@inId

	-- Obtener saldo inicial
	SELECT @outSaldoI = SaldoInicial 
	FROM EstadoCuenta 
	WHERE Id=@inId

	-- Obtener saldo final
	SELECT @outSaldoF = SaldoFinal 
	FROM EstadoCuenta 
	WHERE Id=@inId

	-- Obtener cantidad operacion en atm
	SELECT @outOpATM = OpATM 
	FROM EstadoCuenta 
	WHERE Id=@inId

	-- Obtener cantidad operacion en cajero humano
	SELECT @outOpHumano = OpVentana 
	FROM EstadoCuenta 
	WHERE Id=@inId

	SET NOCOUNT OFF
END