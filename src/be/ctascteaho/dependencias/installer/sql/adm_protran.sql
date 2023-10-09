use cobis
go
-- ---------------------------------------------------------------------------------------------------------

declare @w_moneda tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'
  
  
-- -----------------------------------
delete cobis..ad_pro_transaccion
 where  pt_producto = 1 -- ADMINISTRACION
   AND pt_transaccion in ( 584 )
-- -----------------------------------

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (1, 'R', @w_moneda, 584, 'V', getdate(), 5006, NULL)


delete from ad_pro_transaccion
 where pt_producto    = 1 -- ADMINISTRACION
   and pt_transaccion = 1574
   and pt_procedure   = 5047

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
values (1, 'R', @w_moneda, 1574, 'V', getdate(), 5047, null)

delete from ad_pro_transaccion
 where pt_producto    = 1 -- ADMINISTRACION
   and pt_transaccion = 1229
   and pt_procedure   = 1115

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
values (1, 'R', @w_moneda, 1229, 'V', getdate(), 1115, null)

GO