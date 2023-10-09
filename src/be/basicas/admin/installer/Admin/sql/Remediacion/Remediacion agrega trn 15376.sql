/************************************************************************/
/*          MODIFICACIONES                                              */
/* 25/ABR/2016       ELO     Migracion SYBASE-SQLServer FAL             */
use cobis
go

declare @w_moneda int,
		@codigo int

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM' 
 
select @codigo = ro_rol 
from ad_rol 
where ro_descripcion = 'MENU POR PROCESOS'
 
if not exists (select 1 from cl_ttransaccion where tn_trn_code = 15376)
	insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
	values (15376, 'ADMINISTRADOR DE SEGURIDADES - DESAUTORIZACION DE AGENTES', 'DEAGE', 'ADMINISTRADOR DE SEGURIDADES - DESAUTORIZACION DE AGENTES')
	
if not exists (select 1 from ad_tr_autorizada where ta_transaccion = 15376)
	insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda, ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante, ta_estado,ta_fecha_ult_mod) 
	values (1,'R',@w_moneda,15376,@codigo,getdate(),1,'V',getdate())

if not exists (select 1 from ad_pro_transaccion where pt_transaccion = 15376)
	insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
	values (1, 'R', @w_moneda, 15376, 'V', getdate(), 5204, null)

go