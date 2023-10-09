
/*************************************************/
-- Fecha Creación del Script:  27/06/2016
-- Historial  Dependencias:
-- KME    27/06/2016   Se añade ad_tr_autorizada para transaccion 99
-- KME    27/06/2016   Se añade ad_procedure para sp_tr_mensaje_estcta
/*************************************************/ 
use cobis
go

declare 
     @w_rol      int,
     @w_moneda   tinyint,
     @w_producto tinyint

select @w_producto = 4

select @w_rol = ro_rol
  from ad_rol
--where ro_descripcion like 'ADMINISTRADOR'
 where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
   delete cobis..ad_tr_autorizada 
 where ta_producto = 4 
   and ta_rol = @w_rol and ta_transaccion =99
   
   delete FROM ad_tr_autorizada 
 WHERE ta_transaccion in ( 99) 
   and ta_producto = @w_producto
   and ta_rol = @w_rol
   
INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
VALUES (@w_producto, 'R', @w_moneda, 99, @w_rol, convert(varchar(20) ,getdate(),101), 1, 'V', convert(varchar(20) ,getdate(),101))

delete FROM ad_procedure where pd_procedure=2548 
and pd_stored_procedure= 'sp_tr_mensaje_estcta'
AND pd_archivo = 'tr_estcta.sp'

INSERT INTO ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
VALUES (2548, 'sp_tr_mensaje_estcta', 'cob_remesas', 'V', convert(varchar(20) ,getdate(),101), 'tr_estcta.sp')
GO

