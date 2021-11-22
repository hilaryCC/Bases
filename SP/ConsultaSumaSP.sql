-- SP para obtener la suma de los porcentajes y
-- la cantidad de beneficiarios
USE Proyecto
GO

CREATE PROCEDURE ConsultaBeneficarios
	@inIdCuenta INT
    , @outSuma INT OUTPUT
	, @outCant INT OUTPUT
AS 
BEGIN
	SET NOCOUNT ON
	
	SELECT @outSuma = SUM(porcentaje) 
		 , @outCant = COUNT(*) 
	FROM dbo.Beneficiario 
	WHERE IdCuenta=@inIdCuenta AND Activo=1

	SET NOCOUNT OFF
END