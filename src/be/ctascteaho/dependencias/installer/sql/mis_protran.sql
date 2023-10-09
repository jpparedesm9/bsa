use cobis
go
-- ---------------------------------------------------------------------------------------------------------

declare @w_moneda   tinyint,
        @w_producto tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'
  
select @w_producto = 2
-- -----------------------------------
delete cobis..ad_pro_transaccion
 where  pt_producto = @w_producto -- MANAGEMENT INFORMATION SYSTEM
   AND pt_transaccion in ( 1181, 1182, 2938, 1051, 1610)
-- -----------------------------------

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 1181, 'V', getdate(), 1024, NULL)

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 1182, 'V', getdate(), 1027, NULL)

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 2938, 'V', getdate(), 1998, NULL)

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 1051, 'V', getdate(), 1126, NULL)

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 1610, 'V', getdate(), 7067105, NULL)

GO

