CREATE PROCEDURE EliminarCO
	@inId INT
	, @outCodeResult INT OUTPUT
AS
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN TRANSACTION T1
			UPDATE dbo.CuentaObjetivo 
			SET Activo=0 
			WHERE Id=@inId
		COMMIT TRANSACTION t1
	END TRY
	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
		--INSERT EN TABLA DE ERRORES;
		SET @outCodeResult=50005;
	END CATCH
	SET NOCOUNT OFF
END