
use cobis
go

declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'

select @w_producto = 1 ---> ADMINISTRACION
-- -----------------------------------
delete cobis..ad_tr_autorizada
 where ta_producto = @w_producto
   AND ta_transaccion in ( 584, 1574 )
-- -----------------------------------


INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 584, @w_rol, getdate(), 1, 'V', getdate())

insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (@w_producto, 'R', @w_moneda, 1574, @w_rol, getdate(), 1, 'V', getdate())

GO

