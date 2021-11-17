-- Se deben crear primero las tablas --

USE Proyecto -- Nombre de la base de datos a usar
GO

DECLARE @myxml XML

SET @myxml = (
			SELECT * 
				FROM OPENROWSET(BULK 'C:\Users\Administrador\Downloads\Telegram Desktop\DatosTarea2-8.xml', SINGLE_BLOB)
				AS myxml
			);

-- Se agregan los tipos --

-- Tipo de documento de identidad
INSERT INTO dbo.TipoDocuIdentidad(Id, Nombre)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Nombre', 'varchar(40)')
	FROM @myxml.nodes('//Datos/Tipo_Doc/TipoDocuIdentidad') AS T(X)

-- Tipo de moneda --
INSERT INTO dbo.TipoMoneda(Id, Nombre)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Nombre', 'varchar(40)')
	FROM @myxml.nodes('//Datos/Tipo_Moneda/TipoMoneda') AS T(X)

-- Tipo de parentezo --
INSERT INTO dbo.Parentezco(Id, Nombre)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Nombre', 'varchar(40)')
	FROM @myxml.nodes('//Datos/Parentezcos/Parentezco') AS T(X)

-- Tipo de cuenta de ahorro --
INSERT INTO dbo.TipoCuentaAhorro(Id, Nombre, IdTipoMoneda, SaldoMinimo, MultaSaldoMin, CargoServicios, 
								NumRetirosHumano, NumRetirosAutomatico, ComisionHumano, ComisionAutomatico, Interes)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Nombre', 'varchar(40)'),
		T.X.value('@IdTipoMoneda', 'int'),
		T.X.value('@SaldoMinimo', 'float'),
		T.X.value('@MultaSaldoMin', 'float'),
		T.X.value('@CargoMensual', 'int'),
		T.X.value('@NumRetirosHumano', 'int'),
		T.X.value('@NumRetirosAutomatico', 'int'),
		T.X.value('@ComisionHumano', 'int'),
		T.X.value('@ComisionAutomatico', 'int'),
		T.X.value('@Interes', 'int')
	FROM @myxml.nodes('//Datos/Tipo_Cuenta_Ahorros/TipoCuentaAhorro') AS T(X)

-- Tipo Movimiento --
INSERT INTO dbo.Tipo_Movimiento(Id, Descripcion, Operacion)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Descripcion', 'varchar(50)'),
		T.X.value('@Operacion', 'int')
	FROM @myxml.nodes('//Datos/Tipo_Movimientos/TipoMovimiento') AS T(X)

-- Usuarios --
INSERT INTO dbo.Usuario([user], [pass], IdPersona, EsAdministrador)
	SELECT
		T.X.value('@Usuario', 'varchar(40)'),
		T.X.value('@Pass', 'varchar(40)'),
		P.Id,
		T.X.value('@EsAdministrador', 'int')
	FROM @myxml.nodes('//Datos/Usuarios/Usuario') AS T(X)
	INNER JOIN dbo.Persona P
		ON T.X.value('@ValorDocumentoIdentidad', 'int') = P.ValorDocumentoIdentidad

-- Usuarios ver --
INSERT INTO dbo.Usuarios_Ver(IdUser, IdCuenta)
	SELECT
		U.Id,
		C.Id
	FROM @myxml.nodes('//Datos/Usuarios_Ver/UsuarioPuedeVer') AS T(X)
	INNER JOIN dbo.Usuario U 
		ON T.X.value('@Usuario', 'varchar(40)') = U.[User]
	INNER JOIN dbo.CuentaAhorro C 
		ON T.X.value('@NumeroCuenta', 'int') = C.NumeroCuenta



-- Inicia simulacion por fechas --

-- Tablas para bajar todo del xml
DECLARE @Fechas TABLE(
	[Fecha] [date]
);

DECLARE @TipoCambio TABLE(
	[Venta] [int],
	[Compra] [int],
	[Fecha] [date]
);

DECLARE @Personas TABLE(
	[TDocu] [int],
	[Nombre] [varchar](40),
	[ValorDocu] [int],
	[Nacimiento] [date],
	[Email] [varchar](40),
	[Tel1] [int],
	[Tel2] [int],
	[Fecha] [date]
); 

DECLARE @Cuentas TABLE(
	[DocuPersona] [int],
	[TipoCuentaId] [int],
	[NumeroCuenta] [int],
	[FechaCreacion] [date],
	[Saldo] [float]
);

