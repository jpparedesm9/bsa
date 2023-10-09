use cobis
go

declare @w_id_etiqueta   int,
        @w_id_mod_grupo  int,
        @w_id_modulo     int,
        @w_id_componente int,
        @w_id_pagina     int,
        @w_id_zona       int,
        @w_id_pag_zona   int,
        @w_rol           smallint,
        @w_servidor      varchar(100),
        @w_ubicacion     varchar(255)

-- En el momento de la instalacion, se debe cambiar esta direccion a la que usa el cliente.
select @w_servidor = inst_ip_co from platform_installer

-- Traigo el rol ADMINISTRADOR WORKFLOW
if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
	select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
	insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
	values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

delete an_role_page
 where rp_rol = @w_rol
  and  rp_pa_id in (select pa_id from an_page
                    where pa_prod_name = 'M-WKF')

delete an_role_component
 where rc_rol = @w_rol
   and rc_co_id in (select co_id from an_component
                   where co_name like '%WorkFlow%')
                 
delete an_role_module
 where rm_rol    = @w_rol
   and rm_mo_id  in (select mo_id from an_module
 					 where mo_filename like '%WorkFlow%')
                   
delete an_role_component
 where rc_co_id = 1
   and rc_rol   = @w_rol


-- INSERCION DE ETIQUETAS
delete from an_label
 where la_prod_name = 'M-WKF'

select @w_id_etiqueta = max(la_id) + 1
  from an_label

-- EDITOR
insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta, 'EN_US', 'Workflow', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta, 'ES_EC', 'Workflow', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 1, 'EN_US', 'Editor', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 1, 'ES_EC', 'Editor', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 4, 'EN_US', 'Job Distributors Management', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 4, 'ES_EC', 'Mantenimiento de Distribuidores de Carga', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 6, 'EN_US', 'Users Management', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 6, 'ES_EC', 'Mantenimiento de Usuarios', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 7, 'EN_US', 'Business Roles Management', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 7, 'ES_EC', 'Mantenimiento de Roles de Negocio', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 8, 'EN_US', 'Activities Management', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 8, 'ES_EC', 'Mantenimiento de Actividades', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 9, 'EN_US', 'Options Management', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 9, 'ES_EC', 'Mantenimiento de Acciones', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 10, 'EN_US', 'Documents Kind Management', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 10, 'ES_EC', 'Mantenimiento de Tipos de Documento', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 13, 'EN_US', 'Observations Kind Management', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 13, 'ES_EC', 'Mantenimiento de Tipos de Observación', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 14, 'EN_US', 'Requisite Kind Management', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 14, 'ES_EC', 'Mantenimiento de Tipos de Requisito', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 16, 'EN_US', 'Business Process Management', 'M-WKF')

insert into an_label
       (la_id, la_cod, la_label, la_prod_name)
values (@w_id_etiqueta + 16, 'ES_EC', 'Mantenimiento de Procesos de Negocio', 'M-WKF')


-- INSERCION DE MODULOS - GRUPO
delete from an_module_group
 where mg_name in ('Workflow', 'Editor', 'MantAtribuciones', 'MantAtributos', 'MantDistCarga',
                   'MantPrograma', 'MantUsuario', 'MantRol', 'MantActividad', 'MantOpcion',
                   'MantTipDoc', 'MantTipExc', 'MantTipIns', 'MantTipObs', 'MantTipReq',
                   'MantVariable', 'MantProcesos')

select @w_id_mod_grupo = max(mg_id) + 1
  from an_module_group

-- EDITOR
select @w_ubicacion = 'http://' + @w_servidor + '/Workflow/Workflow.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo, 'Workflow', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/Editor/Editor.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 1, 'Editor', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/MantDistCarga/MantDistCarga.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 4, 'MantDistCarga', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/MantUsuario/MantUsuario.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 6, 'MantUsuario', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/MantRol/MantRol.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 7, 'MantRol', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/MantActividad/MantActividad.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 8, 'MantActividad', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/MantOpcion/MantOpcion.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 9, 'MantOpcion', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/MantTipDoc/MantTipDoc.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 10, 'MantTipDoc', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/MantTipObs/MantTipObs.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 13, 'MantTipObs', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/MantTipReq/MantTipReq.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 14, 'MantTipReq', '1.0.0.0', @w_ubicacion, 'M-WKF')

