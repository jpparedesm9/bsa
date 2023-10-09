
-- ---------------------------------------------------------------------------------------------------------
-- ------------------------------------------- PRODUCTO 6 --------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------
print 'Transacciones Contabilidad'
use cobis
go
-- ---------------------------------------------------------------------------------------------------------
declare @w_rol      int,
        @w_rol2     int,
        @w_moneda   tinyint,
        @w_producto tinyint
select @w_rol2 = 18
select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_producto = 6 --->PRODUCTO 6 - CONTABILIDAD
select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

-----------------------------------------------------------------------------------
delete FROM ad_tr_autorizada 
 WHERE ta_transaccion=6030 
   and ta_producto=@w_producto 
   and ta_rol in (@w_rol,@w_rol2)

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 6030, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 6030, @w_rol2, getdate(), 1, 'V', getdate())
-----------------------------------------------------------------------------------

delete FROM ad_tr_autorizada 
 WHERE ta_transaccion in ( 6907 ) 
  and ta_producto=@w_producto 
  and ta_rol = @w_rol

INSERT INTO cobis..ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 6907, @w_rol, getdate(), 842, 'V', getdate())


GO

declare @w_rol      int,
        @w_moneda   tinyint,
        @w_producto tinyint

select @w_rol = ro_rol
from ad_rol
-- where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'


-- ---------------------------------------------------------------------------------------------------------
-- ------------------------------------------- PRODUCTO 3 --------------------------------------------------
-- ---------------------------------------------------------------------------------------------------------


select @w_moneda = pa_tinyint
from  cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and   pa_producto = 'ADM'

select @w_producto = 3 --->PRODUCTO CUENTAS

delete FROM ad_tr_autorizada 
 WHERE ta_transaccion in (16,2733,2796) 
   and ta_producto = @w_producto  -- CUENTA CORRIENTE
   and ta_rol = @w_rol
   
   
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 16, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 2733, @w_rol, getdate(), 1, 'V', getdate())

INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 2796, @w_rol, getdate(), 1, 'V', getdate())

GO

