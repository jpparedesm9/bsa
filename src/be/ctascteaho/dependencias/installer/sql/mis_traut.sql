


-- ---------------------------------------------------------------------------------------------------------
-- ------------------------------------------- PRODUCTO 2 --------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------
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
 WHERE ta_transaccion in (1181,1182, 2938, 1225,1051,1610,1615,1241,1190,1414,1052,1218,1115,1300)
   and ta_producto = @w_producto 
   and ta_rol      = @w_rol

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1181, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1182, @w_rol,  getdate(), 1, 'V', getdate())

INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1225, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 2938, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1051, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1610, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1615, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1241, @w_rol, getdate(), 1, 'V', getdate())

--Inicio - transacciones Pantalla Búsqueda de Clientes: 1190 CONSULTA DEL NOMBRE DE UN CLIENTE, 1414 CONSULTA DIRECCION Y TELEFONO DEL ENTE

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1190, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1414, @w_rol, getdate(), 1, 'V', getdate())
--Fin - transacciones Pantalla Búsqueda de Clientes

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1052, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1218, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1115, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 1300, @w_rol, getdate(), 1, 'V', getdate())
GO

