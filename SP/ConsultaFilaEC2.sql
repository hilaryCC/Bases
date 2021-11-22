USE Proyecto
GO
CREATE PROCEDURE dbo.ConsultaFilaEC2
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
	
	-- Obtener informacion
	SELECT @outFechaI = FechaInicio 
	     , @outFechaF = FechaFin 
		 , @outSaldoM = SaldoMin 
		 , @outSaldoI = SaldoInicial 
		 , @outSaldoF = SaldoFinal 
		 , @outOpATM = OpATM 
		 , @outOpHumano = OpVentana 
	FROM EstadoCuenta 
	WHERE Id=@inId

	SET NOCOUNT OFF
END