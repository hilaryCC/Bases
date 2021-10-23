USE Proyecto1
GO
CREATE PROCEDURE ConsultaFilaCEC
	@inCont INT
	, @inIdEC INT
	, @outId INT OUTPUT
	, @outFecha VARCHAR(40) OUTPUT
	, @outMontoM FLOAT OUTPUT
	, @outMontoC FLOAT OUTPUT
	, @outTipoC INT OUTPUT
	, @outDescripcion VARCHAR(40) OUTPUT
	, @outNuevoSaldo FLOAT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	DECLARE @IdTipoCambio INT,
	        @IdMonedaMov INT,
			@IdCuenta INT, 
			@IdMonedaCA INT;

	-- Obtener la fecha y el monto en la moneda del movimiento
	SELECT @outId = Id, @outFecha = Fecha, 
		   @outMontoM = monto, 
	       @outMontoC = MontoCambioAplicado, 
		   @outDescripcion = Descripcion,
		   @outNuevoSaldo = nuevoSaldo,
		   @IdTipoCambio = IdTipoCambio, 
		   @IdMonedaMov = IdMoneda,
		   @IdCuenta = IdCuenta
	FROM Movimiento 
	WHERE IdEstadoCuenta=@inIdEC 
	ORDER BY Fecha 
	OFFSET @inCont ROWS
	FETCH NEXT 1 ROW ONLY;

	-- Obtener el tipo de cambio	-- Obtener el Id de la moneda de la cuenta	SELECT @IdMonedaCA = IdTipoMoneda 
	FROM dbo.TipoCuentaAhorro TCA 
	WHERE TCA.Id = (SELECT TipoCuentaId 
					FROM dbo.CuentaAhorro C 
					WHERE C.Id = @IdCuenta)	-- Determinar si hay que mostrar el tipo de cambio
	IF @IdMonedaMov != @IdMonedaCA
	BEGIN
		-- Movimiento en colones, cuenta en dolares
		 IF (@IdMonedaMov = 1) AND (@IdMonedaCA = 2)
		 BEGIN
			SET @outTipoC = (SELECT ValorCompra 
							FROM dbo.TipoCambio T 
							WHERE T.Id = @IdTipoCambio)
		 END;
		 --Movimiento en dolares, cuenta en colones
		 IF (@IdMonedaMov = 2) AND (@IdMonedaCA = 1)
		 BEGIN
			SET @outTipoC = (SELECT ValorVenta 
							FROM dbo.TipoCambio T 
							WHERE T.Id = @IdTipoCambio)
		 END;
	END; 
	ELSE
	BEGIN
		SET @outTipoC = 0
	END;
	SET NOCOUNT OFF
END