DECLARE @Beneficiarios TABLE(
	[NumCuenta] [int],
	[DocuPersona] [int],
	[Parentezco] [int],
	[Porcentaje] [int],
	[Fecha] [date]
);

DECLARE @Movimientos TABLE(
	[Fecha] [date],
	[Descripcion] [varchar](50),
	[IdMoneda] [int],
	[Monto] [int],
	[NumeroCuenta] [int],
	[Tipo] [int]
);

-- Tablas temporales para la simulacion diaria
DECLARE @MovimientosDia TABLE(
	[Id] [int] PRIMARY KEY IDENTITY (1,1),
	[Fecha] [date],
	[Descripcion] [varchar](50),
	[IdMoneda] [int],
	[Monto] [int],
	[NumeroCuenta] [int],
	[Tipo] [int]
);

DECLARE @CierreCuentas TABLE(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[IdCuenta] [int]
);

DECLARE @FechaActual DATE
		,@FechaFinal DATE
		,@IdMovActual INT
		,@IdMovFinal INT
		,@MovFecha DATE
		,@MovDescripcion VARCHAR (50)
		,@MovIdMoneda INT
		,@MovMonto FLOAT
		,@MovNumeroCuenta INT
		,@MovTipo INT
		,@CCIdCuenta INT
		,@IdCCActual INT
		,@IdCCFinal INT

-- Extraccion del xml a las tablas
INSERT INTO @Fechas(Fecha)
	SELECT 
		T.X.value('@Fecha', 'date')
	FROM @myxml.nodes('//Datos/FechaOperacion') AS T(X)

INSERT INTO @TipoCambio(Venta, Compra, Fecha)
	SELECT
		T.X.value('@Compra', 'int'),
		T.X.value('@Venta', 'int'),
		T.X.value('../@Fecha', 'date')
	FROM @myxml.nodes('//Datos/FechaOperacion/TipoCambioDolares') AS T(X)

INSERT INTO @Personas(TDocu, Nombre, ValorDocu, Nacimiento, Email, Tel1, Tel2, Fecha)
	SELECT
		T.X.value('@TipoDocuIdentidad', 'int'),
		T.X.value('@Nombre', 'varchar(40)'),
		T.X.value('@ValorDocumentoIdentidad', 'int'),
		T.X.value('@FechaNacimiento', 'date'),
		T.X.value('@Email', 'varchar(40)'),
		T.X.value('@Telefono1', 'int'),
		T.X.value('@Telefono2', 'int'),
		T.X.value('../@Fecha', 'date')
	FROM @myxml.nodes('//Datos/FechaOperacion/AgregarPersona') AS T(X)

INSERT INTO @Cuentas(DocuPersona, TipoCuentaId, NumeroCuenta, FechaCreacion,Saldo)
	SELECT 
		T.X.value('@ValorDocumentoIdentidadDelCliente', 'int'),
		T.X.value('@TipoCuentaId', 'int'),
		T.X.value('@NumeroCuenta', 'int'),
		T.X.value('../@Fecha', 'date'),
		T.X.value('@Saldo', 'float')
	FROM @myxml.nodes('//Datos/FechaOperacion/AgregarCuenta') AS T(X)

INSERT INTO @Beneficiarios(NumCuenta, DocuPersona, Parentezco, Porcentaje)
	SELECT
		T.X.value('@NumeroCuenta', 'int'),
		T.X.value('@ValorDocumentoIdentidadBeneficiario', 'int'),
		T.X.value('@ParentezcoId', 'int'),
		T.X.value('@Porcentaje', 'int'),
		T.X.value('../@Fecha', 'date')
	FROM @myxml.nodes('//Datos/FechaOperacion/AgregarBeneficiario') AS T(X)

INSERT INTO @Movimientos(Fecha, Descripcion, IdMoneda, Monto, NumeroCuenta, Tipo)
	SELECT
		T.X.value('../@Fecha', 'date'),
		T.X.value('@Descripcion', 'varchar(50)'),
		T.X.value('@IdMoneda', 'int'),
		T.X.value('@Monto', 'float'),
		T.X.value('@NumeroCuenta', 'int'),
		T.X.value('@Tipo', 'int')
	FROM @myxml.nodes('//Datos/FechaOperacion/Movimientos') AS T(X)

-- Inicia recorrido por dia --
SELECT @FechaActual = MIN(Fecha)
		,@FechaFinal = MAX(Fecha) 
