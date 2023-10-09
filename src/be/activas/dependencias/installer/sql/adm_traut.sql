use cobis
go

declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint

select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_producto = 2 ---> MIS
-- -----------------------------------
delete cobis..ad_tr_autorizada
 where ta_producto = @w_producto
   and ta_transaccion in (1133,1210)
   and ta_rol      = @w_rol
   and ta_moneda   = @w_moneda
-- -----------------------------------

insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (@w_producto, 'R', @w_moneda, 1133, @w_rol, getdate(), 1, 'V', getdate())

insert into cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
values (@w_producto, 'R', @w_moneda, 1210, @w_rol, getdate(), 1, 'V', getdate())
go

