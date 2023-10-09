
use cob_pac
go

if Object_id('bpl_rule_dependence') != null
  drop table bpl_rule_dependence
go

print 'bpl_rule_dependence'
go

if exists (select * from sysobjects where name = 'bpl_rule_dependence')
	drop table bpl_rule_dependence
go
 
create table bpl_rule_dependence
  (  rd_id INT,                       -- Id Dependencia 
     rl_id INT,                       -- Id Regla
     rd_dependence_type VARCHAR(10),  -- Tipo Dependencia
     rd_dependence_id   VARCHAR(10),  -- Id de Proceso, Producto, Programa, Funcionalidad de Dependencia
     rd_dependece_name  VARCHAR (255) -- Nombre de la Orquestación (Clase)
  )
go



use cobis 
go 

-- Seqnos 
print 'bpl_rule_dependence'

IF NOT EXISTS (SELECT 1 FROM cl_seqnos WHERE bdatos = 'cob_pac' and tabla = 'bpl_rule_dependence')
BEGIN
insert into cl_seqnos (bdatos,tabla,siguiente,pkey) values ('cob_pac','bpl_rule_dependence',0,'rd_id')
END
go

-- Transacciones Autorizadas SP's

delete ad_procedure where pd_procedure = 73518
delete cl_ttransaccion where tn_trn_code between 73542 and 73544
delete ad_pro_transaccion where pt_transaccion between 73542 and 73544

insert into ad_procedure
       (pd_procedure, pd_stored_procedure, pd_base_datos,
        pd_estado, pd_fecha_ult_mod, pd_archivo)
values (73518, 'sp_m_rule_dependence', 'cob_pac', 'V', getdate (), 'sp_m_rule_dependence.sp')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73542, 'InsertDependence', 'ID', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73543, 'DeleteDependence', 'DD', '')
go

insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
  values (73544, 'SearchDependence', 'SD', '')
go

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73542, 'V', getdate(), 73518)
go
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73543, 'V', getdate(), 73518)
go
insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda,
  pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure)
  values (73, 'R', 0, 73544, 'V', getdate(), 73518)
go

-- Transaccion Autorizada 

delete cobis..ad_tr_autorizada
 where ta_rol = 3
  and ta_transaccion between  73542 and 73544


insert into cobis..ad_tr_autorizada(ta_producto ,ta_tipo,ta_moneda ,ta_transaccion, ta_rol ,ta_fecha_aut ,ta_autorizante, ta_estado, ta_fecha_ult_mod)
select 73,   'R',   0,   tn_trn_code,   3,   getdate(),    1,    'V',     getdate()
from cobis..cl_ttransaccion
where tn_trn_code between 73542 and 73544

go 

--select * from cobis..ad_tr_autorizada where ta_rol = 3 and ta_transaccion between  73542 and 73544 
-- Errores 
delete from cobis..cl_errores where numero = 7300000
go
delete from cobis..cl_errores where numero = 7300001
go
delete from cobis..cl_errores where numero = 7300002
go

insert into cobis..cl_errores (numero, severidad, mensaje) values(7300000,0,'No existe Parametrizacion Base - Catalogo: bpl_type_dependence')
insert into cobis..cl_errores (numero, severidad, mensaje) values(7300001,0,'Error en la creación de dependencias de reglas')
insert into cobis..cl_errores (numero, severidad, mensaje) values(7300002,0,'Error en el borrado de dependencias de reglas')

-- Servicios 

if exists (select * from cts_serv_catalog where csc_service_id = 'Rules.Admin.RulesAdmin.QueryRuleDependence')
   update cts_serv_catalog set csc_class_name  = 'cobiscorp.ecobis.rules.admin.service.IRulesAdmin', 
                               csc_method_name = 'queryRuleDependence', 
                               csc_description = '', 
                               csc_trn = 73544 
                         where csc_service_id = 'Rules.Admin.RulesAdmin.QueryRuleDependence'
else
   insert into cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn) 
                         values ('Rules.Admin.RulesAdmin.QueryRuleDependence', 'cobiscorp.ecobis.rules.admin.service.IRulesAdmin', 'queryRuleDependence', '', 73544)
go
	  
if not exists (select 1 from ad_servicio_autorizado where ts_servicio = 'Rules.Admin.RulesAdmin.QueryRuleDependence')
   insert into ad_servicio_autorizado (ts_servicio,ts_rol,ts_producto,ts_tipo,ts_moneda,ts_fecha_aut,ts_estado,ts_fecha_ult_mod)
                                values('Rules.Admin.RulesAdmin.QueryRuleDependence',3,73,'R',0,getdate(),'V',getdate())
go

---------------------------------------
--Script para la Creación de catalogos
---------------------------------------
use cobis
go

declare @w_new_table        int, 
        @w_current_table    int,
        @w_cod_tab_an_prod  int
        
  
select @w_new_table =  max(codigo)
from cobis..cl_tabla


------------------------------------
-- catalogo: bpl_type_dependence
------------------------------------
print 'bpl_type_dependence'

select @w_current_table = codigo 
from cobis..cl_tabla
where tabla = 'bpl_type_dependence'

delete from cobis..cl_tabla
where codigo = @w_current_table

delete from cobis..cl_catalogo 
where tabla = @w_current_table

delete from cobis..cl_catalogo_pro
where cp_tabla = @w_current_table

select @w_new_table=@w_new_table + 1

insert into cobis..cl_tabla
values (@w_new_table,'bpl_type_dependence','Dependencias de Reglas')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_new_table,'01','Proceso','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_new_table,'02','Producto','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_new_table,'03','Orquestación','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_new_table,'04','Funcionalidad','V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_new_table,'05','Otra','V')

--------------------------------------
-- Actualización de la seqnos  
--------------------------------------
print 'cl_seqnos'
update cobis..cl_seqnos 
set siguiente = @w_new_table 
where bdatos = 'cobis' 
  and tabla  = 'cl_tabla' 
  and pkey   = 'codigo'
go
