CREATE PROCEDURE ConsultaIdUsuario
	@inNameUser VARCHAR(40)
	, @outIdUsuario INT OUTPUT
AS 
BEGIN
	SET NOCOUNT OFF
	SELECT @outIdUsuario = Id
	FROM Usuario
	WHERE [User] = @inNameUser;
	SET NOCOUNT ON
END
