-- SP para deteminar informacion de un usuario
-- Entrada: 
--	+ Nombre de usuario
-- Salida:
--	+ Id del usuario
--  + Id de la persona
--  + Entero que indica si es administrador: 1(es) o 0 (no es)
CREATE PROCEDURE ConsultaUsuario
	@inNameUser VARCHAR(40)
	, @outIdUsuario INT OUTPUT
	, @outIdPersona INT OUTPUT
	, @outEsAdministrador INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	-- Determinar Id Usuario
	SELECT @outIdUsuario = Id
	FROM Usuario
	WHERE [User] = @inNameUser;
	-- Determinar Id Persona del Usuario
	SELECT @outIdPersona = IdPersona
	FROM Usuario
	WHERE [User] = @inNameUser;
	-- Determinar si el usuario es administrador
	SELECT @outEsAdministrador = EsAdministrador
	FROM Usuario
	WHERE [User] = @inNameUser;
	SET NOCOUNT OFF
END