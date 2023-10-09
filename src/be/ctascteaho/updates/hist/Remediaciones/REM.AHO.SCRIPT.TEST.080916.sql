/*************************************************/
---No Bug: N/A
---Título de la Historia: Falta autorizacion en Susteining
---Fecha: 08/08/2016
--Descripción del la Historia:  Autorizacion en Sustaining
--Descripción de la Solución: Se crea el registro de Autorizacion en Sustaining
--Autor: Walther Toledo
/*************************************************/

use cobis
go
declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint

select @w_rol = ro_rol
from ad_rol
where ro_descripcion like 'MENU POR PROCESOS'
-- -----------------------------------------------
select @w_moneda = pa_tinyint
from  cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'
-- -----------------------------------------------
select @w_producto = 10 --->PRODUCTO 10 - REMESAS
-- -----------------------------------------------

-- ---------------re_protran.sql
delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=711 and pt_procedure=636
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 711, 'V', getdate(), 636, NULL)

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=714 and pt_procedure=636
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 714, 'V',  getdate(), 636, NULL)

go

