-- SP para deteminar informacion de un usuario
-- Entrada: 
--	+ Nombre de usuario
-- Salida:
--	+ Id del usuario
--  + Id de la persona
--  + Entero que indica si es administrador: 1(es) o 0 (no es)
USE Proyecto
GO

CREATE PROCEDURE ConsultaUsuario
	@inNameUser VARCHAR(40)
	, @outIdUsuario INT OUTPUT
	, @outIdPersona INT OUTPUT
	, @outEsAdministrador INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON

	-- Determinar Id Usuario, Id Persona del Usuario y si es administrador
	SELECT @outIdUsuario = Id
		 , @outIdPersona = IdPersona
		 , @outEsAdministrador = EsAdministrador
	FROM Usuario
	WHERE [User] = @inNameUser;

	SET NOCOUNT OFF
END

