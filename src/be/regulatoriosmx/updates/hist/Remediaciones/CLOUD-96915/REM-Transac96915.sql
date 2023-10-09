
--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES
--------------------------------------------------------------------------------------------
use cobis
go
DECLARE @w_numero int, @w_producto int
SELECT @w_numero = 21367, @w_producto = 21
-- reprocesable
--Borrar tambien por producto, rol -- no olvidar eso

delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero -- posiblemente no
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero
--sp_var_cancelacion_grp_ant
-- sql\cr_transac.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_var_cancelacion_grp_ant','cob_credito','V',getdate(),'sp_v_cgr_an.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'VARIABLE DIAS DE ATRASO CANCELACION GRP', convert(varchar,@w_numero), 'VARIABLE DIAS DE ATRASO CANCELACION GRP')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol INT

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

set    @w_fecha = getdate()

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
 BEGIN


  select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

  INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
  VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
END
ELSE
BEGIN
  select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
  INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
  VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())


END

go


-------------sp_dias_atraso_can_grupal
use cobis
go
DECLARE @w_numero int, @w_producto int
SELECT @w_numero = 21369, @w_producto = 21
-- reprocesable
--Borrar tambien por producto, rol -- no olvidar eso

delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero -- posiblemente no
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero
--sp_var_cancelacion_grp_ant
-- sql\cr_transac.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_dias_atraso_can_grupal','cob_credito','V',getdate(),'sp_datcangp.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'SP DIAS DE ATRASO CANCELACION GRP', convert(varchar,@w_numero), 'SP DIAS DE ATRASO CANCELACION GRP')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol INT

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

set    @w_fecha = getdate()
if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
 BEGIN
  select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

  INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
  VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
 END
 ELSE
  BEGIN
    select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
    INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
    VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
  END


GO

-------------sp_var_experiencia_crediticia
use cobis
go
DECLARE @w_numero int, @w_producto int
SELECT @w_numero = 21370, @w_producto = 21
-- reprocesable
--Borrar tambien por producto, rol -- no olvidar eso

delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero -- posiblemente no
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero
--sp_var_cancelacion_grp_ant
-- sql\cr_transac.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_var_experiencia_crediticia','cob_credito','V',getdate(),'sp_va_excre.sp')

insert into cl_ttransaccion(tn_trn_code,tn_descripcion,tn_nemonico,tn_desc_larga) 
values (@w_numero, 'SP VARIABLE EXPERIENCIA CREDITICIA', convert(varchar,@w_numero), 'SP VARIABLE EXPERIENCIA CREDITICIA')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol INT

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

set    @w_fecha = getdate()
if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
 BEGIN

   select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

  INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
  VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
  
 END
 ELSE
 BEGIN
 
   select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'  
  INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
  VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, getdate(), 1, 'V', getdate())
  
 END


go