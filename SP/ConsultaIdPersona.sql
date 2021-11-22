USE Proyecto
GO

CREATE PROCEDURE dbo.ConsultaIdPersona
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