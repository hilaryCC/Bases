-- SP para Crear Estado de cuenta cada vez que se ingresa una cuenta nueva

USE Proyecto
GO

CREATE TRIGGER CrearEstadoCuenta
ON dbo.CuentaAhorro FOR INSERT
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		BEGIN TRANSACTION T1;
			INSERT INTO dbo.EstadoCuenta(FechaInicio, FechaFin, SaldoInicial, SaldoFinal, IdCuenta, OpATM, OpVentana, Activo, SaldoMin)
				SELECT I.FechaCreacion, NULL, I.Saldo, NULL, C.Id, 0, 0, 1, C.Saldo 
					FROM inserted I INNER JOIN dbo.CuentaAhorro C ON I.NumeroCuenta = C.NumeroCuenta
		COMMIT TRANSACTION T1;
	END TRY

	BEGIN CATCH
		IF @@tRANCOUNT>0
			ROLLBACK TRAN T1;
	END CATCH
	SET NOCOUNT OFF
END