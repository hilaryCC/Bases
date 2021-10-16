-- SP para consulta de una fila de la tabla Beneficiario
-- Entrada: 
--	+ Id de la cuenta
-- Salida:
--	+ Id del beneficiario
--	+ Nombre de la cuenta
--	+ Valor identidad de la persona
--	+ Fecha Nacimiento de la persona
--	+ Telefono 1 de la persona
--	+ Telefono 2 de la persona
--	+ Nombre del parentezco
--	+ Porcentaje del beneficiario
CREATE PROCEDURE ConsultaFilaBN
	@inIdCuenta INT
	, @inIdPersona INT
	, @outIdBN INT OUTPUT
	, @outNombre VARCHAR(40) OUTPUT
	, @outValorDocumentoIdentidad VARCHAR(40) OUTPUT
	, @outFechaNacimiento VARCHAR(40) OUTPUT
	, @outtelefono1 VARCHAR(40) OUTPUT
	, @outtelefono2 VARCHAR(40) OUTPUT
	, @outNombrePa VARCHAR(40) OUTPUT
	, @outPorcentaje VARCHAR(40) OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	-- Obtener Id 
	SELECT @outIdBN = B.Id
	FROM dbo.Persona P INNER JOIN dbo.Beneficiario B 
	ON P.Id=B.IdPersona INNER JOIN dbo.Parentezco Pa 
	ON B.ParentezcoId=Pa.Id 
	WHERE B.IdCuenta=@inIdCuenta AND B.Activo=1 AND B.Id= @inIdPersona

	-- Obtener nombre 
	SELECT @outNombre = P.Nombre
	FROM dbo.Persona P INNER JOIN dbo.Beneficiario B 
	ON P.Id=B.IdPersona INNER JOIN dbo.Parentezco Pa 
	ON B.ParentezcoId=Pa.Id 
	WHERE B.IdCuenta=@inIdCuenta AND B.Activo=1 AND B.Id= @inIdPersona
	
	-- Obtener ValorDocumentoIdentidad
	SELECT @outValorDocumentoIdentidad = P.ValorDocumentoIdentidad
	FROM dbo.Persona P INNER JOIN dbo.Beneficiario B 
	ON P.Id=B.IdPersona INNER JOIN dbo.Parentezco Pa 
	ON B.ParentezcoId=Pa.Id 
	WHERE B.IdCuenta=@inIdCuenta AND B.Activo=1 AND B.Id= @inIdPersona
	
	-- Obtener Fecha de Nacimiento
	SELECT @outFechaNacimiento = P.FechaNacimiento
	FROM dbo.Persona P INNER JOIN dbo.Beneficiario B 
	ON P.Id=B.IdPersona INNER JOIN dbo.Parentezco Pa 
	ON B.ParentezcoId=Pa.Id 
	WHERE B.IdCuenta=@inIdCuenta AND B.Activo=1 AND B.Id= @inIdPersona
	
	-- Obtener Telefono 1
	SELECT @outtelefono1 = P.telefono1
	FROM dbo.Persona P INNER JOIN dbo.Beneficiario B 
	ON P.Id=B.IdPersona INNER JOIN dbo.Parentezco Pa 
	ON B.ParentezcoId=Pa.Id 
	WHERE B.IdCuenta=@inIdCuenta AND B.Activo=1 AND B.Id= @inIdPersona

	-- Obtener Telefono 2
	SELECT @outtelefono2 = P.telefono2
	FROM dbo.Persona P INNER JOIN dbo.Beneficiario B 
	ON P.Id=B.IdPersona INNER JOIN dbo.Parentezco Pa 
	ON B.ParentezcoId=Pa.Id 
	WHERE B.IdCuenta=@inIdCuenta AND B.Activo=1 AND B.Id= @inIdPersona

	-- Obtener Nombre de Parentezo
	SELECT @outNombrePa = Pa.Nombre
	FROM dbo.Persona P INNER JOIN dbo.Beneficiario B 
	ON P.Id=B.IdPersona INNER JOIN dbo.Parentezco Pa 
	ON B.ParentezcoId=Pa.Id 
	WHERE B.IdCuenta=@inIdCuenta AND B.Activo=1 AND B.Id= @inIdPersona

	-- Obtener Porcentaje
	SELECT @outPorcentaje = B.Porcentaje
	FROM dbo.Persona P INNER JOIN dbo.Beneficiario B 
	ON P.Id=B.IdPersona INNER JOIN dbo.Parentezco Pa 
	ON B.ParentezcoId=Pa.Id 
	WHERE B.IdCuenta=@inIdCuenta AND B.Activo=1 AND B.Id= @inIdPersona
	SET NOCOUNT OFF
END