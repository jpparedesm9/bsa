/************************************************************************/
/*          MODIFICACIONES                                              */
/* 25/ABR/2016       ELO     Migracion SYBASE-SQLServer FAL             */
use cobis
go

declare @w_rol int, @w_moneda int

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'
 
select @w_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'

---ADMIN
--Transacción 15303
if not exists(select 1 from ad_procedure where pd_procedure = 5919 and pd_stored_procedure='sp_barrio')
begin
	insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
	values (5919,'sp_barrio','cobis','V',getdate(),'barrio.sp')
end

if not exists(select 1 from ad_pro_transaccion where pt_transaccion = 15303 and pt_producto=1)
begin
    insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
    values (1,'R',@w_moneda,15303,'V',getdate(),5919)
end

if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15303 and ta_producto=1)
begin
    insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda, ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante, ta_estado,ta_fecha_ult_mod) 
    values (1,'R',@w_moneda,15303,@w_rol,getdate(),1,'V',getdate())
end

if not exists(select 1 from cl_ttransaccion where tn_trn_code = 15303)
begin
    insert into cl_ttransaccion  (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
    values (15303,'ACTUALIZACION DE BARRIO','INSBA','ACTUALIZAR LA INFORMACION DEL BARRIO')
end

--Transacción 15304
if not exists(select 1 from ad_pro_transaccion where pt_transaccion = 15304 and pt_producto=1)
begin
    insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
    values (1,'R',@w_moneda,15304,'V',getdate(),5919)
end

if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15304 and ta_producto=1)
begin
    insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda, ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante, ta_estado,ta_fecha_ult_mod) 
    values (1,'R',@w_moneda,15304,@w_rol,getdate(),1,'V',getdate())
end

if not exists(select 1 from cl_ttransaccion where tn_trn_code = 15304)
begin
    insert into cl_ttransaccion  (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
    values (15304,'QUERY DE BARRIO','QBAR','DESCRIPCION')
end

--Transacción 15309
if not exists(select 1 from ad_pro_transaccion where pt_transaccion = 15309 and pt_producto=1)
begin
    insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
    values (1,'R',@w_moneda,15309,'V',getdate(),5919)
end

if not exists(select 1 from ad_tr_autorizada where ta_transaccion = 15309 and ta_producto=1)
begin
    insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda, ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante, ta_estado,ta_fecha_ult_mod) 
    values (1,'R',@w_moneda,15309,@w_rol,getdate(),1,'V',getdate())
end

if not exists(select 1 from cl_ttransaccion where tn_trn_code = 15309 )
begin
    insert into cl_ttransaccion  (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
    values (15309,'HELP DE BARRIO','HBAR','DESCRIPCION')
end
go

-- Clientes
if exists(select 1 from ad_procedure where pd_procedure=2987)
	DELETE FROM cobis..ad_procedure where pd_procedure =2987
insert into ad_procedure (pd_procedure, pd_stored_procedure, 
   pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2987,'sp_persona_foto','cobis','V',getdate(),'pers_foto.sp')

if exists(select 1 from ad_procedure where pd_procedure=2989)
	DELETE FROM cobis..ad_procedure where pd_procedure =2989
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (2989,'sp_param_listasNegras','cobis','V',getdate(),'paramln.sp')

if exists(select 1 from ad_procedure where pd_procedure=2990)
	DELETE FROM cobis..ad_procedure where pd_procedure =2990
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (2990,'sp_listas_negras','cobis','V',getdate(),'lis_negras.sp')

if exists(select 1 from ad_procedure where pd_procedure=2991)
	DELETE FROM cobis..ad_procedure where pd_procedure =2991
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2991, 'sp_formulario_01', 'cobis', 'V', getdate(), 'formulario.sp')

if exists(select 1 from ad_procedure where pd_procedure=2996)
	DELETE FROM cobis..ad_procedure where pd_procedure =2996
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2996,'sp_infocred_con','cobis','V',getdate(),'infocred_c.sp')

if exists(select 1 from ad_procedure where pd_procedure=2997)
	DELETE FROM cobis..ad_procedure where pd_procedure =2997
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (2997,'sp_consulta_alertas','cobis','V',getdate(),'con_alertas.sp')

if exists(select 1 from ad_procedure where pd_procedure=2998)
	DELETE FROM cobis..ad_procedure where pd_procedure =2998
insert into ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (2998,'sp_control_listasnegras','cobis','V',getdate(),'listanegras.sp')

if exists(select 1 from ad_procedure where pd_procedure=2999)
	DELETE FROM cobis..ad_procedure where pd_procedure =2999
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2999,'sp_calificacion_cliente','cobis','V',getdate(),'cal_cliente.sp')

if exists(select 1 from ad_procedure where pd_procedure=2995)
	DELETE FROM cobis..ad_procedure where pd_procedure =2995
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2995,'sp_cambio_estado','cobis','V',getdate(),'cambio_est.sp')

if exists(select 1 from ad_procedure where pd_procedure=2952)
	DELETE FROM cobis..ad_procedure where pd_procedure =2952
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2952,'sp_cambio_est_activo','cobis','V',getdate(),'cambio_est.sp')

if exists(select 1 from ad_procedure where pd_procedure=2953)
	DELETE FROM cobis..ad_procedure where pd_procedure =2953
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2953, 'sp_impresion_contactos', 'cobis', 'V', getdate(), 'impre_conta.sp')

if exists(select 1 from ad_procedure where pd_procedure=2954)
	DELETE FROM cobis..ad_procedure where pd_procedure =2954
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2954,'sp_huella_param','cobis','V',getdate(),'huella_para.sp')

if exists(select 1 from ad_procedure where pd_procedure=2955)
	DELETE FROM cobis..ad_procedure where pd_procedure =2955
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2955,'sp_huella_dact','cobis','V',getdate(),'huella_dact.sp')

if exists(select 1 from ad_procedure where pd_procedure=2956)
	DELETE FROM cobis..ad_procedure where pd_procedure =2956
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2956,'sp_consulta_cierre','cobis','V',getdate(),'con_cierre.sp')

if exists(select 1 from ad_procedure where pd_procedure=2957)
	DELETE FROM cobis..ad_procedure where pd_procedure =2957
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2957, 'sp_impresion_legal', 'cobis', 'V', getdate(), 'impr_legal.sp')

if exists(select 1 from ad_procedure where pd_procedure=2958)
	DELETE FROM cobis..ad_procedure where pd_procedure =2958
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2958, 'sp_documentos_ente', 'cobis', 'V', getdate(), 'doc_ente.sp')

if exists(select 1 from ad_procedure where pd_procedure=2959)
	DELETE FROM cobis..ad_procedure where pd_procedure =2959
insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (2959, 'sp_cons_vecindad', 'cobis', 'V', getdate(), 'cons_vecind.sp')


go