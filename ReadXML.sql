-- Se deben crear primero las tablas --

USE Proyecto1 -- Noombre de la base de datos a usar
GO

DECLARE @myxml XML

SET @myxml = (
			SELECT * 
				FROM OPENROWSET(BULK 'C:\Users\vchin\OneDrive\TEC\II semestre 2021\BD 1\Proyecto1\DatosTarea-1- V2.1.xml', SINGLE_BLOB)
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
	FROM @myxml.nodes('//Datos/Personas/Persona') AS T(X)

-- Cuentas --
DECLARE @Tcuentas TABLE(
	[id] [int] IDENTITY(1,1),
	[iden] [int],
	[tipoCuenta] [int],
	[numCuenta] [int],
	[fecha] [date],
	[saldo] [float]
	);
DECLARE	@iden INT,
		@tipoC INT,
		@numC INT,
		@fecha DATE,
		@saldo FLOAT,
		@tamanno INT,
		@Ididen INT,
		@actual INT

INSERT INTO @Tcuentas(iden, tipoCuenta, numCuenta, fecha, saldo)
	SELECT
		T.X.value('@ValorDocumentoIdentidadDelCliente', 'int'),
		T.X.value('@TipoCuentaId', 'int'),
		T.X.value('@NumeroCuenta', 'int'),
		T.X.value('@FechaCreacion', 'date'),
		T.X.value('@Saldo', 'float')
	FROM @myxml.nodes('//Datos/Cuentas/Cuenta') AS T(X)

SET @tamanno = (SELECT COUNT(*) FROM @Tcuentas)

WHILE (@tamanno > 0)
BEGIN
	SET @iden = (SELECT TOP(1) [iden] FROM @Tcuentas)
	SET @tipoC = (SELECT TOP(1) [tipoCuenta] FROM @Tcuentas)
	SET @numC = (SELECT TOP(1) [numCuenta] FROM @Tcuentas)
	SET @fecha = (SELECT TOP(1) [fecha] FROM @Tcuentas)
	SET @saldo = (SELECT TOP(1) [saldo] FROM @Tcuentas)
	SET @Ididen = (SELECT [Id] FROM dbo.Persona WHERE ValorDocumentoIdentidad=@iden)
	SET @actual = (SELECT TOP(1) [id] FROM @Tcuentas)

	IF (@Ididen) IS NOT NULL
		INSERT INTO dbo.CuentaAhorro(IdPersona, TipoCuentaId, NumeroCuenta, FechaCreacion, Saldo)
			VALUES (@Ididen, @tipoC, @numC, @fecha, @saldo)
	
	ELSE
		BEGIN
			INSERT INTO dbo.Persona(TipoDocuIdentidad, Nombre, ValorDocumentoIdentidad,
									FechaNacimiento,Email,telefono1,telefono2)
				VALUES (1, 'No conocido', @iden, '1900-01-01', 'na@na.com', '00000000', '00000000')

			SET @Ididen = (SELECT [Id] FROM dbo.Persona WHERE ValorDocumentoIdentidad=@iden)

			INSERT INTO dbo.CuentaAhorro(IdPersona, TipoCuentaId, NumeroCuenta, FechaCreacion, Saldo)
				VALUES (@Ididen, @tipoC, @numC, @fecha, @saldo)
		END

	DELETE @Tcuentas WHERE id=@actual
	SET @tamanno = @tamanno-1
END

/* Quitar comentario para ver:
		1. Cuentas sin una persona asociada (en caso de haber añadido todas las cuentas)
		2. Personas en la base de datos sin cuenta
		3. Cuentas con una persona asociada*/

/*SELECT * FROM dbo.CuentaAhorro A FULL OUTER JOIN dbo.Persona B 
							ON A.IdPersona = B.Id ORDER BY A.IdPersona*/ 

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
	FROM @myxml.nodes('//Datos/Beneficiarios/Beneficiario') AS T(X)
		

DECLARE @parentezco INT,
		@porcentaje INT,
		@IdCuenta INT

SET @tamanno = (SELECT COUNT(*) FROM @Tbeneficiario)

WHILE (@tamanno > 0)
BEGIN
	SET @iden = (SELECT TOP(1) [iden] FROM @Tbeneficiario)
	SET @porcentaje = (SELECT TOP(1) [porcentaje] FROM @Tbeneficiario)
	SET @numC = (SELECT TOP(1) [numC] FROM @Tbeneficiario)
	SET @parentezco = (SELECT TOP(1) [parentezco] FROM @Tbeneficiario)
	SET @actual = (SELECT TOP(1) [Id] FROM @Tbeneficiario)
	SET @Ididen = (SELECT [Id] FROM dbo.Persona WHERE ValorDocumentoIdentidad=@iden)
	SET @IdCuenta = (SELECT [Id] FROM dbo.CuentaAhorro WHERE NumeroCuenta=@numC)

	IF(@Ididen IS NOT NULL) AND (@IdCuenta IS NOT NULL) 
		INSERT INTO dbo.Beneficiario(IdCuenta, IdPersona, ParentezcoId, Porcentaje, Activo)
						VALUES(@IdCuenta, @Ididen, @parentezco, @porcentaje, 1)

	DELETE @Tbeneficiario WHERE Id=@actual
	SET @tamanno = @tamanno-1
END

-- Usuarios --

DECLARE @Tusuarios TABLE(
	[Id] [int] IDENTITY (1,1),
	[user] [varchar](40),
	[pass] [varchar](40),
	[iden] [int],
	[admin] [int]
);

DECLARE @user VARCHAR(40),
	@pass VARCHAR(40), 
	@admin INT

INSERT INTO @Tusuarios([user], [pass], [iden], [admin])
	SELECT
		T.X.value('@Usuario', 'varchar(40)'),
		T.X.value('@Pass', 'varchar(40)'),
		T.X.value('@ValorDocumentoIdentidad', 'int'),
		T.X.value('@EsAdministrador', 'int')
	FROM @myxml.nodes('//Datos/Usuarios/Usuario') AS T(X)

SET @tamanno = (SELECT COUNT(*) FROM @Tusuarios)

WHILE (@tamanno > 0)
BEGIN
	SET @actual = (SELECT TOP(1) [Id] FROM @Tusuarios)
	SET @user = (SELECT TOP(1) [user] FROM @Tusuarios)
	SET @pass = (SELECT TOP(1) [pass] FROM @Tusuarios)
	SET @iden = (SELECT TOP(1) [iden] FROM @Tusuarios)
	SET @admin = (SELECT TOP(1) [admin] FROM @Tusuarios)
	SET @Ididen = (SELECT [Id] FROM dbo.Persona WHERE ValorDocumentoIdentidad=@iden)

	IF(@Ididen) IS NOT NULL
		INSERT INTO dbo.Usuario VALUES(@user, @pass, @Ididen, @admin)

	DELETE @Tusuarios WHERE Id=@actual
	SET @tamanno = @tamanno-1
END

-- Usuarios ver --
DECLARE @Tusuarios_ver TABLE(
	[id][int] IDENTITY(1,1),
	[user][varchar](40),
	[numC][int]
);

DECLARE @iduser INT

INSERT INTO @Tusuarios_ver([user], [numC])
	SELECT
		T.X.value('@Usuario', 'varchar(40)'),
		T.X.value('@NumeroCuenta', 'int')
	FROM @myxml.nodes('//Datos/Usuarios_Ver/UsuarioPuedeVer') AS T(X)

SET @tamanno = (SELECT COUNT(*) FROM @Tusuarios_ver)

WHILE(@tamanno > 0)
BEGIN
	SET @actual = (SELECT TOP(1) [id] FROM @Tusuarios_ver)
	SET @user = (SELECT TOP(1) [user] FROM @Tusuarios_ver)
	SET @numC = (SELECT TOP(1) [numC] FROM @Tusuarios_ver)
	SET @iduser = (SELECT TOP(1) [Id] FROM dbo.Usuario WHERE [User]=@user)
	SET @IdCuenta = (SELECT TOP(1) [Id] FROM dbo.CuentaAhorro WHERE [NumeroCuenta]=@numC)

	IF (@iduser IS NOT NULL) AND (@IdCuenta IS NOT NULL)
		INSERT INTO dbo.Usuarios_Ver(IdUser, IdCuenta) 
			VALUES(@iduser, @IdCuenta)

	DELETE @Tusuarios_ver WHERE id=@actual
	SET @tamanno = @tamanno-1
END

/*SELECT * FROM dbo.Persona P FULL OUTER JOIN dbo.Usuario U ON P.Id=U.IdPersona
			FULL OUTER JOIN dbo.CuentaAhorro C ON P.Id=C.IdPersona 
				FULL OUTER JOIN dbo.Beneficiario B ON P.Id=B.IdPersona
					ORDER BY P.Id*/
-- Quitar comentarios para ver la tabla completa de Personas con cuenta o usuario asociado o si es benficiario
-- Osea la combinacion de dbo.Persona, dbo.Usuario, dbo.CuentaAhorro y dbo.Beneficiario