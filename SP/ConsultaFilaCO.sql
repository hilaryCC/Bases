CREATE PROCEDURE ConsultaFilaCO
	@inId INT
	, @inIdCuenta INT
	, @outFechaI VARCHAR(40) OUTPUT
	, @outFechaF VARCHAR(40) OUTPUT
	, @outCuota INT OUTPUT
	, @outObjetivo VARCHAR(40) OUTPUT
	, @outSaldo INT OUTPUT
	, @outInteres INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	
	-- Obtener fecha inicio
	SELECT @outFechaI = FechaInicio
	FROM CuentaObjetivo 
	WHERE Activo = 1 AND Id = @inId
	AND IdCuenta = @inIdCuenta
	
	-- Obtener ficha fin
	SELECT @outFechaF = FechaFinal
	FROM CuentaObjetivo 
	WHERE Activo = 1 AND Id = @inId
	AND IdCuenta = @inIdCuenta

	-- Obtener Cuota
	SELECT @outCuota = Cuota
	FROM CuentaObjetivo 
	WHERE Activo = 1 AND Id = @inId
	AND IdCuenta = @inIdCuenta

	-- Obtener Objetivo
	SELECT @outObjetivo = Objetivo
	FROM CuentaObjetivo 
	WHERE Activo = 1 AND Id = @inId
	AND IdCuenta = @inIdCuenta

	-- Obtener Saldo
	SELECT @outSaldo = Saldo
	FROM CuentaObjetivo 
	WHERE Activo = 1 AND Id = @inId
	AND IdCuenta = @inIdCuenta

	-- Obtener Interes
	SELECT @outInteres = InteresAnual
	FROM CuentaObjetivo 
	WHERE Activo = 1 AND Id = @inId
	AND IdCuenta = @inIdCuenta

	SET NOCOUNT OFF
END