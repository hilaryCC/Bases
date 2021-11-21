USE Proyecto1
GO
CREATE PROCEDURE ConsultaAdmin2
	@inIdCuenta INT,
	@inDias INT,
	@outInfo INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	
	DECLARE @TipoCuentaId INT
	      , @CantOpATMHechas INT
		  , @CantOpATMHechas2 INT=0
	      , @CantOpPermitidas INT
	      , @CumpleCon1 BIT=0
		  , @CumpleCon2 BIT=0
		  , @FechaFinal DATE
		  , @FechaInicio DATE
		  , @FechaActual DATE
		  , @Contador INT=1
		  , @HuboOpATM INT=0
		  , @MesMasOp INT
		  , @AnoMasOp INT;

	-- ==================== PRIMERA CONDICION =====================

	-- 1: Determinar la cantidad de operaciones que puede hacer

	-- Determinar el tipo de cuenta
	SELECT @TipoCuentaId = TipoCuentaId 
	FROM CuentaAhorro
	WHERE Id=@inIdCuenta;

	-- Determinar cuantas operaciones en ATM puede hacer segun el tipo de cuenta
	SELECT @CantOpPermitidas = NumRetirosAutomatico 
	FROM TipoCuentaAhorro
	WHERE Id=@TipoCuentaId;

	-- 2: Determinar la cantidad de operaciones totales en atm que hizo

	SELECT @CantOpATMHechas = COUNT(*)
	FROM dbo.Movimiento
	WHERE IdTipoMov=10
	AND IdCuenta=@inIdCuenta;

	-- 3: Determinar si se cumple la condicion

	IF @CantOpATMHechas > @CantOpPermitidas
	BEGIN
		SET @CumpleCon1=1;
	END;

	-- ==================== SEGUNDA CONDICION =====================

	-- 1: Obtener la ultima fecha
	
	SELECT TOP 1 @FechaFinal= Fecha 
	FROM Movimiento 
	ORDER BY Id DESC

	-- 2: Guardar la fecha final en la variable
	-- fecha actual, la cual va a ayudar a determinar
	-- cuando se debe parar el ciclo
	
	SET @FechaActual=@FechaFinal

	-- 3: Determinar la fecha en la que se debe terminar
	-- de contar operaciones

	SELECT @FechaInicio = DATEADD(DAY, -@inDias, @FechaFinal);

	-- 4: Recorrer la tabla de movimientos en los que 
	-- el id sea el de la cuenta actual y en el que el
	-- tipo de movimiento sea una operacion ATM para poder
	-- determinar cuantas operaciones se hicieron en los 
	-- ultimos N dias
	
	WHILE @Contador <= @inDias
	BEGIN

		-- Determinar si se hizo un movimiento en esta fecha

		SELECT @HuboOpATM = Id
		FROM dbo.Movimiento
		WHERE IdTipoMov=10
		AND IdCuenta=@inIdCuenta
		AND Fecha=@FechaActual;

		-- Si la varible es diferente de 0, entonces 
		-- se hizo una operacion ATM este dia

		IF @HuboOpATM != 0 
		BEGIN
			SET @CantOpATMHechas2 += 1;
		END

		-- Se coloca la nueva fecha actual (un dia antes)

		SET @FechaActual = DATEADD(DAY, -1, @FechaActual);
		SET @Contador += 1;
	END

	-- 5: Determinar si las operaciones hechas
	-- en los ultimos N dias fueron mayor a 5

	IF 5 <= @CantOpATMHechas2 
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


		-- 8: Determinar el mes con mayor 
		-- cantidad de operaciones
		
		SELECT TOP 1 @MesMasOp = DATEPART(MONTH, Fecha)
		FROM dbo.Movimiento
		WHERE IdTipoMov=10
		AND IdCuenta=@inIdCuenta
		GROUP BY DATEPART(MONTH, Fecha) 
		ORDER BY COUNT(*) DESC
		
		-- 9: Determinar el año con mayor 
		-- cantidad de operaciones
		
		SELECT TOP 1 @AnoMasOp = DATEPART(YEAR, Fecha)
		FROM dbo.Movimiento
		WHERE IdTipoMov=10
		AND IdCuenta=@inIdCuenta
		GROUP BY DATEPART(YEAR, Fecha) 
		ORDER BY COUNT(*) DESC



	END ELSE
	BEGIN
	   SET @outInfo = 0;
	END;

	SET NOCOUNT OFF
END