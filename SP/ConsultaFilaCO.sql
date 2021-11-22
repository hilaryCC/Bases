CREATE PROCEDURE dbo.ConsultaFilaCO
	@inId INT
	, @inIdCuenta INT
	, @outFechaI VARCHAR(40) OUTPUT
	, @outFechaF VARCHAR(40) OUTPUT
	, @outDiaAhorro INT OUTPUT
	, @outCuota INT OUTPUT
	, @outObjetivo VARCHAR(40) OUTPUT
	, @outSaldo INT OUTPUT
	, @outInteres INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	
	-- Obtener variables
	SELECT @outFechaI = FechaInicio
	     , @outFechaF = FechaFinal
		 , @outDiaAhorro = DiaAhorro
	     , @outCuota = Cuota
	     , @outObjetivo = Objetivo
	     , @outSaldo = Saldo
	     , @outInteres = InteresAcumulado
	FROM CuentaObjetivo 
	WHERE Activo = 1 AND Id = @inId
	AND IdCuenta = @inIdCuenta

	SET NOCOUNT OFF
END