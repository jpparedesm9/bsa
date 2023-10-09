
/* ***********************************************/
---No Bug: 77277
---T�tulo del Bug: 
---Fecha: 15/Jul/2016
--Descripci�n del Problema: Autorizaci�n de transacciones
--Descripci�n de la Soluci�n: Se registra Transaccion autorizada
--Autor: Walther Toledo
/* *************************************************/

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
 WHERE ta_transaccion in (1241)
   and ta_producto = @w_producto 
   and ta_rol      = @w_rol
-- -----------------------------------> mis_traut.sql

delete from ad_tr_autorizada where ta_producto=@w_producto and ta_moneda = @w_moneda and ta_rol=@w_rol
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1241, @w_rol, getdate(), 1, 'V', getdate())