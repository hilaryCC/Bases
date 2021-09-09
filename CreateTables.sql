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
	[SaldoMinimo] [int], 
	[MultaSaldoMin] [int],
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
	[Saldo] [int],
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
	[Pass] [int],
	[EsAdministrador] [int]
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