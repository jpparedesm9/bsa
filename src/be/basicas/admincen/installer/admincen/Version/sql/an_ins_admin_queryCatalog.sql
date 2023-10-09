/*************************************************************************/
/*  Archivo:        an_ins_admin_queryCatalog.sql                        */
/*  Base de datos:  cobis                                                */
/*  Producto:       COBIS Explorer . Net                                 */
/*************************************************************************/
/*                              IMPORTANTE                               */
/*  Este programa es parte de los paquetes bancarios propiedad de        */
/*  Cobiscorp.                                                           */
/*  Su uso no autorizado queda expresamente prohibido asi como cualquier */
/*  alteracion o agregado hecho por alguno de sus usuarios sin el debido */
/*  consentimiento por escrito de la Presidencia Ejecutiva de Cobiscorpo */
/*  su representante.                                                    */
/*************************************************************************/
/*                              PROPOSITO                                */
/*  Insercion de datos iniciales en las estructuras de CEN requeridos    */
/*  para las opcines de Admin para el funcionamietno de Query Catalog    */
/*************************************************************************/
/*                            MODIFICACIONES                             */
/*  FECHA       AUTOR       RAZON                                        */
/* 17/may/2010  C. Guevara  Emision Inicial                              */
/* 29/nov/2010  C. Guevara  Actualizacion a ver 4.0.0.0 y nuevo namespace*/
/*************************************************************************/
use cobis
go
--Variables de uso general
declare @w_id int
declare @w_label_id int

--ELIMINACION DE DATOS PREVIOS
print 'Eliminacion de Datos Previos de Query Catalog de Admin'
delete an_query where qu_query_id in (select qc_id from an_query_component where qc_interface_full_name like 'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.%') 
delete an_query_column where cl_query_id in (select qc_id from an_query_component where qc_interface_full_name like 'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.%') 
delete an_query_action where qa_query_id in (select qc_id from an_query_component where qc_interface_full_name like 'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.%') 
delete an_query_component where qc_interface_full_name like 'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.%'


