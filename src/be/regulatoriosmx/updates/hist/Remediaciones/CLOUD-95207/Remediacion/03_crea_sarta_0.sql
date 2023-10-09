USE cobis
GO
/*
SELECT * FROM cobis..ba_parametro WHERE pa_sarta = 0 
ORDER BY pa_batch, pa_parametro
*/

update ba_batch set 
	ba_nombre      = 'CIERRE PERIODO CONTABLE', 
	ba_descripcion = 'CIERRE PERIODO CONTABLE'
where ba_batch = 6078 
go
--////////////////////////////////////////////////////
SELECT ba_arch_resultado, ba_batch FROM ba_batch where ba_batch IN (36411, 36419, 36420, 36424)

update ba_batch set 
	ba_arch_resultado = 'A_411.txt'
where ba_batch = 36411 

update ba_batch set 
	ba_arch_resultado = 'A_419.txt'
where ba_batch = 36419 

update ba_batch set 
	ba_arch_resultado = 'A_420.txt'
where ba_batch = 36420 

update ba_batch set 
	ba_arch_resultado = 'A_424.txt'
where ba_batch = 36424 

SELECT ba_arch_resultado, ba_batch FROM ba_batch where ba_batch IN (36411, 36419, 36420, 36424)
go
--////////////////////////////////////////////////////
SELECT 'registros antes' = count(1) FROM cobis..ba_parametro WHERE pa_sarta = 0 

GO
DELETE FROM cobis..ba_parametro WHERE pa_sarta = 0 
go



INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 3085, 0, 1, 'FECHA PROCESO', 'D', '01/01/2010')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4011, 0, 1, 'FILIAL ', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4012, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4012, 0, 2, 'FECHA_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4013, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4013, 0, 2, 'FECHA_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4016, 0, 1, 'FECHA_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4020, 0, 1, 'FECHA DE PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4020, 0, 2, 'TIPO DE REPORTE', 'C', 'M')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4020, 0, 3, 'CANTIDAD MESES A CONSULTAR', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4026, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4026, 0, 2, 'FECHA_PROCESO', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4037, 0, 1, 'FECHA_PROCESO', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4130, 0, 1, 'FILIAL ', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4130, 0, 2, 'FECHA_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4130, 0, 3, 'HIJO', 'C', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4130, 0, 4, 'HIJOS', 'C', '5')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4133, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4133, 0, 2, 'FECHA_ PROCESO', 'D', '01/12/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4139, 0, 1, 'FECHA_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4139, 0, 2, 'CUENTA', 'C', '000000000000000')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4139, 0, 3, 'VALIDACION_MONTO', 'C', 'T')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4139, 0, 4, 'SALDO_VALIDAR', 'M', '0.00')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4161, 0, 1, 'FILIAL ', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4161, 0, 2, 'FECHA_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4161, 0, 3, 'RUTA_SALIDA', 'C', 'C:/Cobis/vbatch/ahorros/listados/')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 1, 'FECHA DE PROCESO', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 2, 'MONTO INICIAL', 'M', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 3, 'MONTO FINAL', 'M', '999999999999.99')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 4, 'OPCION SUCURSAL', 'C', 'T')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4196, 0, 5, 'CODIGO SUCURSAL', 'I', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4204, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4204, 0, 2, 'FECHA_PROCESO', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4217, 0, 1, 'CORRESPONSAL', 'C', '')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4219, 0, 1, 'CORRESPONSAL', 'C', '')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4221, 0, 1, 'CORRESPONSAL', 'C', '')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4222, 0, 1, 'FECHA_DE_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4223, 0, 1, 'FECHA_DE_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4225, 0, 1, 'FILIAL', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4230, 0, 1, 'SERVIDOR', 'C', 'KERNELPROD')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4230, 0, 2, 'FECHA DE PROCESO', 'D', '01/01/2010')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4231, 0, 1, 'SERVIDOR', 'C', 'KERNELPROD')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4231, 0, 2, 'FECHA DE PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4232, 0, 1, 'FILIAL ', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4232, 0, 2, 'FECHA DE PROCESO', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4232, 0, 3, 'HISTORICO', 'C', 'S')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4234, 0, 1, 'FECHA DE PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4236, 0, 1, 'FECHA_DE_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4237, 0, 1, 'FECHA_PROCESO', 'D', '01/12/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4240, 0, 1, 'FILIAL ', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4240, 0, 2, 'FECHA_INICIAL ', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4240, 0, 3, 'FECHA_FINAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4240, 0, 4, 'DIRECTORIO_SALIDA ', 'C', 'C:/Cobis/vbatch/ahorros/listados/')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4242, 0, 1, 'FECHA PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4242, 0, 2, 'EJECUCION', 'C', 'D')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4244, 0, 1, 'EJECUCION', 'C', 'D')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4244, 0, 2, 'FECHA PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4246, 0, 1, 'FILIAL ', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4246, 0, 2, 'FECHA_PROCESO ', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4246, 0, 3, 'EJECUCION', 'C', 'D')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4246, 0, 4, 'DIRECTORIO_SALIDA ', 'C', 'C:/Cobis/vbatch/ahorros/listados/')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4249, 0, 1, 'FECHA_PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4255, 0, 1, 'FECHA PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4262, 0, 1, 'FECHA FIN DE MES', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4263, 0, 1, 'FECHA CORTE', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4263, 0, 2, 'CORRESPONSAL BANCARIO', 'C', '')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4269, 0, 1, 'FECHA INICIO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4269, 0, 2, 'FECHA FI', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6010, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6010, 0, 2, 'FECHA', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6017, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6017, 0, 2, 'FECHA', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6017, 0, 3, 'FECHA FIN PERIODO', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6017, 0, 4, 'OFICINA ESPECIFICA', 'I', '255')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6017, 0, 5, 'NIVEL CUENTA', 'I', '6')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6017, 0, 6, 'NIVEL', 'I', '6')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6080, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6080, 0, 2, 'ARCHIVO', 'C', 'prueba.txt')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6084, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6084, 0, 2, 'FECHA', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6084, 0, 3, 'PRODUCTO', 'I', '7')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6085, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6100, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6100, 0, 2, 'FECHA', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6101, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6101, 0, 2, 'FECHA', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6110, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6220, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6220, 0, 2, 'FECHA INICIAL', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6220, 0, 3, 'FECHA FINAL', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6220, 0, 4, 'NIVEL OFICINA', 'I', '5')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6220, 0, 5, 'OFICINA INICIAL', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6220, 0, 6, 'OFICINA FINAL', 'I', '9000')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6220, 0, 7, 'CUENTA INICIAL', 'C', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6220, 0, 8, 'CUENTA FINAL', 'C', '9')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6525, 0, 1, 'OPERACION (V)', 'C', 'V')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6525, 0, 2, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6525, 0, 3, 'PRODUCTO', 'I', '7')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6811, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6811, 0, 2, 'ARCHIVO', 'C', 'DYNAMICS')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6811, 0, 3, 'VALIDA AUTOMATIC', 'C', 'S')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6811, 0, 4, 'TIPO CARGA', 'C', 'M')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6812, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6910, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6910, 0, 2, 'FECHA', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6910, 0, 3, 'PRODUCTO', 'I', '7')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6935, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 6935, 0, 2, 'FECHA_PROCESO', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7001, 0, 1, 'HIJO', 'C', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7001, 0, 2, 'SARTA', 'C', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7001, 0, 3, 'BATCH', 'C', '7002')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7001, 0, 4, 'OPCION', 'C', 'G')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7001, 0, 5, 'BLOQUE', 'C', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7002, 0, 1, 'HIJO', 'C', '2')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7002, 0, 2, 'SARTA', 'C', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7002, 0, 3, 'BATCH', 'C', '7002')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7002, 0, 4, 'OPCION', 'C', 'B')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7002, 0, 5, 'BLOQUE', 'C', '2000')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7003, 0, 1, 'HIJO', 'C', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7003, 0, 2, 'SARTA', 'C', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7003, 0, 3, 'BATCH', 'C', '7004')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7003, 0, 4, 'OPCION', 'C', 'G')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7003, 0, 5, 'BLOQUE', 'C', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7004, 0, 1, 'HIJO', 'C', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7004, 0, 2, 'SARTA', 'C', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7004, 0, 3, 'BATCH', 'C', '7004')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7004, 0, 4, 'OPCION', 'C', 'B')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7004, 0, 5, 'BLOQUE', 'C', '2000')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7007, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7007, 0, 2, 'FECHA', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7007, 0, 3, 'HISTORICO', 'C', 'S')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7067, 0, 1, 'FECHA', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7067, 0, 2, 'CODIGO BATCH', 'I', '7067')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7071, 0, 1, 'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7071, 0, 2, 'OPERACION', 'C', '')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7072, 0, 1, 'TIPONOTIF', 'C', 'PFPCO')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7073, 0, 1, 'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7073, 0, 2, 'OPERACION', 'C', '')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7075, 0, 1, 'SARTA', 'I', '4')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7075, 0, 2, 'BATCH', 'I', '7075')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7076, 0, 1, 'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7076, 0, 2, 'OPERACION', 'C', '')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7078, 0, 1, 'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7080, 0, 1, 'FECHA_PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7080, 0, 2, 'PRESTAMO', 'C', '00')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7081, 0, 1, 'FECHA_PROCESO', 'D', 'Sep  1 2017  1:41PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7082, 0, 1, 'OPERACION', 'C', 'B')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7084, 0, 1, 'FECHA_PROCESO', 'D', '09/19/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7111, 0, 1, 'FECHA INICIAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7111, 0, 2, 'FECHA FINAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7112, 0, 1, 'FECHA INICIO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7112, 0, 2, 'FECHA FI', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7113, 0, 1, 'FECHA DESDE REEST', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7113, 0, 2, 'FECHA INICIO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7130, 0, 1, 'FECHA_INICIAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7130, 0, 2, 'FECHA_FINAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7190, 0, 1, 'ORIGEN', 'C', 'VBATCH')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7191, 0, 1, 'ORIGEN', 'C', 'VBATCH')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7946, 0, 1, 'FECHA_PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7947, 0, 1, 'FECHA', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7948, 0, 1, 'FECHA CORTE', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7948, 0, 2, 'FECHA PROYECCION HASTA', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7949, 0, 1, 'FECHA PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7950, 0, 1, 'FECHA INICIAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7950, 0, 2, 'FECHA FINAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7954, 0, 1, 'FECHA_INI_MES', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7954, 0, 2, 'FECHA_FIN_MES', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7970, 0, 1, 'FECHA DE PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 10006, 0, 1, 'FECHA PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14001, 0, 1, 'FECHA', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14007, 0, 1, 'FECHA INICIAL', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14007, 0, 2, 'FECHA FINAL', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14007, 0, 3, 'CIUDAD', 'C', 'T')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14007, 0, 4, 'OFICINA', 'C', 'T')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14007, 0, 5, 'TOPERACION', 'C', 'T')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14007, 0, 6, 'FORMA DE PAGO', 'C', 'T')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14048, 0, 1, 'FECHA INICIAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14048, 0, 2, 'FECHA FINAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14093, 0, 1, 'FECHA INICIAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14093, 0, 2, 'FECHA FINAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14999, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14999, 0, 2, 'FECHA ', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 14999, 0, 3, 'HISTORICO', 'C', 'S')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 17001, 0, 1, 'FECHA_PROCESO', 'D', '06/22/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 19058, 0, 1, 'FECHA DE PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 19058, 0, 2, 'REPORTE', 'C', '2200')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 19059, 0, 1, 'FECHA DE PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 19059, 0, 2, 'REPORTE', 'C', '0')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 19064, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 19070, 0, 1, 'FECHA DE PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21006, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21042, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21043, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21059, 0, 1, 'FECHA DESDE', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21059, 0, 2, 'FECHA HASTA', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21062, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21434, 0, 1, 'FUENTE', 'C', 'B')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21439, 0, 1, 'FECHA DE PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21439, 0, 2, 'OPCION', 'C', 'D')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21441, 0, 1, 'FECHA', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21441, 0, 2, 'FIN DE MES', 'C', '')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21480, 0, 1, 'FECHA PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 21483, 0, 1, 'FECHA CORTE', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26007, 0, 1, 'Fecha Proceso', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26007, 0, 2, 'Codi Entidad', 'C', 'RBM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26008, 0, 1, 'FECHA INICIO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26008, 0, 2, 'FECHA FI', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26024, 0, 1, 'FECHA INICIO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26024, 0, 2, 'FECHA FI', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 26024, 0, 3, 'TIPO EJECUCION', 'C', 'M')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28534, 0, 1, 'FECHA DE PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28534, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DT')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28535, 0, 1, 'FECHA DE PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28535, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'PY')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28536, 0, 1, 'FECHA DE PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28536, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DD')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28537, 0, 1, 'FECHA DE PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28537, 0, 2, 'OPERACION (TO/DO/DT/PY/DD)', 'C', 'DO')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28538, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28539, 0, 1, 'FECHA OPERACION', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28539, 0, 2, 'OPERACION', 'C', 'CL')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28540, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28540, 0, 2, 'OPERACION', 'C', 'TR')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28541, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28541, 0, 2, 'OPERACION', 'C', 'DC')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28574, 0, 1, 'EMPRESA', 'I', '1')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28574, 0, 2, 'FECHA INICIAL', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28574, 0, 3, 'FECHA TRANSMISIO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28605, 0, 1, 'FECHA DE PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28608, 0, 1, 'FECHA DE PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28633, 0, 1, 'FECHA INICIAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28633, 0, 2, 'FECHA FINAL', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28790, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28790, 0, 2, 'OPERACION (TO=TODO VH=HECHOS VIOLENTOS CG=GARANTIAS)', 'C', 'CG')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28793, 0, 1, 'FECHA PROCESO', 'D', '11/28/2017')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28793, 0, 2, 'PROCESO', 'I', '28793')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28793, 0, 3, 'FORMATO FECHA', 'I', '111')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28812, 0, 1, 'FECHA_INICIO_MES', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28812, 0, 2, 'FECHA_FIN_MES', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28822, 0, 1, 'FECHA_INICIO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28822, 0, 2, 'FECHA_FI', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 28822, 0, 3, 'TIPO_EJECUCION', 'C', 'M')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 152024, 0, 1, 'FECHA PROCESO', 'D', 'Mar  6 2018  4:07PM')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 152024, 0, 2, 'PRODUCTO', 'I', '203')
GO

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 152024, 0, 3, 'EMPRESA', 'I', '1')
GO

SELECT 'registros antes' = count(1) FROM cobis..ba_parametro WHERE pa_sarta = 0 

GO