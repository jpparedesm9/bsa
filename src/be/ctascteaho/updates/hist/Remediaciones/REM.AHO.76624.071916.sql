/************************************************/
---No Bug: 76624
---Título del Bug: Transferencias Automáticas entre Cuentas - Dependencia sp
---Fecha: 19/Julio/2016
--Descripción del Problema: 
--Descripción de la Solución: 
--Autor: Roxana Sanchez / Tania Baidal
/**************************************************/

--CtasCteAho/Remesas/BackEnd/sql/re_error.sql

use cobis
go 

delete from cl_errores 
 where numero = 201333

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (201333, 1, 'Fecha de Proximo Pago debe ser menor o igual a la Fecha Hasta')


--CtasCteAho/Remesas/BackEnd/sql/re_param.sql

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


--CtasCteAho/Dependencias/sql/mis_traut.sql

print 'Transacciones cliente'
use cobis
go
-- ---------------------------------------------------------------------------------------------------------
declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

select @w_producto = 2 --->PRODUCTO 2 - MANAGEMENT INFORMATION SYSTEM

delete FROM ad_tr_autorizada 
 WHERE ta_transaccion in (1052)
   and ta_producto = @w_producto 
   and ta_rol      = @w_rol

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1052, @w_rol, getdate(), 1, 'V', getdate())