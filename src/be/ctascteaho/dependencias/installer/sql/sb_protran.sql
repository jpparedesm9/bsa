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
 where  pt_producto = 42 -- SERVICIOS BANCARIOS
   AND pt_transaccion in ( 29265 )
-- -----------------------------------

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (42, 'R', @w_moneda, 29265, 'V', getdate(), 29265, NULL)
GO