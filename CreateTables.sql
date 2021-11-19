USE Proyecto -- Nombre de la base de datos a usar
GO
-- En caso de que las tablas ya existan se eliminan --
------------------------------------------------------
IF OBJECT_ID('MovimientosCO') IS NOT NULL
	DROP TABLE MovimientosCO;

IF OBJECT_ID('MovimientosInteresCO') IS NOT NULL
	DROP TABLE MovimientosInteresCO;

IF OBJECT_ID('TipoMovCOInt') IS NOT NULL
	DROP TABLE TipoMovCOInt;

IF OBJECT_ID('TipoMovCO') IS NOT NULL
	DROP TABLE TipoMovCO;

IF OBJECT_ID('Eventos') IS NOT NULL
	DROP TABLE Eventos;

IF OBJECT_ID('TipoEvento') IS NOT NULL
	DROP TABLE TipoEvento;

IF OBJECT_ID('CuentaObjetivo') IS NOT NULL
	DROP TABLE CuentaObjetivo;

IF OBJECT_ID('TasaInteres') IS NOT NULL
	DROP TABLE TasaInteres;

IF OBJECT_ID('Movimiento') IS NOT NULL
	DROP TABLE Movimiento;

IF OBJECT_ID('EstadoCuenta') IS NOT NULL
	DROP TABLE EstadoCuenta;

IF OBJECT_ID('Tipo_Movimiento') IS NOT NULL
	DROP TABLE Tipo_Movimiento;

IF OBJECT_ID('Beneficiario') IS NOT NULL
	DROP TABLE Beneficiario;

IF OBJECT_ID('Parentezco') IS NOT NULL
	DROP TABLE Parentezco;

IF OBJECT_ID('Usuarios_Ver') IS NOT NULL
	DROP TABLE Usuarios_Ver;

IF OBJECT_ID('Usuario') IS NOT NULL
	DROP TABLE Usuario;

IF OBJECT_ID('CuentaAhorro') IS NOT NULL
	DROP TABLE CuentaAhorro;

IF OBJECT_ID('Persona') IS NOT NULL
	DROP TABLE Persona;

IF OBJECT_ID('TipoCuentaAhorro') IS NOT NULL
	DROP TABLE TipoCuentaAhorro;

IF OBJECT_ID('TipoDocuIdentidad') IS NOT NULL
	DROP TABLE TipoDocuIdentidad;

IF OBJECT_ID('TipoCambio') IS NOT NULL
	DROP TABLE TipoCambio;

IF OBJECT_ID('TipoMoneda') IS NOT NULL
	DROP TABLE TipoMoneda;

------------------------------------------------------
------------------------------------------------------
-- Creacion de tablas --

CREATE TABLE TipoDocuIdentidad(
	[Id] [int] PRIMARY KEY,
	[Nombre] [varchar] (40)
)

CREATE TABLE Persona(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[TipoDocuIdentidad] [int],
	[Nombre] [varchar](40),
	[ValorDocumentoIdentidad] [int],
	[FechaNacimiento] [date], 
	[Email] [varchar](40),
	[telefono1] [int],
	[telefono2] [int],
	UNIQUE(ValorDocumentoIdentidad),
    FOREIGN KEY (TipoDocuIdentidad) REFERENCES TipoDocuIdentidad(Id)
)

CREATE TABLE TipoMoneda(
	[Id] [int] PRIMARY KEY,
	[Nombre] [varchar](40),
	[Simbolo] [varchar](1)
)

CREATE TABLE TipoCuentaAhorro(
	[Id] [int] PRIMARY KEY,
	[Nombre] [varchar](40),
	[IdTipoMoneda] [int],
	[SaldoMinimo] [money], 
	[MultaSaldoMin] [money],
	[CargoServicios] [int], 
	[NumRetirosHumano] [int], 
	[NumRetirosAutomatico] [int], 
	[ComisionHumano] [int],
	[ComisionAutomatico] [int],
	[Interes] [int]
	FOREIGN KEY (IdTipoMoneda) REFERENCES TipoMoneda(Id)
)

CREATE TABLE CuentaAhorro(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[IdPersona] [int],
	[TipoCuentaId] [int],
	[NumeroCuenta] [int],
	[FechaCreacion] [date],
	[Saldo] [money],
	UNIQUE(NumeroCuenta),
	FOREIGN KEY (TipoCuentaId) REFERENCES TipoCuentaAhorro(Id),
	FOREIGN KEY (IdPersona) REFERENCES Persona(Id) 
)

CREATE TABLE Parentezco(
	[Id] [int] PRIMARY KEY,
	[Nombre] [varchar](40)
)

