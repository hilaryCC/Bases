USE Proyecto1
GO

CREATE PROCEDURE ConsultaIdPersona
	@inUsuario VARCHAR(40)
	, @outIdPersona INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	
	SELECT @outIdPersona = IdPersona 
	FROM Usuario 
	WHERE [User]=@inUsuario
	
	SET NOCOUNT OFF
END