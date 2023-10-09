--Script para Historia CCA-H91928
--Autor: Henry Salazar

use cobis
go

/* ********************************************************************************************************************************************* */
-- TRANSACCION PARA REGLA CONSULTA PORCENTAJE CONDONACIONES
/* ********************************************************************************************************************************************* */
declare @w_rol tinyint,
        @w_trn int,
		@w_moneda tinyint
		
select @w_trn  = 7306

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
   and pa_producto = 'ADM'

select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS' 
   and ro_filial = 1

delete from cobis..cl_ttransaccion where tn_trn_code = @w_trn
delete from cobis..ad_procedure where pd_procedure = @w_trn
delete from cobis..ad_pro_transaccion where pt_transaccion = @w_trn
delete from cobis..ad_tr_autorizada where ta_transaccion = @w_trn

insert into cobis..cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values(@w_trn,'REGLA PARA PORCENTAJE DE CONDONACIONES',@w_trn,'REGLA PARA PORCENTAJE DE CONDONACIONES')

insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (@w_trn, 'sp_rule_condonacion', 'cob_cartera', 'V', getdate(), substring('rule_condonacion.sp',1,14))

insert into cobis..ad_pro_transaccion(pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure,pt_especial)
values(7,'R',@w_moneda,@w_trn,'V',getdate(),@w_trn, null)

insert into cobis..ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda,ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante,ta_estado,ta_fecha_ult_mod)
values(7,'R',@w_moneda,@w_trn,@w_rol,getdate(),1,'V',getdate())

/* ********************************************************************************************************************************************* */
--AUTORIZAR SERVICIO PARA OBTENER PORCENTAJE DE CONDONACION
/* ********************************************************************************************************************************************* */
delete from cobis..ad_servicio_autorizado where ts_servicio ='Loan.Rules.GetCondonationPercentage'
insert into cobis..ad_servicio_autorizado (ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut,ts_rol, ts_estado,ts_fecha_ult_mod)
values('Loan.Rules.GetCondonationPercentage',1,'R',0,getdate(),@w_rol ,'V',getdate())

DELETE FROM cobis..cts_serv_catalog WHERE csc_service_id = 'Loan.Rules.GetCondonationPercentage'
insert into cobis..cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name,csc_description, csc_trn)
values('Loan.Rules.GetCondonationPercentage','cobiscorp.ecobis.assets.cloud.service.IRules','getCondonationPercentage','getCondonationPercentage', @w_trn)

go
