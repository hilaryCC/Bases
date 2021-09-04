CREATE TABLE TipoDocuIdentidad(
	[Id] [int] PRIMARY KEY,
	[Nombre] [varchar] (40)
)

CREATE TABLE Persona(
	[Id] [int] PRIMARY KEY IDENTITY(1,1),
	[TipoDocuIdentidad] [int],
	[Nombre] [varchar](40),
	[ValorDocumentoIdentidad] [varchar](64),
	[FechaNacimiento] [date], 
	[Email] [varchar](40),
	[telefono1] [int],
	[telefono2] [int],
    FOREIGN KEY (TipoDocuIdentidad) REFERENCES TipoDocuIdentidad(Id)
)

CREATE TABLE Moneda(
	[Id] [int] PRIMARY KEY,
	[Nombre] [varchar](40)
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
	FOREIGN KEY (IdTipoMoneda) REFERENCES Moneda(Id)
)

CREATE TABLE CuentaAhorro(
	[Id] [int] PRIMARY KEY,
	[ValorDocumentoIdentidadDelCliente] [varchar](64),
	[TipoCuentaId] [int],
	[NumeroCuenta] [int],
	[FechaCreacion] [date],
	[Saldo] [int]
	FOREIGN KEY (TipoCuentaId) REFERENCES TipoCuentaAhorro(Id)
)

CREATE TABLE 
/*
select * from Persona
select * from TipoDocuIdentidad
drop table TipoDocuIdentidad
drop table Persona

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