select @w_ubicacion = 'http://' + @w_servidor + '/MantProcesos/MantProcesos.application'
insert into an_module_group
       (mg_id, mg_name, mg_version, mg_location, mg_store_name)
values (@w_id_mod_grupo + 16, 'MantProcesos', '1.0.0.0', @w_ubicacion, 'M-WKF')

-- INSERCION DE MODULO
delete from an_module
 where mo_filename like '%WorkFlow%'

select @w_id_modulo = max(mo_id) + 1
  from an_module

-- EDITOR

insert into an_module
       (mo_id, mo_mg_id, mo_la_id, mo_name,
        mo_filename, mo_id_parent, mo_key_token)
values (@w_id_modulo + 2, @w_id_mod_grupo + 4, @w_id_etiqueta + 4, 'Mantenimiento de Distribuidores de Carga',
        'COBISCorp.tCOBIS.WorkFlow.funDistCarga.dll', 0, null)

insert into an_module
       (mo_id, mo_mg_id, mo_la_id, mo_name,
        mo_filename, mo_id_parent, mo_key_token)
values (@w_id_modulo + 4, @w_id_mod_grupo + 6, @w_id_etiqueta + 6, 'Mantenimiento de Usuarios',
        'COBISCorp.tCOBIS.WorkFlow.funUsuariosWF.dll', 0, null)

insert into an_module
       (mo_id, mo_mg_id, mo_la_id, mo_name,
        mo_filename, mo_id_parent, mo_key_token)
values (@w_id_modulo + 5, @w_id_mod_grupo + 7, @w_id_etiqueta + 7, 'Mantenimiento de Roles',
        'COBISCorp.tCOBIS.WorkFlow.funRoles.dll', 0, null)

insert into an_module
       (mo_id, mo_mg_id, mo_la_id, mo_name,
        mo_filename, mo_id_parent, mo_key_token)
values (@w_id_modulo + 6, @w_id_mod_grupo + 8, @w_id_etiqueta + 8, 'Mantenimiento de Actividades',
        'COBISCorp.tCOBIS.WorkFlow.funActividades.dll', 0, null)

insert into an_module
       (mo_id, mo_mg_id, mo_la_id, mo_name,
        mo_filename, mo_id_parent, mo_key_token)
values (@w_id_modulo + 7, @w_id_mod_grupo + 9, @w_id_etiqueta + 9, 'Mantenimiento de Acciones',
        'COBISCorp.tCOBIS.WorkFlow.funResultados.dll', 0, null)

insert into an_module
       (mo_id, mo_mg_id, mo_la_id, mo_name,
        mo_filename, mo_id_parent, mo_key_token)
values (@w_id_modulo + 8, @w_id_mod_grupo + 10, @w_id_etiqueta + 10, 'Mantenimiento de Tipos de Documento',
        'COBISCorp.tCOBIS.WorkFlow.funDocumentos.dll', 0, null)

insert into an_module
       (mo_id, mo_mg_id, mo_la_id, mo_name,
        mo_filename, mo_id_parent, mo_key_token)
values (@w_id_modulo + 11, @w_id_mod_grupo + 13, @w_id_etiqueta + 13, 'Mantenimiento de Tipos de Observacion',
        'COBISCorp.tCOBIS.WorkFlow.funObservaciones.dll', 0, null)

insert into an_module
       (mo_id, mo_mg_id, mo_la_id, mo_name,
        mo_filename, mo_id_parent, mo_key_token)
values (@w_id_modulo + 12, @w_id_mod_grupo + 14, @w_id_etiqueta + 14, 'Mantenimiento de Tipos de Requisito',
        'COBISCorp.tCOBIS.WorkFlow.funTipoDoc.dll', 0, null)

insert into an_module
       (mo_id, mo_mg_id, mo_la_id, mo_name,
        mo_filename, mo_id_parent, mo_key_token)
