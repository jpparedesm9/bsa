use cob_cuentas  
go

  print 'TABLA ====> re_error_batch '
go
if exists (select * from cob_cuentas..sysobjects
            where name = 're_error_batch')
   drop table re_error_batch
go
CREATE TABLE  re_error_batch(
	eb_cuenta		cuenta	not null,
	eb_mensaje	varchar(255)	not null
)
go


--creacion de parametro
delete from cl_parametro where pa_producto = 'REM' and pa_nemonico in ('PCPP')
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PRODUCTO COBIS DE PAQUETE DE PRODUCTOS', 'PCPP', 'T', NULL, 70, NULL, NULL, NULL, NULL, NULL, 'REM')