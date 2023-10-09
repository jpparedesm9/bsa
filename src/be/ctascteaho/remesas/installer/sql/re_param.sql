
use cobis
go

delete from cl_parametro where pa_producto = 'REM' and pa_nemonico in ('BINMI')

INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
VALUES ('BIN BANCAMIA', 'BINMI', 'C', '000536126', NULL, NULL, NULL, NULL, NULL, NULL, 'REM') 

delete from cl_parametro where pa_producto = 'REM' and pa_nemonico in ('PMIT')

INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
VALUES ('PORCENTAJE MINIMO DE COMISION POR TRANSFERENCIA', 'PMIT', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'REM')

delete from cl_parametro where pa_producto = 'REM' and pa_nemonico in ('MICT')

INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
VALUES ('MONTO MINIMO DE COMISION POR TRANSFERENCIA', 'MICT', 'M', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, 'REM')

delete from cl_parametro where pa_producto = 'REM' and pa_nemonico in ('MACT')

INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
VALUES ('MONTO MAXIMO DE COMISION POR TRANSFERENCIA', 'MACT', 'M', NULL, NULL, NULL, NULL, 0.00, NULL, NULL, 'REM')

delete from cl_parametro where pa_producto = 'REM' and pa_nemonico in ('PMAT')

INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
VALUES ('PORCENTAJE MAXIMO DE COMISION POR TRANSFERENCIA', 'PMAT', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'REM')

delete from cl_parametro where pa_producto = 'REM' and pa_nemonico in ('PCPP')
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO COBIS DE PAQUETE DE PRODUCTOS', 'PCPP', 'T', NULL, 70, NULL, NULL, NULL, NULL, NULL, 'REM')

delete from cl_parametro where pa_producto = 'REM' and pa_nemonico in ('CTEIC')
insert into cobis..cl_parametro (pa_parametro,pa_nemonico, pa_tipo, pa_char, pa_producto) 
values ('CTA CTE INGRESO CAJA', 'CTEIC', 'C', '99999999999', 'REM')
GO