FROM @Fechas

WHILE (@FechaActual <= @FechaFinal)
BEGIN

	-- Se agrega el tipo de cambio --
	INSERT INTO dbo.TipoCambio(IdMoneda1, IdMoneda2, ValorCompra, ValorVenta, Fecha)
		SELECT 
			2, 
			1,
			TC.Compra,
			TC.Venta,
			TC.Fecha
		FROM @TipoCambio TC 
		WHERE TC.Fecha = @FechaActual

	-- Se agregan las personas del dia --
	INSERT INTO dbo.Persona(TipoDocuIdentidad, Nombre, ValorDocumentoIdentidad, FechaNacimiento,
						Email, telefono1, telefono2)
		SELECT
			P.TDocu,
			P.Nombre,
			P.ValorDocu,
			P.Nacimiento,
			P.Email,
			P.Tel1,
			P.Tel2
		FROM @Personas P
		WHERE P.Fecha = @FechaActual

	-- Se agregan las cuentas del dia --
	INSERT INTO dbo.CuentaAhorro(IdPersona, TipoCuentaId, NumeroCuenta, FechaCreacion,Saldo)
		SELECT 
			P.Id,
			C.TipoCuentaId,
			C.NumeroCuenta,
			C.FechaCreacion,
			C.Saldo
		FROM @Cuentas C
		INNER JOIN dbo.Persona P 
			ON C.DocuPersona = P.ValorDocumentoIdentidad
		WHERE C.FechaCreacion = @FechaActual

	-- Se agregan los beneficiarios del dia -- 
	INSERT INTO dbo.Beneficiario(IdCuenta, IdPersona, ParentezcoId, Porcentaje, Activo, FechaDesactivacion)
		SELECT
			C.Id,
			P.Id,
			B.Parentezco,
			B.Porcentaje,
			1,
			NULL
		FROM @Beneficiarios B
		INNER JOIN dbo.CuentaAhorro C 
			ON B.NumCuenta = C.NumeroCuenta
		INNER JOIN dbo.Persona P
			ON B.DocuPersona = P.ValorDocumentoIdentidad
		WHERE B.Fecha = @FechaActual

	-- Movimientos del dia --
	INSERT INTO @MovimientosDia(Fecha, Descripcion, IdMoneda, Monto, NumeroCuenta, Tipo)
		SELECT
			M.Fecha,
			M.Descripcion,
			M.IdMoneda,
			M.Monto,
			M.NumeroCuenta,
			M.Tipo
		FROM @Movimientos M
		WHERE M.Fecha = @FechaActual

	SELECT @IdMovActual = MIN(Id)
		   ,@IdMovFinal = MAX(Id) 
	FROM @MovimientosDia

	WHILE(@IdMovActual <= @IdMovFinal)
	BEGIN
		SELECT @MovFecha = M.Fecha
			   ,@MovDescripcion = M.Descripcion
			   ,@MovIdMoneda = M.IdMoneda
			   ,@MovMonto = M.Monto
			   ,@MovNumeroCuenta = M.NumeroCuenta
			   ,@MovTipo = M.Tipo
		FROM @MovimientosDia M
		WHERE M.Id = @IdMovActual

		EXEC dbo.InsertarMov @MovFecha
						,@MovDescripcion
						,@MovIdMoneda
						,@MovMonto
						,@MovNumeroCuenta
						,@MovTipo 

		SET @IdMovActual = @IdMovActual + 1
	END

	DELETE @MovimientosDia
	 
	-- Cerrar estados de Cuenta -- 
	INSERT INTO @CierreCuentas(IdCuenta)
	SELECT C.Id FROM dbo.CuentaAhorro C
	WHERE (C.FechaCreacion < @FechaActual)
		AND (DAY(C.FechaCreacion) = DAY(@FechaActual))

	SELECT @IdCCActual = MIN(Id)
		   ,@IdCCFinal = MAX(Id)
	FROM @CierreCuentas

	WHILE(@IdCCActual <= @IdCCFinal)
	BEGIN
		SELECT @CCIdCuenta = CC.IdCuenta
		FROM @CierreCuentas CC

		EXEC dbo.CerrarEC @CCIdCuenta, @FechaActual

		SET @IdCCActual = @IdCCActual + 1
	END

	DELETE @CierreCuentas

	SET @FechaActual = DATEADD(DAY, 1, @FechaActual)
END

SELECT * FROM dbo.EstadoCuenta