values (@w_id_modulo + 14, @w_id_mod_grupo + 16, @w_id_etiqueta + 16, 'Mantenimiento de Procesos',
        'COBISCorp.tCOBIS.WorkFlow.funProcesos.dll', 0, null)

-- INSERCION DE COMPONENTES
delete from an_component
 where co_name like '%WorkFlow%'

select @w_id_componente = max(co_id) + 1
  from an_component

-- EDITOR
insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 4, @w_id_modulo + 2, 'COBISCorp.tCOBIS.WorkFlow.funDistCarga.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funDistCarga', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 5, @w_id_modulo + 2, 'COBISCorp.tCOBIS.WorkFlow.funDistCarga.MantDistCargaClass', 'MantDistCargaClass', 'COBISCorp.tCOBIS.WorkFlow.funDistCarga', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 6, @w_id_modulo + 3, 'COBISCorp.tCOBIS.WorkFlow.funProgramasWF.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funProgramasWF', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 8, @w_id_modulo + 3, 'COBISCorp.tCOBIS.WorkFlow.funProgramasWF.GridDatosWFClass', 'GridDatosWFClass', 'COBISCorp.tCOBIS.WorkFlow.funProgramasWF', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 9, @w_id_modulo + 3, 'COBISCorp.tCOBIS.WorkFlow.funProgramasWF.MantParametroClass', 'MantParametroClass', 'COBISCorp.tCOBIS.WorkFlow.funProgramasWF', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 10, @w_id_modulo + 4, 'COBISCorp.tCOBIS.WorkFlow.funUsuariosWF.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funUsuariosWF', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 11, @w_id_modulo + 4, 'COBISCorp.tCOBIS.WorkFlow.funUsuariosWF.GridDatosWFClass', 'GridDatosWFClass', 'COBISCorp.tCOBIS.WorkFlow.funUsuariosWF', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 12, @w_id_modulo + 4, 'COBISCorp.tCOBIS.WorkFlow.funUsuariosWF.MantUsuarioClass', 'MantUsuarioClass', 'COBISCorp.tCOBIS.WorkFlow.funUsuariosWF', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 13, @w_id_modulo + 5, 'COBISCorp.tCOBIS.WorkFlow.funRoles.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funRoles', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 14, @w_id_modulo + 5, 'COBISCorp.tCOBIS.WorkFlow.funRoles.GridDatosWFWFClass', 'GridDatosWFWFClass', 'COBISCorp.tCOBIS.WorkFlow.funRoles', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 15, @w_id_modulo + 5, 'COBISCorp.tCOBIS.WorkFlow.funRoles.MantRolClass', 'MantRolClass', 'COBISCorp.tCOBIS.WorkFlow.funRoles', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 16, @w_id_modulo + 6, 'COBISCorp.tCOBIS.WorkFlow.funActividades.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funActividades', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 17, @w_id_modulo + 6, 'COBISCorp.tCOBIS.WorkFlow.funActividades.MantActividadWFClass', 'MantActividadWFClass', 'COBISCorp.tCOBIS.WorkFlow.funActividades', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 18, @w_id_modulo + 7, 'COBISCorp.tCOBIS.WorkFlow.funResultados.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funResultados', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 19, @w_id_modulo + 7, 'COBISCorp.tCOBIS.WorkFlow.funResultados.MantResultadoClass', 'MantResultadoClass', 'COBISCorp.tCOBIS.WorkFlow.funResultados', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 20, @w_id_modulo + 8, 'COBISCorp.tCOBIS.WorkFlow.funDocumentos.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funDocumentos', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 21, @w_id_modulo + 8, 'COBISCorp.tCOBIS.WorkFlow.funDocumentos.MantDocumentoClass', 'MantDocumentoClass', 'COBISCorp.tCOBIS.WorkFlow.funDocumentos', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 26, @w_id_modulo + 11, 'COBISCorp.tCOBIS.WorkFlow.funObservaciones.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funObservaciones', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 27, @w_id_modulo + 11, 'COBISCorp.tCOBIS.WorkFlow.funObservaciones.MantObservacionClass', 'MantObservacionClass', 'COBISCorp.tCOBIS.WorkFlow.funObservaciones', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 28, @w_id_modulo + 12, 'COBISCorp.tCOBIS.WorkFlow.funTipoDoc.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funTipoDoc', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 29, @w_id_modulo + 12, 'COBISCorp.tCOBIS.WorkFlow.funTipoDoc.MantTipoDocClass', 'MantTipoDocClass', 'COBISCorp.tCOBIS.WorkFlow.funTipoDoc', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 30, @w_id_modulo + 13, 'COBISCorp.tCOBIS.WorkFlow.funVariables.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funVariables', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 32, @w_id_modulo + 14, 'COBISCorp.tCOBIS.WorkFlow.funProcesos.GraficoWFClass', 'GraficoWFClass', 'COBISCorp.tCOBIS.WorkFlow.funProcesos', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 33, @w_id_modulo + 14, 'COBISCorp.tCOBIS.WorkFlow.funProcesos.GridDatosWFClass', 'GridDatosWFClass', 'COBISCorp.tCOBIS.WorkFlow.funProcesos', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 34, @w_id_modulo + 14, 'COBISCorp.tCOBIS.WorkFlow.funProcesos.MantProcesoClass', 'MantProcesoClass', 'COBISCorp.tCOBIS.WorkFlow.funProcesos', 'CC', 'TipoFrame=1;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

