/*
** SCRIPT : REGISTRA LAS TRANSACCIONES UTILIZADAS POR LA VISTA CONSOLIDADA DE CLIENTES
**
** RANGOS UTILIZADOS
** 73000 - 73999
**
*/

use cobis
go

/***********************************************************/
/*                                                         */
/* REGISTRO DE PROCEDIMIENTOS                              */
/*                                                         */
/***********************************************************/

delete ad_procedure
  where pd_procedure between 73000 and 73007
go

print 'Creacion de procedimientos para COBIS Vista Consolidada de Clientes'

insert into ad_procedure (pd_procedure, pd_stored_procedure,
  pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
  values (73000, '', 'cob_pac', 'V', getdate(),'')
go  

insert into ad_procedure (pd_procedure, pd_stored_procedure,
  pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
  values (73001, 'sp_persona_cons', 'cobis', 'V', getdate(), '')
go

insert into ad_procedure (pd_procedure, pd_stored_procedure,
  pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
  values (73002, 'sp_productos_bancarios', 'cob_apf', 'V', getdate(), '')
go

insert into ad_procedure (pd_procedure, pd_stored_procedure,
  pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
  values (73003, 'sp_script_ventas', 'cob_credito', 'V', getdate(), '')
go

insert into ad_procedure (pd_procedure, pd_stored_procedure,
  pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
  values (73004, 'sp_bp_products', 'cob_credito', 'V', getdate(), '')
go

insert into ad_procedure (pd_procedure, pd_stored_procedure,
  pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
  values (73005, 'sp_vista360', 'cob_credito', 'V', getdate(), '')
go

insert into ad_procedure (pd_procedure, pd_stored_procedure,
  pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
  values (73006, 'sp_query_bp_views', 'cob_pac', 'V', getdate(), '')
go

insert into ad_procedure (pd_procedure, pd_stored_procedure,
  pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
  values (73007, 'sp_adm_vista360', 'cob_pac', 'V', getdate(), '')
go

delete ad_procedure
  where pd_procedure = 731001
go

print 'Creacion de procedimiento para el Administrador de VCC'

insert into ad_procedure (pd_procedure, pd_stored_procedure,
  pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
  values (731001, 'sp_admin_vcc', 'cob_pac', 'V', getdate(),'')
go  


/****************************************************/
/*                                                  */
/* REGISTRO DE TRANSACCIONES                        */
/*                                                  */
/****************************************************/

delete cl_ttransaccion
  where tn_trn_code between 73000 and 73020
go

print 'Creacion de transacciones para COBIS Vista Consolidada de Clientes'

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73000, '', 'PAC', '')
go  

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73001, 'Query Client', 'CCU', '')
go  

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73002, 'Get Banking Products', 'GBP', '')
go  

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73003, 'Get Product Information about Products', 'GPI', '')
go  

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73004, 'Get Products', 'GP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73005, 'Get Balance Account', 'GBA', '')
go 

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73006, 'Get Risk Client', 'GRC', '')
go 

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73007, 'Get Rates Client', 'GRC', '')
go 

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73008, 'Get Protested Checks', 'GPC', '')
go 

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73009, 'Get Authorized Views', 'GAV', '')
go 

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73010, 'Get Cobis Products', 'GCP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73011, 'Get Funcionalities by Product', 'GFP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73012, 'Get Funcionalities Attached', 'GFA', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73013, 'Get Parameters', 'GPA', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73014, 'Insert Product Funcionality', 'IPF', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73015, 'Delete Product Funcionality', 'DPF', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73016, 'Insert View Parameter', 'IVP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73017, 'Update View Parameter', 'UVP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73018, 'Delete View Parameter', 'DVP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73019, 'Insert Parameter Value', 'IPV', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73020, 'Update Parameter Value', 'UPV', '')
go

delete cl_ttransaccion
  where tn_trn_code in (150,1184,1235,1181)
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (150, 'Query Group', 'QGP', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (1184, 'Query Group Detail', 'QGD', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (1235, 'Query Group Members', 'QGM', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (1181, 'Query Client Type', 'QCT', '')
go

delete cl_ttransaccion
  where tn_trn_code = 731001
go

print 'Creacion de transacciones para el Administrador de VCC'

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (731001, 'Administrador de la Vista Consolidada de Clientes', 'PAC', '')
go


/****************************************************/
/*                                                  */
/* REGISTRO DE PROCEDIMIENTO - TRANSACCION          */
/*                                                  */
/****************************************************/
delete ad_pro_transaccion
  where pt_producto = 73  and pt_transaccion between 73000 and 73020
go

print 'Creacion de procedimientos-transacciones para COBIS Vista Consolidada de Clientes'
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73000, 'V', getdate(), 73000)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73001, 'V', getdate(), 73001)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73002, 'V', getdate(), 73002)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73003, 'V', getdate(), 73003)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73004, 'V', getdate(), 73004)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73005, 'V', getdate(), 73005)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73006, 'V', getdate(), 73005)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73007, 'V', getdate(), 73005)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73008, 'V', getdate(), 73005)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73009, 'V', getdate(), 73006)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73010, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73011, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73012, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73013, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73014, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73015, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73016, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73017, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73018, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73019, 'V', getdate(), 73007)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73020, 'V', getdate(), 73007)
go

delete ad_pro_transaccion
  where pt_producto = 73  and pt_transaccion in (150,1184,1235,1181)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 150, 'V', getdate(), 1048)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 1184, 'V', getdate(), 1032)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 1235, 'V', getdate(), 1033)
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 1181, 'V', getdate(), 1024)
go

delete ad_pro_transaccion
  where pt_producto = 73  and pt_transaccion = 731001
go

print 'Creacion de procedimientos-transacciones para el Administrador de VCC'

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 731001, 'V', getdate(), 731001)
go


--REMESAS
delete ad_procedure where pd_procedure = 644
go

insert into ad_procedure values (644,'sp_remesas_recibidas','cob_remesas','V',getdate(),SUBSTRING('sp_remesas_recibidas', 1, 11) + '.sp')
go

delete cl_ttransaccion where tn_trn_code = 644
go

insert into cl_ttransaccion values (644,'CONSULTA REMESAS POR CLIENTE','644','CONSULTA REMESAS POR CLIENTE')
go

declare @w_moneda tinyint
select @w_moneda = 0

delete ad_pro_transaccion where pt_transaccion = 644
insert into ad_pro_transaccion  values (10, 'R', @w_moneda, 644,  'V',  getdate(),  644, null)

declare @w_id_rol int
select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'


if not exists (select 1 from cobis..ad_tr_autorizada where ta_rol = @w_id_rol and ta_producto = 10 and ta_transaccion = 644)
begin
   insert into cobis..ad_tr_autorizada 
          (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut,  ta_autorizante, ta_estado, ta_fecha_ult_mod)
   values (10,         'R',      0,         644,        @w_id_rol,      getdate(),     1,              'V',       getdate())
end
go

delete cobis..cl_errores where numero = 351030
go

insert into cobis..cl_errores values (351030, 0, 'NO EXISTEN REMESAS PARA EL CLIENTE SELECCIONADO')

go
