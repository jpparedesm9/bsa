/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S124039 Formatos de Documentos - Flujo Individual Parte II
--Descripción del Problema   : Reportes para Creditos individuales
--Responsable                : Walther Toledo Q.
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/
--Nombre Instalador          : cr_transac.sql
/*----------------------------------------------------------------------------------------------------------------*/
declare @w_moneda  tinyint,
        @w_rol     smallint

select @w_moneda = pa_tinyint
  from cobis..cl_parametro
 where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'
   
select @w_rol = ro_rol
  from ad_rol
 where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1
-- ---------------------------------------------------------------------------------------------------------------

delete cobis..ad_procedure where pd_procedure in (21743,21691) and pd_base_datos = 'cob_credito'
insert into ad_procedure values ( 21691, 'sp_datos_reportes_miembro',      'cob_credito',  'V', getdate(), 'cr_datrepgr.sp')
insert into ad_procedure values ( 21692, 'sp_datos_credito',               'cob_credito',  'V', getdate(), 'cr_datcred.sp')

delete cobis..cl_ttransaccion where tn_trn_code in (21274,21275)
insert into cl_ttransaccion values ( 21274, 'CONSULTAS REPORTES CREDITOS GRUPALES ',    '21274',       'CONSULTA RPT GRUPALES')
insert into cl_ttransaccion values ( 21275, 'CONSULTAS REPORTES CREDITOS INDIVIDUALES ','21275',       'CONSULTA RPT INDIVIDUALES')

delete cobis..ad_pro_transaccion where pt_producto = 21 and pt_moneda = @w_moneda and pt_transaccion in (21274,21275)
insert into ad_pro_transaccion values ( 21, 'R', @w_moneda,  21274,  'V', getdate(),   21691, null)
insert into ad_pro_transaccion values ( 21, 'R', @w_moneda,  21275,  'V', getdate(),   21692, null)

delete cobis..ad_tr_autorizada 
 where ta_producto = 1 
   and ta_rol = @w_rol
   and ta_moneda = @w_moneda
   and ta_transaccion in (21274,21275)
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
values ( 21, 'R',  @w_rol,  21274, @w_moneda, getdate(),  1,'V', getdate())
insert into ad_tr_autorizada(ta_producto,ta_tipo,ta_rol,ta_transaccion,ta_moneda,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
values ( 21, 'R',  @w_rol,  21275, @w_moneda, getdate(),  1,'V', getdate())

go

