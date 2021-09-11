USE PXml -- Nombre de la base de datos a usar
GO
-- En caso de que las tablas ya existan se eliminan --
------------------------------------------------------
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

IF OBJECT_ID('Moneda') IS NOT NULL
	DROP TABLE Moneda;

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

CREATE TABLE Moneda(
	[Id] [int] PRIMARY KEY,
	[Nombre] [varchar](40)
	FOREIGN KEY (Id) REFERENCES TipoMoneda(Id)
)

CREATE TABLE TipoCuentaAhorro(
	[Id] [int] PRIMARY KEY,
	[Nombre] [varchar](40),
	[IdTipoMoneda] [int],
	[SaldoMinimo] [float], 
	[MultaSaldoMin] [float],
	[CargoAnual] [int], 
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
	[Saldo] [float],
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

/*
select * from Persona
select * from TipoDocuIdentidad
drop table TipoDocuIdentidad


insert into TipoDocuIdentidad
(Id, Nombre) values ('1', 'Cedula Nacional');
insert into TipoDocuIdentidad
(Id, Nombre) values ('2', 'Cedula Residente');
insert into [dbo].[Persona] 

(Nombre, Email, telefono1, TipoDocuIdentidad) values ('Valeria', 'vchinchilla02@hotmail.com', 64596768, 2);
insert into [dbo].[Persona] 
(Nombre, Email, telefono1, TipoDocuIdentidad) values ('Valeria2', 'vchinchilla02@hotmail.com', 64596768, 2);
insert into [dbo].[Persona] 
(Nombre, Email, telefono1, TipoDocuIdentidad) values ('Valeria3', 'vchinchilla02@hotmail.com', 64596768, 2);
*/