insert into an_component
       (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
values (@w_id_componente + 35, @w_id_modulo + 14, 'COBISCorp.tCOBIS.WorkFlow.funProcesos.ArbolMenuWFClass', 'ArbolMenuWFClass', 'COBISCorp.tCOBIS.WorkFlow.funProcesos', 'CC', 'TipoFrame=2;TamPantalla=10;TipoFrame1FA2F=2', 'M-WKF')

-- INSERCION DE PAGINAS
delete from an_page_zone
 where pz_pa_id in (select pa_id from an_page
                     where pa_prod_name = 'M-WKF')

delete from an_page
 where pa_name in ('Workflow', 'EditorWorkflow', 'MantDistCarga', 'MantDistCarga',
                   'MantUsuarios', 'MantRoles', 'MantActividad', 'MantOpciones', 'MantDocumentos',
                   'MantObservaciones', 'MantRequisitos', 'MantProcesos')

select @w_id_pagina = max(pa_id) + 1
  from an_page

-- EDITOR

--Tabla an_page
declare @w_parent_id int
select @w_parent_id = 0
select @w_parent_id = pa_id from cobis..an_page where pa_la_id  = ( select isnull(la_id,0) from cobis..an_label where la_label = 'Procesos Back Office')

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina, @w_id_etiqueta, 'Workflow', 'icono pagina', @w_parent_id, 0, 'vertical', 'Nemonic', 'M-WKF', null)

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina + 1, @w_id_etiqueta + 1, 'EditorWorkflow', 'icono pagina', @w_id_pagina, 1, 'vertical', 'Nemonic', 'M-WKF', null)

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina + 4, @w_id_etiqueta + 4, 'MantDistCarga', 'icono pagina', @w_id_pagina + 1, 6, 'ninguno', 'Nemonic', 'M-WKF', null)

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina + 6, @w_id_etiqueta + 6, 'MantUsuarios', 'icono pagina', @w_id_pagina + 1, 9, 'ninguno', 'Nemonic', 'M-WKF', null)

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina + 7, @w_id_etiqueta + 7, 'MantRoles', 'icono pagina', @w_id_pagina + 1, 10, 'ninguno', 'Nemonic', 'M-WKF', 'TIPO_ROL=BUSINESS')


insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina + 8, @w_id_etiqueta + 8, 'MantActividad', 'icono pagina', @w_id_pagina + 1, 1, 'ninguno', 'Nemonic', 'M-WKF', null)

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina + 9, @w_id_etiqueta + 9, 'MantOpciones', 'icono pagina', @w_id_pagina + 1, 3, 'ninguno', 'Nemonic', 'M-WKF', null)

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_visible)
values (@w_id_pagina + 10, @w_id_etiqueta + 10, 'MantDocumentos', 'icono pagina', @w_id_pagina + 1, 4, 'ninguno', 'Nemonic', 'M-WKF', null, 0)

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina + 13, @w_id_etiqueta + 13, 'MantObservaciones', 'icono pagina', @w_id_pagina + 1, 8, 'ninguno', 'Nemonic', 'M-WKF', null)

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina + 14, @w_id_etiqueta + 14, 'MantRequisitos', 'icono pagina', @w_id_pagina + 1, 5, 'ninguno', 'Nemonic', 'M-WKF', null)

