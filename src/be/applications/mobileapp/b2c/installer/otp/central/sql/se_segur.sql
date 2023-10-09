/* ******************************************************************************/
/*   Archivo:                se_segur.sql                                       */
/*   Base de datos:          cobis                                              */
/*   Producto:               Seguridad                                          */
/* ******************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/* ******************************************************************************/
/*              PROPOSITO                                                       */
/*  Creación de transacciones y procedimientos                                  */
/* ******************************************************************************/
/*                           MODIFICACIONES                                     */
/* ******************************************************************************/
/* FECHA         VERSION    AUTOR           RAZON                               */
/* ******************************************************************************/
/* 20-Oct-2016             GRO             Emision Inicial                      */
/* ******************************************************************************/

use cobis
go

begin tran

go

--- TRANSACCIONES 
delete cl_ttransaccion where tn_trn_code in(1875900,1875901) 
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values (1875900, 'ADMINISTRA TOKEN','GENT','ADMINISTRA TOKEN')   

go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga) 
values (1875901, 'ADMINISTRA NOTIFICACION TOKEN','GENT','ADMINISTRA NOTIFICACION TOKEN')   


--- PROCEDIMIENTOS
delete from ad_procedure where  pd_procedure in(1875900,1875901) 
go

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1875900, 'sp_administra_token','cob_bvirtual', 'V', getdate(),substring('sp_administra_token.sp',1,14))   	
go

insert into ad_procedure (pd_procedure, pd_stored_procedure, pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (1875901, 'sp_se_generar_notif','cobis', 'V', getdate(),substring('sp_se_generar_notif',1,14))   	
go

declare @w_rol smallint
select @w_rol = ro_rol
from  ad_rol
where ro_descripcion like '%ADMINISTRADOR%BRANCH%' and 	ro_filial = 1
if @@rowcount =0 
begin 
	select @w_rol = ro_rol
	from cobis..ad_rol
	where ro_descripcion like '%MENU POR PROCESOS%'
end 

select count(1) from ns_notificaciones_despacho

select top 10  * from ns_notificaciones_despacho
order by nd_id desc

select * from cob_bvirtual..bv_notificaciones_despacho

declare @w_moneda tinyint
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'CMNAC'
and pa_producto = 'ADM'

if @w_moneda = null
   select @w_moneda = 0
-- SEGURIDAD
delete ad_pro_transaccion where pt_transaccion in(1875900,1875901) 
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values(18,'R',@w_moneda,1875900,'V',getdate(),1875900)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values(18,'R',@w_moneda,1875901,'V',getdate(),1875901)
-- TRANSACCIONES AUTORIZADAS
delete ad_tr_autorizada where ta_transaccion in(1875900,1875901) 

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(18,'R',@w_moneda,1875900,@w_rol,getdate(),1,'V',getdate())


insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values(18,'R',@w_moneda,1875901,@w_rol,getdate(),1,'V',getdate())


commit tran

GO



