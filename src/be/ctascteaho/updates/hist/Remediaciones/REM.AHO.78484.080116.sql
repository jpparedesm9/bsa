
use cobis
go

declare 
     @w_rol         int,
     @w_moneda      tinyint,
     @w_producto    tinyint,
     @w_trx         int,
     @w_proc         int

select @w_rol = ro_rol
  from ad_rol
--where ro_descripcion like 'ADMINISTRADOR'
where ro_descripcion like 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
select @w_trx       = 698, -- Id de la trx
       @w_proc      = 635,  -- prod asociado
       @w_producto  = 10
---------------------re_protran.sql
delete from ad_pro_transaccion where pt_producto = @w_producto and pt_moneda = @w_moneda and pt_transaccion = @w_trx AND pt_procedure = @w_proc
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), @w_proc, NULL)
---------------------re_protran.sql
select @w_trx       = 700 -- Id de la trx
delete from ad_pro_transaccion where pt_producto = @w_producto and pt_moneda = @w_moneda and pt_transaccion = @w_trx AND pt_procedure = @w_proc
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), @w_proc, NULL)
---------------------re_protran.sql
select @w_trx       = 475, -- Id de la trx
       @w_proc      = 460
delete from ad_pro_transaccion where pt_producto = @w_producto and pt_moneda = @w_moneda and pt_transaccion = @w_trx AND pt_procedure = @w_proc
INSERT INTO ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
VALUES (@w_producto, 'R', @w_moneda, @w_trx, 'V', getdate(), @w_proc, NULL)

GO