insert into an_page
       (pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order,
        pa_splitter, pa_nemonic, pa_prod_name, pa_arguments)
values (@w_id_pagina + 16, @w_id_etiqueta + 16, 'MantProcesos', 'icono pagina', @w_id_pagina + 1, 11, 'ninguno', 'Nemonic', 'M-WKF', 'TIPO_PROCESO=BUSINESS')



-- INSERCION DE ZONAS
delete from an_page_zone where pz_zo_id in (select zo_id from an_zone
                                             where zo_name in ('MantAtribuciones', 'MantAtributos', 'MantDistCarga', 'MantProgramas', 'MantUsuarios',
                                                               'MantRoles', 'MantActividad', 'MantOpciones', 'MantDocumentos', 'MantExcepciones',
                                                               'MantIntrucciones', 'MantObservaciones', 'MantRequisitos', 'MantVariables', 'MantProcesos'))

delete from an_zone
 where zo_name in ('MantAtribuciones', 'MantAtributos', 'MantDistCarga', 'MantProgramas', 'MantUsuarios',
                   'MantRoles', 'MantActividad', 'MantOpciones', 'MantDocumentos', 'MantExcepciones',
                   'MantIntrucciones', 'MantObservaciones', 'MantRequisitos', 'MantVariables', 'MantProcesos')

select @w_id_zona = max(zo_id) + 1
  from an_zone

-- EDITOR

