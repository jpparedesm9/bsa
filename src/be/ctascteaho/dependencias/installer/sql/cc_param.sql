use cobis
go

delete from cl_producto where pd_producto = 3 and pd_descripcion='CUENTA CORRIENTE' and pd_abreviatura = 'CTE'

insert into cl_producto (pd_producto, pd_tipo, pd_descripcion, pd_abreviatura, pd_fecha_apertura, pd_estado, pd_saldo_minimo, pd_costo)
values (3, 'R', 'CUENTA CORRIENTE', 'CTE', getdate(), 'V', 0, 0)
go

delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='CEDU'
GO
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DOC. CEDULA EXTRANJERO', 'CEDU', 'C', 'XX', NULL, NULL, NULL, NULL, NULL, NULL, 'CTE')
GO
delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='CEMP'
GO
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DOC. SOCIEDAD EXTRANJERA', 'CEMP', 'C', 'XX', NULL, NULL, NULL, NULL, NULL, NULL, 'CTE')
GO
delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='OMAT'
GO
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('OFICINA MATRIZ ', 'OMAT', 'T', NULL,1, NULL, NULL, NULL, NULL, NULL, 'CTE')
GO
delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='CCBA'
GO
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO DE CLIENTE DEL BANCO', 'CCBA', 'I', NULL, NULL, NULL, 345785, NULL, NULL, NULL, 'CTE')
GO
delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='CMA'
GO
INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
VALUES ('CIUDAD DE MATRIZ', 'CMA', 'I', NULL, NULL, NULL, 9999, NULL, NULL, NULL, 'CTE') 
GO

delete from cl_parametro
 where pa_producto = 'CTE'
   and pa_nemonico in ('POP','KOP','MOP','LOP','GTO','DS0','RCLS0','RCS0','DIRE','CBCO','DVCH','DFMCH')
go

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PESOS PARA CUENTAS CORRIENTES', 'POP', 'C', '21212121212', NULL, NULL, NULL, NULL, NULL, NULL, 'CTE')
go

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MASCARA PARA CUENTAS CORRIENTES', 'KOP', 'C', '####-##-#####-#', NULL, NULL, NULL, NULL, NULL, NULL, 'CTE')
go

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MODULO PARA CUENTAS CORRIENTES', 'MOP', 'T', NULL, 11, NULL, NULL, NULL, NULL, NULL, 'CTE')
go

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('LONGITUD PARA CUENTAS CORRIENTES', 'LOP', 'T', NULL, 12, NULL, NULL, NULL, NULL, NULL, 'CTE')
go

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE GRUPOS DE TOTALES', 'GTO', 'T', NULL, 23, NULL, NULL, NULL, NULL, NULL, 'CTE')
go

insert into cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_money,pa_producto)
values('MONTO PARA REPORTES DE DIFERENCIAS DE SALDOS EN MONEDA NACIONAL','DS0','M',5000.00,'CTE')
go

insert into cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_money,pa_producto)
values('MONTO REPORTES DE RELACION DE CLIENTES CON SALDO DE 10MIL','RCLS0','M',10000.00,'CTE')
go

insert into cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_money,pa_producto)
values('MONTO REPORTES DE RELACION DE CLIENTES CON DEP. Y RET. DE 10MIL','RCS0','M',10000.00,'CTE')
go

insert into cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_tinyint,pa_producto)
values('DIAS DE DIFERIDO DE CHEQUES LOCALES', 'DIRE','T',2,'CTE')
go

insert into cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_tinyint,pa_producto)
values ('CODIGO DEL BANCO', 'CBCO', 'T', 59, 'CTE')
go

insert into cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_int,pa_producto) 
values ('DIAS DE VIGENCIA DE UN CHEQUE','DVCH','I',365,'CTE')
go

insert into cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_int,pa_producto) 
values('DIAS PARA LA FECHA MAXIMA DE UN CHEQUE','DFMCH','I',60,'CTE')
go