print 'Registro de datos para Query Catalog para LABEL'
--Ingreso de datos a la tabla an_query_component de LABEL
select  @w_id = isnull (max(qc_id),0)+1 from an_query_component
insert into an_query_component values(@w_id,'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.IBLILabelConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0,Culture=neutral,PublicKeyToken=9b8bba00b1313138','COBISCorp.eCOBIS.Admin.AdminCEN.BLI.Impl.BLILabelConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query de LABEL

insert into an_query values(@w_id,'catalog an_label','COBISCorp.eCOBIS.Admin.AdminCEN.DTO.Catalog,COBISCorp.eCOBIS.Admin.AdminCEN.DTO,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query_column de LABEL
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','ID ETIQUETA','CEN')
insert into an_query_column values(@w_id,1,@w_label_id,'N','Id',20,0,1,0, null)
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','NOMBRE ETIQUETA','CEN')
insert into an_query_column values(@w_id,2,@w_label_id,'S','Name',20,0,0,1, null)
--Ingreso de datos a la tabla an_query_action de LABEL
insert into an_query_action values(@w_id,1,0,'QueryLabelAll',@w_id)
insert into an_query_action values(@w_id,2,1,'QueryLabelId',@w_id)

print 'Registro de datos para Query Catalog para ROL'
--Ingreso de datos a la tabla an_query_component de ROL
select  @w_id = isnull (max(qc_id),0)+1 from an_query_component
insert into an_query_component values(@w_id,'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.IBLIRolConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0,Culture=neutral,PublicKeyToken=9b8bba00b1313138','COBISCorp.eCOBIS.Admin.AdminCEN.BLI.Impl.BLIRolConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query de ROL
insert into an_query values(@w_id,'catalog ad_rol','COBISCorp.eCOBIS.Admin.AdminCEN.DTO.Catalog,COBISCorp.eCOBIS.Admin.AdminCEN.DTO,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query_column de ROL
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','ID ROL','CEN')
insert into an_query_column values(@w_id,1,@w_label_id,'N','Id',20,0,1,0, null)
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','NOMBRE ROL','CEN')
insert into an_query_column values(@w_id,2,@w_label_id,'S','Name',20,0,0,1, null)
--Ingreso de datos a la tabla an_query_action de ROL
insert into an_query_action values(@w_id,1,0,'QueryRolAll',@w_id)
insert into an_query_action values(@w_id,2,1,'QueryRolId',@w_id)

print 'Registro de datos para Query Catalog para MODULE'
--Ingreso de datos a la tabla an_query_component de MODULE
select  @w_id = isnull (max(qc_id),0)+1 from an_query_component
insert into an_query_component values(@w_id,'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.IBLIModuleConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0,Culture=neutral,PublicKeyToken=9b8bba00b1313138','COBISCorp.eCOBIS.Admin.AdminCEN.BLI.Impl.BLIModuleConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query de MODULE
insert into an_query values(@w_id,'catalog an_module','COBISCorp.eCOBIS.Admin.AdminCEN.DTO.Catalog,COBISCorp.eCOBIS.Admin.AdminCEN.DTO,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query_column de MODULE
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','ID MODULO','CEN')
insert into an_query_column values(@w_id,1,@w_label_id,'N','Id',20,0,1,0, null)
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','NOMBRE MODULO','CEN')
insert into an_query_column values(@w_id,2,@w_label_id,'S','Name',20,0,0,1, null)
--Ingreso de datos a la tabla an_query_action de MODULE
insert into an_query_action values(@w_id,1,0,'QueryModuleAll',@w_id)
insert into an_query_action values(@w_id,2,1,'QueryModuleId',@w_id)

print 'Registro de datos para Query Catalog para MODULE GROUP'
--Ingreso de datos a la tabla an_query_component de MODULE GROUP
select  @w_id = isnull (max(qc_id),0)+1 from an_query_component
insert into an_query_component values(@w_id,'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.IBLIModuleGroupConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0,Culture=neutral,PublicKeyToken=9b8bba00b1313138','COBISCorp.eCOBIS.Admin.AdminCEN.BLI.Impl.BLIModuleGroupConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query de MODULE GROUP
insert into an_query values(@w_id,'catalog an_module_group','COBISCorp.eCOBIS.Admin.AdminCEN.DTO.Catalog,COBISCorp.eCOBIS.Admin.AdminCEN.DTO,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query_column de MODULE GROUP
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','ID GROUPO DE MODULO','CEN')
insert into an_query_column values(@w_id,1,@w_label_id,'N','Id',20,0,1,0, null)
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','NOMBRE DE GROUPO DE MODULO','CEN')
insert into an_query_column values(@w_id,2,@w_label_id,'S','Name',20,0,0,1, null)
--Ingreso de datos a la tabla an_query_action de MODULE GROUP
insert into an_query_action values(@w_id,1,0,'QueryModuleGroupAll',@w_id)
insert into an_query_action values(@w_id,2,1,'QueryModuleGroupId',@w_id)

print 'Registro de datos para Query Catalog para PAGE'
--Ingreso de datos a la tabla an_query_component de PAGE
select  @w_id = isnull (max(qc_id),0)+1 from an_query_component
insert into an_query_component values(@w_id,'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.IBLIPageConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0,Culture=neutral,PublicKeyToken=9b8bba00b1313138','COBISCorp.eCOBIS.Admin.AdminCEN.BLI.Impl.BLIPageConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query de PAGE
insert into an_query values(@w_id,'catalog an_page','COBISCorp.eCOBIS.Admin.AdminCEN.DTO.Catalog,COBISCorp.eCOBIS.Admin.AdminCEN.DTO,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query_column de PAGE
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','ID PAGINA','CEN')
insert into an_query_column values(@w_id,1,@w_label_id,'N','Id',20,0,1,0, null)
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','NOMBRE PAGINA','CEN')
insert into an_query_column values(@w_id,2,@w_label_id,'S','Name',20,0,0,1, null)
--Ingreso de datos a la tabla an_query_action de PAGE
insert into an_query_action values(@w_id,1,0,'QueryPageAll',@w_id)
insert into an_query_action values(@w_id,2,1,'QueryPageId',@w_id)

print 'Registro de datos para Query Catalog de COMPONENT'
--Ingreso de datos a la tabla an_query_component de COMPONENT
select  @w_id = isnull (max(qc_id),0)+1 from an_query_component
insert into an_query_component values(@w_id,'COBISCorp.eCOBIS.Admin.AdminCEN.BLI.IBLIComponentConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0,Culture=neutral,PublicKeyToken=9b8bba00b1313138','COBISCorp.eCOBIS.Admin.AdminCEN.BLI.Impl.BLIComponentConfigService,COBISCorp.eCOBIS.Admin.AdminCEN.BLI,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query de COMPONENT
insert into an_query values(@w_id,'catalog an_component','COBISCorp.eCOBIS.Admin.AdminCEN.DTO.Catalog,COBISCorp.eCOBIS.Admin.AdminCEN.DTO,Version=4.0.0.0, Culture=neutral, PublicKeyToken=9b8bba00b1313138')
--Ingreso de datos a la tabla an_query_column de COMPONENT
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','ID COMPONENTE','CEN')
insert into an_query_column values(@w_id,1,@w_label_id,'N','Id',20,0,1,0, null)
select  @w_label_id = isnull (max(la_id),0)+1 from an_label
insert into an_label values(@w_label_id,'ES_EC','NOMBRE COMPONENTE','CEN')
insert into an_query_column values(@w_id,2,@w_label_id,'S','Name',20,0,0,1, null)
--Ingreso de datos a la tabla an_query_action de COMPONENT
insert into an_query_action values(@w_id,1,0,'QueryComponentAll',@w_id)
insert into an_query_action values(@w_id,2,1,'QueryComponentId',@w_id)

print 'Instalación de Query Catalog Finalizada'
go