insert into an_zone
       (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
values (@w_id_zona + 2, 'MantDistCarga', 1, 0, 0, 1)

insert into an_zone
       (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
values (@w_id_zona + 4, 'MantUsuarios', 1, 0, 0, 1)

insert into an_zone
       (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
values (@w_id_zona + 5, 'MantRoles', 1, 0, 0, 1)

insert into an_zone
       (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
values (@w_id_zona + 6, 'MantActividad', 1, 0, 0, 1)

insert into an_zone
       (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
values (@w_id_zona + 7, 'MantOpciones', 1, 0, 0, 1)

insert into an_zone
       (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
values (@w_id_zona + 8, 'MantDocumentos', 1, 0, 0, 1)

insert into an_zone
       (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
values (@w_id_zona + 11, 'MantObservaciones', 1, 0, 0, 1)

insert into an_zone
       (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
values (@w_id_zona + 12, 'MantRequisitos', 1, 0, 0, 1)

insert into an_zone
       (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value)
values (@w_id_zona + 14, 'MantProcesos', 1, 0, 0, 1)



-- INSERCION DE PAGINAS DE UNA ZONA
-- EDITOR
select @w_id_pag_zona = max(pz_id) + 1
  from an_page_zone

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 2, @w_id_zona + 2, @w_id_etiqueta + 4, @w_id_pagina + 4, @w_id_componente + 4,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 3, @w_id_zona + 3, @w_id_etiqueta + 5, @w_id_pagina + 5, @w_id_componente + 6,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 4, @w_id_zona + 4, @w_id_etiqueta + 6, @w_id_pagina + 6, @w_id_componente + 10,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 5, @w_id_zona + 5, @w_id_etiqueta + 7, @w_id_pagina + 7, @w_id_componente + 13,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 6, @w_id_zona + 6, @w_id_etiqueta + 8, @w_id_pagina + 8, @w_id_componente + 16,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 7, @w_id_zona + 7, @w_id_etiqueta + 9, @w_id_pagina + 9, @w_id_componente + 18,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 8, @w_id_zona + 8, @w_id_etiqueta + 10, @w_id_pagina + 10, @w_id_componente + 20,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 11, @w_id_zona + 11, @w_id_etiqueta + 13, @w_id_pagina + 13, @w_id_componente + 26,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 12, @w_id_zona + 12, @w_id_etiqueta + 14, @w_id_pagina + 14, @w_id_componente + 28,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 13, @w_id_zona + 13, @w_id_etiqueta + 15, @w_id_pagina + 15, @w_id_componente + 30,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)

insert into an_page_zone
       (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size,
        pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional)
values (@w_id_pag_zona + 14, @w_id_zona + 14, @w_id_etiqueta + 16, @w_id_pagina + 16, @w_id_componente + 35,
        1, 100, 100, 'Ninguno', 'vertical', 0, 1)
	

-- INSERCION DE COMPONENTES ASOCIADOS A UN ROL

-- CEN
delete from an_role_component where rc_co_id = 1 and rc_rol = @w_rol
insert into an_role_component (rc_co_id, rc_rol) values (1, @w_rol)

-- EDITOR

delete from an_role_component where rc_co_id = @w_id_componente + 4 
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 4, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 5
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 5, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 6
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 6, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 7
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 7, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 8
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 8, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 9
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 9, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 10
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 10, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 11
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 11, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 12
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 12, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 13
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 13, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 14
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 14, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 15
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 15, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 16
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 16, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 17
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 17, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 18
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 18, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 19
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 19, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 20
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 20, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 21
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 21, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 26
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 26, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 27
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 27, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 28
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 28, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 29
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 29, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 30
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 30, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 31
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 31, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 32
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 32, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 33
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 33, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 34
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 34, @w_rol)

delete from an_role_component where rc_co_id = @w_id_componente + 35
insert into an_role_component
       (rc_co_id, rc_rol)
values (@w_id_componente + 35, @w_rol)

-- INSERCION DE MODULOS ASOCIADOS A UN ROL
-- CEN

-- EDITOR

delete from an_role_module where rm_mo_id = @w_id_modulo + 2
insert into an_role_module
       (rm_mo_id, rm_rol) 
values (@w_id_modulo + 2, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 3
insert into an_role_module 
       (rm_mo_id, rm_rol) 
values (@w_id_modulo + 3, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 4
insert into an_role_module
       (rm_mo_id, rm_rol)
values (@w_id_modulo + 4, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 5
insert into an_role_module
       (rm_mo_id, rm_rol)
values (@w_id_modulo + 5, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 6
insert into an_role_module
       (rm_mo_id, rm_rol)
values (@w_id_modulo + 6, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 7
insert into an_role_module
       (rm_mo_id, rm_rol)
values (@w_id_modulo + 7, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 8
insert into an_role_module
       (rm_mo_id, rm_rol)
values (@w_id_modulo + 8, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 11
insert into an_role_module
       (rm_mo_id, rm_rol)
values (@w_id_modulo + 11, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 12
insert into an_role_module
       (rm_mo_id, rm_rol)
values (@w_id_modulo + 12, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 13
insert into an_role_module
       (rm_mo_id, rm_rol)
values (@w_id_modulo + 13, @w_rol)

delete from an_role_module where rm_mo_id = @w_id_modulo + 14
insert into an_role_module
       (rm_mo_id, rm_rol)
values (@w_id_modulo + 14, @w_rol)

-- INSERCION DE PAGINAS ASOCIADAS A UN ROL

-- EDITOR
delete from an_role_page where rp_pa_id = @w_id_pagina
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 1
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 1, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 4
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 4, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 5
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 5, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 6
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 6, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 7
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 7, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 8
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 8, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 9
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 9, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 10
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 10, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 13
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 13, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 14
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 14, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 15
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 15, @w_rol)

delete from an_role_page where rp_pa_id = @w_id_pagina + 16
insert into an_role_page
       (rp_pa_id, rp_rol)
values (@w_id_pagina + 16, @w_rol)


-- INSERCION DE ZONAS DE NAVEGACION AL ROL WORKFLOW

delete from an_role_navigation_zone
 where rn_rol = @w_rol

insert into an_role_navigation_zone
       (rn_rol, rn_nz_id)
values (@w_rol, 1)

insert into an_role_navigation_zone
       (rn_rol, rn_nz_id)
values (@w_rol, 2)

insert into an_role_navigation_zone
       (rn_rol, rn_nz_id)
values (@w_rol, 3)
go
