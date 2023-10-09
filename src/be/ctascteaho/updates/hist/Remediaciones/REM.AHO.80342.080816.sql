/*************************************************/
---No Bug: AHO-80342
---Título de la Historia: Mantenimiento de UDIS
---Fecha: 03/08/2016
--Descripción del la Historia:  Agregar la logica de Cotizacion para soporte de 
--                              la conversion de la Unidad de Conversion UDI
--Descripción de la Solución: Se crea el parametro UDI
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
select @w_producto = 4 --->PRODUCTO 4 - CUENTA DE AHORROS
-- -----------------------------------------------

-- ------- ah_protran.sql
delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=738 and pt_procedure=717
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 738, 'V', getdate(), 717, NULL)

-- ------- re_protran.sql
select @w_producto = 10
delete from ad_pro_transaccion where pt_producto=@w_producto and pt_moneda=@w_moneda and pt_transaccion=741 and pt_procedure=718
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 741, 'V', getdate(), 718, NULL)