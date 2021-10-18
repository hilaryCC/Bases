-- Se deben crear primero las tablas --

USE Proyecto -- Nombre de la base de datos a usar
GO

DECLARE @myxml XML

SET @myxml = (
			SELECT * 
				FROM OPENROWSET(BULK 'C:\Users\Administrador\Downloads\Telegram Desktop\DatosTarea-2.xml', SINGLE_BLOB)
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
INSERT INTO dbo.TipoCuentaAhorro(Id, Nombre, IdTipoMoneda, SaldoMinimo, MultaSaldoMin, CargoAnual, 
								NumRetirosHumano, NumRetirosAutomatico, ComisionHumano, ComisionAutomatico, Interes)
	SELECT
		T.X.value('@Id', 'int'),
		T.X.value('@Nombre', 'varchar(40)'),
		T.X.value('@IdTipoMoneda', 'int'),
		T.X.value('@SaldoMinimo', 'float'),
		T.X.value('@MultaSaldoMin', 'float'),
		T.X.value('@CargoAnual', 'int'),
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



-- Se agregan los catalogos --

-- Personas --
INSERT INTO dbo.Persona(TipoDocuIdentidad, Nombre, ValorDocumentoIdentidad, FechaNacimiento,
						Email, telefono1, telefono2)
	SELECT
		T.X.value('@TipoDocuIdentidad', 'int'),
		T.X.value('@Nombre', 'varchar(40)'),
		T.X.value('@ValorDocumentoIdentidad', 'int'),
		T.X.value('@FechaNacimiento', 'date'),
		T.X.value('@Email', 'varchar(40)'),
		T.X.value('@Telefono1', 'int'),
		T.X.value('@Telefono2', 'int')
	FROM @myxml.nodes('//Datos/FechaOperacion/AgregarPersona') AS T(X)

-- Cuentas --
DECLARE @Tcuentas TABLE(
	[id] [int] IDENTITY(1,1),
	[iden] [int],
	[tipoCuenta] [int],
	[numCuenta] [int],
	[fecha] [date],
	[saldo] [float]
	);

INSERT INTO @Tcuentas(iden, tipoCuenta, numCuenta, fecha, saldo)
	SELECT
		T.X.value('@ValorDocumentoIdentidadDelCliente', 'int'),
		T.X.value('@TipoCuentaId', 'int'),
		T.X.value('@NumeroCuenta', 'int'),
		T.X.value('../@Fecha', 'date'),
		T.X.value('@Saldo', 'float')
	FROM @myxml.nodes('//Datos/FechaOperacion/AgregarCuenta') AS T(X)

INSERT INTO dbo.CuentaAhorro(IdPersona, TipoCuentaId, NumeroCuenta, FechaCreacion,Saldo)
	SELECT P.Id, T.tipoCuenta, T.numCuenta, T.fecha, T.saldo 
		FROM @Tcuentas T INNER JOIN dbo.Persona P ON T.iden = P.ValorDocumentoIdentidad 

-- Beneficiarios --
DECLARE @Tbeneficiario TABLE(
	[Id] [int] IDENTITY(1,1),
	[numC] [int],
	[iden] [int],
	[parentezco] [int],
	[porcentaje] [int]
);

INSERT INTO @Tbeneficiario(numC, iden, parentezco, porcentaje)
	SELECT
		T.X.value('@NumeroCuenta', 'int'),
		T.X.value('@ValorDocumentoIdentidadBeneficiario', 'int'),
		T.X.value('@ParentezcoId', 'int'),
		T.X.value('@Porcentaje', 'int')
	FROM @myxml.nodes('//Datos/FechaOperacion/AgregarBeneficiario') AS T(X)
		

INSERT INTO dbo.Beneficiario(IdCuenta, IdPersona, ParentezcoId, Porcentaje, Activo, FechaDesactivacion)
	SELECT C.Id, P.Id, B.parentezco, B.porcentaje, 1, NULL
		FROM @Tbeneficiario B INNER JOIN dbo.CuentaAhorro C ON B.numC = C.NumeroCuenta
							INNER JOIN dbo.Persona P ON B.iden = P.ValorDocumentoIdentidad

-- Usuarios --

DECLARE @Tusuarios TABLE(
	[Id] [int] IDENTITY (1,1),
	[user] [varchar](40),
	[pass] [varchar](40),
	[iden] [int],
	[admin] [int]
);

INSERT INTO @Tusuarios([user], [pass], [iden], [admin])
	SELECT
		T.X.value('@Usuario', 'varchar(40)'),
		T.X.value('@Pass', 'varchar(40)'),
		T.X.value('@ValorDocumentoIdentidad', 'int'),
		T.X.value('@EsAdministrador', 'int')
	FROM @myxml.nodes('//Datos/Usuarios/Usuario') AS T(X)

INSERT INTO dbo.Usuario([user], [pass], IdPersona, EsAdministrador)
	SELECT U.[user], U.pass, P.Id, U.[admin] 
		FROM @Tusuarios U INNER JOIN dbo.Persona P ON U.iden = P.ValorDocumentoIdentidad

-- Usuarios ver --
DECLARE @Tusuarios_ver TABLE(
	[id][int] IDENTITY(1,1),
	[user][varchar](40),
	[numC][int]
);

INSERT INTO @Tusuarios_ver([user], [numC])
	SELECT
		T.X.value('@Usuario', 'varchar(40)'),
		T.X.value('@NumeroCuenta', 'int')
	FROM @myxml.nodes('//Datos/Usuarios_Ver/UsuarioPuedeVer') AS T(X)

INSERT INTO dbo.Usuarios_Ver(IdUser, IdCuenta)
	SELECT U.Id, C.Id 
		FROM @Tusuarios_ver Uv INNER JOIN dbo.Usuario U ON Uv.[user] = U.[User]
							INNER JOIN dbo.CuentaAhorro C ON Uv.numC = C.NumeroCuenta

-- Movimientos --
DECLARE @Movi TABLE(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[Fecha] [date],
	[Descripcion] [varchar](50),
	[IdMoneda] [int],
	[Monto] [int],
	[NumeroCuenta] [int],
	[Tipo] [int]
);

/*INSERT INTO @Movi(Fecha, Descripcion, IdMoneda, Monto, NumeroCuenta, Tipo)
	SELECT
		T.X.value('../@Fecha', 'date'),
		T.X.value('@Descripcion', 'varchar(50)'),
		T.X.value('@IdMoneda', 'int'),
		T.X.value('@Monto', 'int'),
		T.X.value('@NumeroCuenta', 'int'),
		T.X.value('@Tipo', 'int')
	FROM @myxml.nodes('//Datos/FechaOperacion/Movimientos') AS T(X)

INSERT INTO dbo.Movimiento(Fecha, IdCuenta, IdEstadoCuenta, Descripcion, 
							IdMoneda, monto, nuevoSaldo, IdTipoMov, IdTipoCambio)
	SELECT TM.Fecha, C.Id, TM.Descripcion, TM.IdMoneda, TM.Monto, C.Saldo, TM.Tipo  FROM @Movi TM 
	INNER JOIN dbo.CuentaAhorro C ON C.NumeroCuenta=TM.NumeroCuenta ORDER BY TM.Fecha

SELECT * FROM dbo.Movimiento*/
