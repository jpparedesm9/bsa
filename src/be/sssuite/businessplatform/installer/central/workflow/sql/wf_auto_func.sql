set nocount on
go

use cobis
go

-- Busqueda del Rol Administrador de WorkFlow.
declare @w_rol int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

---------------------------------------
delete cobis..ad_tr_autorizada
 where ta_producto = 1
   and ta_rol = @w_rol
   and ta_transaccion in (15001,15165) 

insert into ad_tr_autorizada
  (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
  ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15001, @w_rol,
  getdate(), 1, 'V') 

insert into ad_tr_autorizada
  (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol,
  ta_fecha_aut, ta_autorizante, ta_estado)
values (1, 'R', 0, 15165, @w_rol,
  getdate(), 1, 'V') 
go
-----------------------------------------
delete cobis..ad_procedure
 where pd_procedure in (5029,15165) 

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5029, 'sp_funcbusq', 'cobis', 'V', getdate(), 'funcbusq.sp')
go

insert into ad_procedure (pd_procedure, pd_stored_procedure,
       pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (15165, 'sp_query_funcio_int', 'cobis', 'V', getdate(), 'query_funcio_int.sp')
go

-------------------------------------------
delete cobis..ad_pro_transaccion
 where pt_transaccion in (15001,15165) 
   and pt_producto = 1
   and pt_procedure in (5029,5136)


insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (1, 'R', 0, 15001, 'V', getdate(), 5029)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
       pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
values (1, 'R', 0, 15165, 'V', getdate(), 5136)
go

------------------------------------------
delete cobis..cl_ttransaccion
 where tn_trn_code in (15001,15165) 

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
        tn_desc_larga)
values(15001, 'BUSQ. FUNCIONARIO', 'BUFU', 'BUSQUEDA DE FUNCIONARIOS')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico,
        tn_desc_larga)
values(15165, 'TRAIDA FUNCIONARIO', 'TRFU', 'TRAIDA DE FUNCIONARIOS')
go

