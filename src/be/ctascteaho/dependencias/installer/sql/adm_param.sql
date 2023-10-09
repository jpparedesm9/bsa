
use cobis
go

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'CCCNB' 
   AND pa_producto = 'ADM'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO CCNB', 'CCCNB', 'I', NULL, NULL, NULL, 9007, NULL, NULL, NULL, 'ADM')
go

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'VCTSB' 
   AND pa_producto = 'ADM'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VERSION CTS','VCTSB','C','N',NULL,NULL,NULL,NULL,NULL,NULL,'ADM')
go

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'TIDB' 
   AND pa_producto = 'ADM'   
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values  ('TASA DE IMPUESTO AL DEBITO BANCARIO', 'TIDB', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 0, 'ADM')
go

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'SMV' 
   AND pa_producto = 'ADM'   
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values  ('SALARIO MINIMO VITAL MENSUAL', 'SMV', 'M', NULL, NULL, NULL, NULL, 2191.20, NULL, NULL, 'ADM')
go

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'DIM' 
   AND pa_producto = 'ADM'   
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values  ('DIAS MES', 'DIM', 'T', NULL, 30, NULL, NULL, NULL, NULL, NULL, 'ADM')
go

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'CLIENT' 
   AND pa_producto = 'ADM'   
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values  ('NEMONICO DE CLIENTE CLIENT', 'CLIENT', 'C', 'BM', NULL, NULL, NULL, NULL, NULL, NULL, 'ADM')
go

DELETE FROM cobis..cl_parametro
 WHERE pa_nemonico = 'CIUN' 
   AND pa_producto = 'ADM'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO CIUDAD FERIADOS NACIONALES', 'CIUN', 'I', NULL, NULL, NULL, 9999, NULL, NULL, NULL, 'ADM')
GO


