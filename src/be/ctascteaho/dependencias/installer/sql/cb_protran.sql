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
 where  pt_producto = 6 -- CONTABILIDAD
   AND pt_transaccion IN (6030,
                          6906,6907,400 )
-- -----------------------------------
   
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (6, 'R', @w_moneda, 6030, 'V', getdate(), 6150, NULL)

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (6, 'R', @w_moneda, 6906, 'V', getdate(), 6436, NULL)

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (6, 'R', @w_moneda, 6907, 'V', getdate(), 6436, NULL)

INSERT INTO cobis..ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (6, 'R', @w_moneda, 400, 'V', getdate(), 6539, NULL)

GO

declare @w_moneda  tinyint,
        @w_producto tinyint

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
  and pa_producto = 'ADM'
 select @w_producto =3  --CUENTAS
-- -----------------------------------
delete cobis..ad_pro_transaccion
where  pt_producto = 3 -- CUENTA CORRIENTES
 AND pt_transaccion in ( 16,2733,2796)
-- -----------------------------------
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 16, 'V', getdate(), 75, NULL)

INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 2733, 'V', getdate(), 2597, NULL)
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, 2796, 'V', getdate(), 2669, NULL)

GO
