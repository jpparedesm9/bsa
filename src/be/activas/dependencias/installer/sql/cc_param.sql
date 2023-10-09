/* CARGA PARAMETROS CUENTAS CORRIENTES */

use cobis
go

/* PARAMETROS GENERALES */

delete cobis..cl_parametro
 where pa_producto = 'CTE'
   and pa_nemonico in ('CDC','PIVA')
go

insert into cobis..cl_parametro values('CAUSA EMISION CHEQUE GERENCIA POR DESEMBOLSO', 'CDC', 'C', '041', null, null, null, null, null, null,'CTE')
insert into cobis..cl_parametro values('PARAMETRO IVA', 'PIVA', 'F', null, null, null, null, null, null, 16,'CTE')
go

