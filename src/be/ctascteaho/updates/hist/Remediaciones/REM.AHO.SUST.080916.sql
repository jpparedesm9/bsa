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
delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=475 and pt_procedure=460
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 475, 'V', getdate(), 460, NULL)

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=494 and pt_procedure=459
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 494, 'V', getdate(), 459, NULL)

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=493 and pt_procedure=458
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 493, 'V', getdate(), 458, NULL)

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=708 and pt_procedure=708
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 708, 'V', getdate(), 708, NULL)

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=719 and pt_procedure=708
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 719, 'V', getdate(), 708, NULL)

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=720 and pt_procedure=709
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 720, 'V', getdate(), 709, NULL)

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=721 and pt_procedure=709
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 721, 'V', getdate(), 709, NULL)

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=698 and pt_procedure=635
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 698, 'V', getdate(), 635, NULL)

delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=700 and pt_procedure=635
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto,'R', @w_moneda, 700, 'V', getdate(), 635, NULL)

go

