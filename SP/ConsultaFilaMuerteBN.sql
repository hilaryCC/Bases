USE Proyecto
GO

CREATE PROCEDURE ConsultaFilaMuerteBN
	@inId INT
	, @outNombre VARCHAR(40) OUTPUT
	, @outIdentificacion VARCHAR(40) OUTPUT
	, @outMonto FLOAT OUTPUT
	, @outMayorCA VARCHAR(40) OUTPUT
	, @outCantCA INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON

	-- Declaracion de datos		
	DECLARE @IdPersona INT
		  , @CantFilasBN INT
		  , @Contador INT = 0
		  , @IdCuenta INT
		  , @Porcentaje INT
		  , @IdCuentaMax INT
		  , @Saldo FLOAT
		  , @MontoParcial FLOAT
		  , @MontoMax FLOAT
		  , @Monto FLOAT=0;
	
	-- Tabla que contiene todos
	-- los montos obtenidos de 
	-- las distintas cuentas
	DECLARE @Montos TABLE(
		[IdCuenta] [int],
		[MontoOb] [float]
	);

	-- 1: Determinar el id persona del beneficiario 
	-- para determinar la cantidad de cuentas de las
	-- cuales es parte

	SELECT @IdPersona = IdPersona 
	FROM Beneficiario 
	WHERE Id=@inId;

	-- Determinar el nombres y la identificacion
	-- de la persona
	SELECT @outNombre = Nombre
		 , @outIdentificacion = ValorDocumentoIdentidad
	FROM Persona
	WHERE Id = @IdPersona;

	-- 2: Determinar cantidad de cuentas
	-- de las cuales la persona es
	-- beneficiario

	SELECT @CantFilasBN = COUNT(*) 
	FROM Beneficiario B 
	INNER JOIN dbo.Persona P ON B.IdPersona=P.Id 
	WHERE B.IdPersona=@IdPersona;

	-- 3: Guardar este valor en el
	-- output 
	SET @outCantCA = @CantFilasBN;

	-- 4: Iterar por la tabla Beneficiario
	-- para aumentar el monto

	WHILE @Contador <= @CantFilasBN - 1
	BEGIN
		-- 5: Seleccionar el Id de la 
		-- cuenta y el porcentaje
		-- actual

		SELECT @IdCuenta = IdCuenta
		, @Porcentaje = Porcentaje
		FROM Beneficiario B 
		INNER JOIN dbo.Persona P 
		ON B.IdPersona=P.Id 
		WHERE B.IdPersona=@IdPersona
		ORDER BY B.Id 
		OFFSET @Contador ROWS
		FETCH NEXT 1 ROW ONLY;

		-- 6: Seleccionar el monto 
		-- de la cuenta actual

		SELECT @Saldo = Saldo 
		FROM CuentaAhorro
		WHERE Id= @IdCuenta;
	
		-- 7: Determinar la cantidad 
		-- del saldo que le pertenece
		-- al beneficiario

		SET @MontoParcial = (@Saldo * @Porcentaje) / 100

		-- 8: Agregarlo al monto total
		SET @Monto += @MontoParcial
		
		-- 9: Aumentar contador
		SET @Contador = @Contador + 1

		-- 10: Agregar el monto de la
		-- cuenta a la tabla temporal
		
		INSERT INTO @Montos (IdCuenta, MontoOb)
		VALUES (@IdCuenta, @MontoParcial)
	
	END;
	
	-- 11: Obtener el monto maximo
	-- de las cuentas de las que
	-- se recibio dinero
	
	SELECT @MontoMax = MAX(MontoOb)
	FROM @Montos;

	-- 12: Obtener el id de la cuenta 
	-- del maximo monto recibido

	SELECT @IdCuentaMax = IdCuenta
	FROM @Montos
	WHERE MontoOb = @MontoMax;

	-- 13: Obtener el numero de cuenta
	-- segun el id

	SELECT @outMayorCA = NumeroCuenta
	FROM CuentaAhorro
	WHERE Id = @IdCuentaMax;

	-- 14: Guardar el monto en el
	-- parametro de salida
	SET @outMonto = @Monto;

	SET NOCOUNT OFF
END