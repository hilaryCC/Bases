USE Proyecto
GO

CREATE PROCEDURE dbo.ConsultaAdmin1
	@inContador INT
	, @outIdCo INT OUTPUT
	, @outNumeroCuenta VARCHAR(40) OUTPUT
	, @outDescripcion VARCHAR(40) OUTPUT
	, @outCantRetReal INT OUTPUT
	, @outCantRetNoReal INT OUTPUT
	, @outMontoReal INT OUTPUT
	, @outMontoNoReal INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	
	DECLARE @IdCuenta INT=0
		  , @Temporal INT=0
		  , @Cuota INT=0;

	-- 1: Determinar el id de la cuenta
	SELECT @IdCuenta = IdCuenta
	FROM Movimiento 
	WHERE IdTipoMov = 14 
	AND monto = 0 
	ORDER BY Id ASC
	OFFSET @inContador ROWS
	FETCH NEXT 1 ROW ONLY;

	-- 2: Determinar el id de CO
	SELECT @outIdCo = Id 
		 , @Cuota = Cuota 
		 , @outDescripcion = Objetivo
	FROM dbo.CuentaObjetivo CO 
	WHERE CO.IdCuenta = @IdCuenta;

	-- 3: Determinar el numero
	-- de cuenta
	SELECT @outNumeroCuenta = NumeroCuenta
	FROM CuentaAhorro
	WHERE Id=@IdCuenta;

	-- 4: Determinar la cantidad 
	-- de retiros realizados
	SELECT @outCantRetReal = COUNT(*)
	FROM dbo.Movimiento 
	WHERE IdTipoMov = 14 
	AND IdCuenta=@IdCuenta
	AND Monto!=0;

	-- Determinar la cantidad 
	-- de retiros que no se
	-- hicieron por saldo -
	SELECT @Temporal = COUNT(*)
	FROM dbo.Movimiento 
	WHERE IdTipoMov = 14 
	AND IdCuenta=@IdCuenta
	AND Monto=0;

	-- 5: Determinar la cantidad
	-- de retiros si se hubieran
	-- realizado todos
	SET @outCantRetNoReal = @outCantRetReal + @Temporal;

	-- 6: Determinar la suma
	-- del monto debitado real
	SELECT @outMontoReal = SUM(Monto)
	FROM dbo.Movimiento 
	WHERE IdTipoMov = 14 
	AND IdCuenta=@IdCuenta;

	-- 7: Determinar la suma del 
	-- monto debitado si se hubieran
	-- realizado todos los retiros
	SET @outMontoNoReal = @outMontoReal + (@Temporal * @Cuota);

	SET NOCOUNT OFF
END
