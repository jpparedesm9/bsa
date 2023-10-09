USE cobis
GO

IF NOT EXISTS (SELECT 1 FROM cobis..cl_errores WHERE numero = 208934)
BEGIN
    INSERT INTO dbo.cl_errores (numero, severidad, mensaje)
    VALUES (208934, 0, 'FECHA DE ASOCIACION MAYOR A FECHA PROCESO')
END
go
