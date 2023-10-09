use cobis
go

declare @w_rol 		int,
		@w_producto int

select @w_rol = ro_rol 
  from ad_rol 
 where ro_descripcion = 'OPERADOR DE BATCH COBIS'

select @w_producto = pd_producto 
  from cl_producto 
 where pd_descripcion = 'BATCH'
 
if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8014 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8014, @w_rol, getdate(), 1, 'V', getdate())
 
if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8016 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8016, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8017 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8017, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8031 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8031, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8032 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8032, @w_rol, getdate(), 1, 'V', getdate())


if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8033 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8033, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8035 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8035, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8062 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8062, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8067 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8067, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8070 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8070, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8071 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8071, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8090 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8090, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8099 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8099, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 8101 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 8101, @w_rol, getdate(), 1, 'V', getdate())

if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 15289 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 15289, @w_rol, getdate(), 1, 'V', getdate())


if not exists ( select 1 from ad_tr_autorizada where ta_transaccion = 15037 and ta_rol = @w_rol)
INSERT INTO dbo.ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', 0, 15037, @w_rol, getdate(), 1, 'V', getdate())

go