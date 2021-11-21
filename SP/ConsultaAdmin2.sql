USE Proyecto1
GO
CREATE PROCEDURE ConsultaAdmin2
	@inIdCuenta INT,
	@inDias INT,
	@outInfo INT OUTPUT,
	@outMesMasOp INT OUTPUT,
	@outAnoMasOp INT OUTPUT,
	@outProm INT OUTPUT,
	@outNumeroCuenta VARCHAR(40) OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	
	DECLARE @CumpleCon1 BIT=0
		  , @CumpleCon2 BIT=0
		  , @FechaFinal DATE
		  , @FechaInicio DATE
		  , @FechaActual DATE
		  , @HayMulta INT=0
		  , @CantOpATMHechas INT=0
		  , @CantOpATMHechas2 INT=0
		  , @CantOpATMtotal INT=0
		  , @Contador INT=1
		  , @HuboOpATM INT=0
		  , @SumaTotal INT
		  , @CantOp INT
		  , @IdFechaF INT
		  , @IdActual INT;


	-- ==================== PRIMERA CONDICION =====================

	-- 1: Determinar el id de la tabla movimientos con tipo mov 10
	-- ya que estos son los movimientos por multa por exceso de
	-- operaciones en cajero automatico. 

	SELECT @HayMulta = Id
	FROM Movimiento 
	WHERE IdTipoMov=10
	AND IdCuenta=@inIdCuenta
	
	-- 2: Determinar si se cumple la condicion. Si la variable 
	-- @HayMulta es nula entonces no hubo ninguna multa, de lo 
	-- contrario si hubo

	IF @HayMulta IS NOT NULL
	BEGIN
		SET @CumpleCon1=1;
	END;
	
	-- ==================== SEGUNDA CONDICION =====================

	-- 1: Obtener la ultima fecha
	
	SELECT TOP 1 @FechaFinal= Fecha
	FROM Movimiento 
	ORDER BY Id DESC

	-- 2: Determinar la fecha en la que se debe terminar
	-- de contar operaciones
	SELECT @FechaInicio = DATEADD(DAY, -@inDias, @FechaFinal);

	-- 3: Determinar la cantidad de fechas mayores
	-- a la fecha inicio en las que se hicieron 
	-- operacion en atm
	SELECT @CantOpATMHechas = COUNT(*)
	FROM Movimiento 
	WHERE IdCuenta=@inIdCuenta
	AND IdTipoMov=6
	AND Fecha > @FechaInicio
	ORDER BY 1 DESC;
	
	-- 4: Determinar la cantidad de fechas iguales 
	-- a la fecha inicio en las que se hicieron 
	-- operacion en atm
	SELECT @CantOpATMHechas2 = COUNT(*)
	FROM Movimiento 
	WHERE IdCuenta=@inIdCuenta
	AND IdTipoMov=6
	AND Fecha = @FechaInicio
	ORDER BY 1 DESC;

	-- 5: Guardar la suma de ambas cantidad en una variable
	SET @CantOpATMtotal = @CantOpATMHechas + @CantOpATMHechas2;

	-- 5: Determinar si las operaciones hechas
	-- en los ultimos N dias fueron mayor a 5
	IF 5 <= @CantOpATMtotal 
	BEGIN
		SET @CumpleCon2=1;
	END;

	-- ==================== BUSCAR INFORMACION =====================

	-- 6: Determinar si alguna de las condiciones 
	-- se cumple si es asi entonces se debe buscar
	-- la informacion necesaria

	IF @CumpleCon1 = 1 OR @CumpleCon2 = 1
	BEGIN

		-- Colocar un 1 en la variabla para que
		-- en la capa logica se sepa si hay que
		-- desplegar informacion de esta cuenta o no

		SET @outInfo = 1;

		-- 7: Determinar el promedio de 
		-- operaciones ATM por mes
		SELECT @SumaTotal = SUM(OpAtm) 
		FROM dbo.EstadoCuenta 
		WHERE IdCuenta=@inIdCuenta

		SELECT @CantOp =  COUNT(*) 
		FROM dbo.EstadoCuenta 
		WHERE IdCuenta=@inIdCuenta

		SET @outProm = @SumaTotal / @CantOp

		-- 8: Determinar el mes con mayor 
		-- cantidad de operaciones
		
		SELECT TOP 1 @outMesMasOp = DATEPART(MONTH, Fecha)
		FROM dbo.Movimiento
		WHERE IdTipoMov=6
		AND IdCuenta=@inIdCuenta
		GROUP BY DATEPART(MONTH, Fecha) 
		ORDER BY COUNT(*) DESC

		-- 9: Determinar el año con mayor 
		-- cantidad de operaciones
		
		SELECT TOP 1 @outAnoMasOp = DATEPART(YEAR, Fecha)
		FROM dbo.Movimiento
		WHERE IdTipoMov=6
		AND IdCuenta=@inIdCuenta
		GROUP BY DATEPART(YEAR, Fecha) 
		ORDER BY COUNT(*) DESC

	END ELSE
	BEGIN
	   SET @outInfo = 0;
	END;

	-- Determinar el numero de cuenta
	SELECT @outNumeroCuenta = NumeroCuenta
	FROM CuentaAhorro
	WHERE Id=@inIdCuenta;


	SET NOCOUNT OFF
END