CREATE TABLE Beneficiario(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[IdCuenta] [int],
	[IdPersona] [int],
	[ParentezcoId] [int],
	[Porcentaje] [int],
	[Activo] [bit], --BIT se usa como un booleano (1 True, 0 False)
	[FechaDesactivacion] [date],
	FOREIGN KEY (ParentezcoId) REFERENCES Parentezco(Id),
	FOREIGN KEY (IdCuenta) REFERENCES CuentaAhorro(Id), 
	FOREIGN KEY (IdPersona) REFERENCES Persona(Id)
)

CREATE TABLE Usuario(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[User] [varchar](40),
	[Pass] [varchar](40),
	[IdPersona] [int],
	[EsAdministrador] [int]
	FOREIGN KEY (IdPersona) REFERENCES Persona(Id)
)

CREATE TABLE Usuarios_Ver(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[IdUser] [int],
	[IdCuenta][int],
	FOREIGN KEY (IdCuenta) REFERENCES CuentaAhorro(Id), 
	FOREIGN KEY (IdUser) REFERENCES Usuario(Id)
)

CREATE TABLE Tipo_Movimiento(
	[Id] [int] PRIMARY KEY,
	[Descripcion] [varchar](50),
	[Operacion] [int]
)

CREATE TABLE EstadoCuenta(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[FechaInicio] [date],
	[FechaFin] [date],
	[SaldoInicial] [money],
	[SaldoFinal] [money],
	[IdCuenta] [int],
	[OpATM] [int],
	[OpVentana] [int],
	[SaldoMin] [money],
	[Activo] [bit]
	FOREIGN KEY (IdCuenta) REFERENCES CuentaAhorro(Id)
)

CREATE TABLE TipoCambio(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[IdMoneda1] [int],
	[IdMoneda2] [int],
	[ValorCompra] [int],
	[ValorVenta] [int],
	[Fecha] [date]
	FOREIGN KEY (IdMoneda1) REFERENCES TipoMoneda(Id),
	FOREIGN KEY (IdMoneda2) REFERENCES TipoMoneda(Id)
)

CREATE TABLE Movimiento(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[Fecha] [date],
	[IdCuenta] [int],
	[IdEstadoCuenta] [int],
	[Descripcion][varchar](50),
	[IdMoneda] [int],
	[monto] [money],
	[MontoCambioAplicado] [money],
	[nuevoSaldo] [money],
	[IdTipoMov][int],
	[IdTipoCambio] [int]
	FOREIGN KEY (IdCuenta) REFERENCES CuentaAhorro(Id), 
	FOREIGN KEY (IdMoneda) REFERENCES TipoMoneda(Id),
	FOREIGN KEY (IdTipoMov) REFERENCES Tipo_Movimiento(Id),
	FOREIGN KEY (IdEstadoCuenta) REFERENCES EstadoCuenta(Id),
	FOREIGN KEY (IdTipoCambio) REFERENCES TipoCambio(Id)
)

CREATE TABLE TasaInteres(
	[Id] [int] PRIMARY KEY,
	[Tasa] [float]
)

CREATE TABLE CuentaObjetivo(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[IdCuenta] [int],
	[NumeroCO] [int],
	[Cuota] [int],
	[FechaInicio] [date],
	[FechaFinal] [date],
	[DiaAhorro] [int],
	[Objetivo] [varchar](50),
	[Saldo] [money],
	[IdTasaInteres] [int],
	[InteresAcumulado] [money],
	[Activo] [bit]
	FOREIGN KEY (IdCuenta) REFERENCES CuentaAhorro(Id),
	FOREIGN KEY (IdTasaInteres) REFERENCES TasaInteres(Id)
)

CREATE TABLE MovimientosInteresCO(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[IdCuentaOb][int],
	[Descripcion] [varchar](50),
	[Fecha] [date],
	[Monto][money],
	[NuevoInteresAcumulado][money]
	FOREIGN KEY (IdCuentaOb) REFERENCES CuentaObjetivo(Id)
)

CREATE TABLE TipoMovCO(
	[Id] [int] PRIMARY KEY,
	[NombreMov] [varchar](50),
	[Operacion] [int]
)

CREATE TABLE MovimientosCO(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[IdCuentaOb][int],
	[IdTipoMov][int],
	[Descripcion] [varchar](50),
	[Fecha] [date],
	[Monto][money],
	[NuevoSaldo][money]
	FOREIGN KEY (IdCuentaOb) REFERENCES CuentaObjetivo(Id),
	FOREIGN KEY (IdTipoMov) REFERENCES TipoMovCO(Id)
)

CREATE TABLE TipoEvento(
	[Id] [int] PRIMARY KEY,
	[Nombre] [varchar](50)
)

CREATE TABLE Eventos(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[IdTipoEvento][int],
	[IdUser] [int],
	[IP][int],
	[Fecha][date],
	[XMLAntes][varchar](60),
	[XMLDespues][varchar](60)
	FOREIGN KEY (IdTipoEvento) REFERENCES TipoEvento(Id),
	FOREIGN KEY (IdUser) REFERENCES Usuario(Id)
)