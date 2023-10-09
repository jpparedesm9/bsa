/************************************************************************/
/*  Archivo:        an_segur.sql                                        */
/*  Base de datos:  cobis                                               */
/*  Producto:       COBIS Explorer . Net                                */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  Cobiscorp.                                                          */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.              */
/************************************************************************/
/*                            PROPOSITO                                 */
/*  Seguridades de COBIS Explorer . Net, autorizacion de                */
/*  transacciones.                                                      */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*  FECHA       AUTOR       RAZON                                       */
/* 27/jul/2009  S. Paredes  Emision Inicial                             */
/* 19/NOV/2009  S. Paredes  Agregar trn autorizadas                     */
/* 05/mar/2010  S. Paredes  Agrega manejo de pseudocatalogo             */
/* 12/Mar/2010  S. Soto     Incorporacion de seguridades de Admin Net   */ 
/* 16/mar/2010  S. Paredes  Agrega manejo de agentes                    */
/* 12/Jun/2013	P. Romero   Se autoriza trns a MENU POR PROCESOS,       */
/*							por defecto                                 */ 
/* 13/ABR/2016 ELO         Migracion SYBASE-SQLServer FAL               */
/* 24/Jun/2016 J.Hdez      Ajuste Vesion Falabella                      */
/************************************************************************/

use cobis
go

print 'Creacion de Stored Procedures en ad_procedure'
go

if exists (select * from ad_procedure
            where pd_procedure between 5176 and 5206)
   delete ad_procedure where pd_procedure between 5176 and 5206
go

--Stored Procedures Basicos de CEN
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5176, 'sp_page_an', 'cobis', 'V', getdate(), 'page_an.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5177, 'sp_page_rol_an', 'cobis', 'V', getdate(), 'page_rol_an.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5178, 'sp_label_an', 'cobis', 'V', getdate(), 'label_an.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5179, 'sp_get_list_nodes_parents', 'cobis', 'V', getdate(), 'get_list_no.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5180, 'sp_prereq_page', 'cobis', 'V', getdate(), 'prereq_page.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5181, 'sp_verify_authorized_page', 'cobis', 'V', getdate(), 'verify_auth.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5182, 'sp_get_authorized_modules', 'cobis', 'V', getdate(), 'get_authori.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5183, 'sp_get_autho_navi_zones', 'cobis', 'V', getdate(), 'get_autho_n.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5184, 'sp_get_authorized_pages', 'cobis', 'V', getdate(), 'get_author1.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5185, 'sp_get_authorized_zones', 'cobis', 'V', getdate(), 'get_author2.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5186, 'sp_consult_role_exe', 'cobis', 'V', getdate(), 'consult_rol.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5187, 'sp_query_catalog_config', 'cobis', 'V', getdate(), 'query_catal.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo)
values (5188,'sp_get_authorized_agents','cobis','V',getdate(),'get_author3.sp')
go
--Stored Procedures de Admin NET
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5194, 'sp_module_group_dml', 'cobis', 'V', getdate(), 'module_grou.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5195, 'sp_label_dml', 'cobis', 'V', getdate(), 'label_dml.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5196, 'sp_module_dml', 'cobis', 'V', getdate(), 'module_dml.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5197, 'sp_component_dml', 'cobis', 'V', getdate(), 'component_d.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5198, 'sp_role_module_dml', 'cobis', 'V', getdate(), 'role_module.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5199, 'sp_role_navigation_zone_dml', 'cobis', 'V', getdate(), 'role_naviga.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5200, 'sp_page_dml', 'cobis', 'V', getdate(), 'page_dml.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5201, 'sp_page_zone_dml', 'cobis', 'V', getdate(), 'page_zone_d.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5202, 'sp_role_component_dml', 'cobis', 'V', getdate(), 'role_compon.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5203, 'sp_prereq_page_dml', 'cobis', 'V', getdate(), 'prereq_page.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5204, 'sp_role_page_dml', 'cobis', 'V', getdate(), 'role_page_d.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5205, 'sp_navigation_zone_dml', 'cobis', 'V', getdate(), 'navigation.sp')
go
insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (5206, 'sp_user_role_exe_dml', 'cobis', 'V', getdate(), 'user_role_e.sp')
go


if exists (select 1 from ad_procedure
            where pd_stored_procedure = 'sp_grupo')
   delete ad_procedure where pd_stored_procedure = 'sp_grupo'
go

declare @w_tran_tmp int 

select @w_tran_tmp = max(pd_procedure) from ad_procedure
select @w_tran_tmp = @w_tran_tmp + 1 

insert into ad_procedure (pd_procedure, pd_stored_procedure,pd_base_datos, pd_estado, pd_fecha_ult_mod, pd_archivo) 
values (@w_tran_tmp, 'sp_grupo', 'cobis', 'V', getdate(), 'grupo.sp')
go

print 'Creacion de Transacciones en cl_ttransaccion'
go

if exists (select 1 from cl_ttransaccion
            where tn_trn_code between 15300 and   15386)
   delete cl_ttransaccion
    where tn_trn_code between   15300 and   15386 and tn_trn_code not in  (15303, 15304, 15309)
go

--Transacciones Basicas de CEN
insert into cl_ttransaccion(tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15300,'BUSQUEDA DE PAGINAS','BUSPAG','BUSQUEDA DE PAGINAS ADMIN NET')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15301,'VERIFICACION DE PAGINAS','VERPAG','VERIFICA SI SE TIENE AUTORIZACION PARA UNA PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15302,'CONSULTA DE AGENTES AUTORIZADOS','CONAGE','CONSULTA DE AGENTES AUTORIZADOS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15305,'INSERCION DE LABEL','INSLAB','INSERCION DE LABEL EN ADMIN NET')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15306,'ACTUALIZACION DE LABEL','ACTLAB','ACTUALIZACION DE LABEL EN ADMIN NET')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15307,'ELIMINACION DE LABEL','DELABE','ELIMINACION DE LABEL EN ADMIN NET')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15308,'SEARCH DE LABEL','BUSLAB','BUSQUEDA DE LABEL EN ADMIN NET')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15310,'BUSQUEDA DE PAGINAS POR ROL','BUSPAG','BUSQUEDA DE PAGINAS ASIGNADAS A ROL EN ADMIN NET')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15311,'ASIGNACION DE PAGINAS A ROLES','ASIGPA','ASIGNACION DE PAGINAS A ROLES')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15312,'DESASIGNACION DE PAGINAS A ROLES','DESPAG','DESASIGNACION DE PAGINAS A ROLES')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15315,'BUSQUEDA DE MODULOS AUTORIZADOS','MODAUT','CONSULTA LOS MODULOS AUTORIZADOS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15316,'BUSQUEDA DE ZONAS DE NAVEGACION AUTORIZADOS','ZNAAUT','CONSULTA LAS ZONAS DE NAVEGACION AUTORIZADAS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15317,'BUSQUEDA DE PAGINAS AUTORIZADAS','PAGAUT','CONSULTA LAS PAGINAS AUTORIZADAS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15318,'BUSQUEDA DE ZONAS AUTORIZADAS','ZONAUT','CONSULTA LAS ZONAS AUTORIZADAS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15319,'BUSQUEDA DE LISTA DE PADRES DE PAGINAS','BUSPAG','BUSQUEDA DE PAGINAS ADMIN NET')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15320,'BUSQUEDA DE PREREQUISITOS DE PAGINAS','BUSPAG','BUSQUEDA DE PAGINAS ADMIN NET')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15321,'CONSULTA DE ROLES POR USUARIO Y MODULO (EXE)','CONSRU','CONSULTA DE ROLES POR USUARIO Y MODULO (APP EXE)')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15322,'CONFIGURACIONES QUERY CATALOG','QCCONF','CONFIGURACIONES QUERY CATALOG')
go

--Transacciones de Admin NET
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15327, 'INSERCION DE GRUPO DE MODULOS', 'IGRMOD', 'INSERCION DE GRUPO DE MODULOS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15328, 'ACTUALIZACION DE GRUPO DE MODULOS', 'UGRMOD', 'ACTUALIZACION DE GRUPO DE MODULOS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15329, 'ELIMINACION DE GRUPO DE MODULOS', 'DGRMOD', 'ELIMINACION DE GRUPO DE MODULOS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15330, 'BUSQUEDA DE GRUPOS DE MODULOS', 'SGRMOD', 'BUSQUEDA DE GRUPOS DE MODULOS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15331, 'AYUDA DE GRUPO DE MODULOS', 'HGRMOD', 'AYUDA DE GRUPO DE MODULOS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15332, 'INSERCION DE ETIQUETA PARA CEN', 'INSLAB', 'INSERCION DE ETIQUETA PARA CEN')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15333, 'ACTUALIZACION DE ETIQUETA PARA CEN', 'UPDLAB', 'ACTUALIZACION DE ETIQUETA PARA CEN')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15334, 'ELIMINACION DE ETIQUETA PARA CEN', 'DELLAB', 'ELIMINACION DE ETIQUETA PARA CEN')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15335, 'BUSQUEDA DE ETIQUETAS PARA CEN', 'SEALAB', 'BUSQUEDA DE ETIQUETAS PARA CEN')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15336, 'AYUDA DE ETIQUETAS PARA CEN', 'HLPLAB', 'AYUDA DE ETIQUETAS PARA CEN')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15337, 'INSERCION DE MODULO', 'INSMOD', 'INSERCION DE MODULO')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15338, 'ACTUALIZACION DE MODULO', 'UPDMOD', 'ACTUALIZACION DE MODULO')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15339, 'ELIMINACION DE MODULO', 'DELMOD', 'ELIMINACION DE MODULO')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15340, 'BUSQUEDA DE MODULOS', 'SEAMOD', 'BUSQUEDA DE MODULOS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15341, 'AYUDA DE MODULO', 'HLPMOD', 'AYUDA DE MODULO')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15342, 'INSERCION DE COMPONENTE', 'INSCOM', 'INSERCION DE COMPONENTE')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15343, 'ACTUALIZACION DE COMPONENTE', 'UPDCOM', 'ACTUALIZACION DE COMPONENTE')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15344, 'ELIMINACION DE COMPONENTE', 'DELCOM', 'ELIMINACION DE COMPONENTE')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15345, 'BUSQUEDA DE COMPONENTES ', 'SEACOM', 'BUSQUEDA DE COMPONENTES ')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15346, 'AYUDA DE COMPONENTE', 'HLPCOM', 'AYUDA DE COMPONENTE')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15347, 'ASOCIACION DE MODULO A ROL', 'AMDROL', 'ASOCIACION DE MODULO A ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15348, 'ELIMINACION DE ASOCIACION MODULO - ROL', 'DMDROL', 'ELIMINACION DE ASOCIACION MODULO - ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15349, 'BUSQUEDA DE MODULOS ASOCIADOS A UN ROL', 'SMDROL', 'BUSQUEDA DE MODULOS ASOCIADOS A UN ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15350, 'AYUDA DE MODULOS ASOCIADOS A UN ROL', 'HMDROL', 'AYUDA DE MODULOS ASOCIADOS A UN ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15351, 'ASOCIACION DE ZONA DE NAVEGACION A ROL', 'AZNROL', 'ASOCIACION DE ZONA DE NAVEGACION A ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15352, 'ELIMINACION DE ASOCIACION ZONA DE NAVEGACION - ROL', 'DZNROL', 'ELIMINACION DE ASOCIACION ZONA DE NAVEGACION - ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15353, 'BUSQUEDA DE ZONAS DE NAVEGACION ASOCIADOS A UN ROL', 'SZNROL', 'BUSQUEDA DE ZONAS DE NAVEGACION ASOCIADOS A UN ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15354, 'AYUDA DE ZONAS DE NAVEGACIONJ ASOCIADAS A UN ROL', 'HZNROL', 'AYUDA DE ZONAS DE NAVEGACIONJ ASOCIADAS A UN ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15355, 'INSERCION DE PAGINA', 'INSPAG', 'INSERCION DE PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15356, 'ACTUALIZACION DE PAGINA', 'UPDPAG', 'ACTUALIZACION DE PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15357, 'ELIMINACION DE PAGINA', 'DELPAG', 'ELIMINACION DE PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15358, 'BUSQUEDA DE PAGINAS', 'SEAPAG', 'BUSQUEDA DE PAGINAS')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15359, 'HELP DE PAGINA', 'HLPPAG', 'HELP DE PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15360, 'INSERCION DE ZONA DE PAGINA', 'INSZPG', 'INSERCION DE ZONA DE PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15361, 'ACTUALIZACION DE ZONA DE PAGINA', 'UPDZPG', 'ACTUALIZACION DE ZONA DE PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15362, 'ELIMINACION DE ZONA DE PAGINA', 'DELZPG', 'ELIMINACION DE ZONA DE PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15363, 'BUSQUEDA DE ZONAS DE PAGINA', 'SEAZPG', 'BUSQUEDA DE ZONAS DE PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15364, 'HELP DE ZONA DE PAGINA', 'HLPZPG', 'HELP DE ZONA DE PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15365, 'AUTORIZACION DE COMPONENTE A ROL', 'ACPROL', 'AUTORIZACION DE COMPONENTE A ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15366, 'ELIMINAR ASOCIACION COMPONENTE - ROL', 'DCMROL', 'ELIMINAR ASOCIACION COMPONENTE - ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15367, 'BUSQUEDA DE COMPONENTES ASOCIADOS AL ROL', 'SCMROL', 'BUSQUEDA DE COMPONENTES ASOCIADOS AL ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15369, 'INSERCION DE PREREQUISITOS PARA PAGINA', 'INSRPG', 'INSERCION DE PREREQUISITOS PARA PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15371, 'ELIMINACION DE PREREQUISITOS PARA PAGINA', 'DELRPG', 'ELIMINACION DE PREREQUISITOS PARA PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15372, 'BUSQUEDA DE PREREQUISITOS DE UNA PAGINA', 'SEARPG', 'BUSQUEDA DE PREREQUISITOS DE UNA PAGINA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15373, 'ADMINISTRADOR DE SEGURIDADES - AUTORIZACION', 'APGROL', 'ADMINISTRADOR DE SEGURIDADES - AUTORIZACION')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15374, 'ADMINISTRADOR DE SEGURIDADES - AUTORIZACION - DESAUTORIZACION', 'DPGROL', 'ADMINISTRADOR DE SEGURIDADES - AUTORIZACION - DESAUTORIZACION')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15375, 'ADMINISTRADOR DE SEGURIDADES - CONSULTA', 'SPGROL', 'ADMINISTRADOR DE SEGURIDADES - CONSULTA')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15377, 'INSERCION DE ZONA DE NAVEGACION', 'INSZNV', 'INSERCION DE ZONA DE NAVEGACION')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15378, 'ACTUALIZACION DE ZONA DE NAVEGACION', 'UPDZNV', 'ACTUALIZACION DE ZONA DE NAVEGACION')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15379, 'ELIMINACION DE ZONA DE NAVEGACION', 'DELZNV', 'ELIMINACION DE ZONA DE NAVEGACION')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15380, 'BUSQUEDA DE ZONAS DE NAVEGACION', 'SEAZNV', 'BUSQUEDA DE ZONAS DE NAVEGACION')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15381, 'HELP DE ZONAS DE NAVEGACION', 'HLPZNV', 'HELP DE ZONAS DE NAVEGACION')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15382, 'AUTORIZACION DE EXE A USUARIO - ROL', 'AEXURO', 'AUTORIZACION DE EXE A USUARIO - ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15383, 'ELIMINAR AUTORIZACION DE MODULO A USUARIO - ROL', 'DEXURO', 'ELIMINAR AUTORIZACION DE MODULO A USUARIO - ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15384, 'BUSQUEDA DE MODULOS AUTORIZADOS A UN USUARIO - ROL', 'SEXURO', 'BUSQUEDA DE MODULOS AUTORIZADOS A UN USUARIO - ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15385, 'HELP DE MODULOS AUTORIZADOS A UN USUARIO - ROL', 'HEXURO', 'HELP DE MODULOS AUTORIZADOS A UN USUARIO - ROL')
go
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15386, 'ADMINISTRADOR DE SEGURIDADES - ACTUALIZACION ETIQUETAS', 'UPLAB', 'ADMINISTRADOR DE SEGURIDADES - ACTUALIZACION ETIQUETAS' )
go

if exists (select * from cl_ttransaccion
            where tn_trn_code =  15986)
   delete cl_ttransaccion
   where tn_trn_code  =  15986            
go
            
insert into cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
values (15986, 'CONSULTA DE GRUPOS PARA SEGURIDAD DE TASAS', 'CONGR ', 'CONSULTA DE GRUPOS PARA SEGURIDAD DE TASAS' )
go


print 'Asociacion de Transacciones con SPs en ad_pro_transaccion'
go

if exists (select 1 from ad_pro_transaccion
            where pt_transaccion between 15300 and 15386 and pt_producto = 1)
   delete ad_pro_transaccion
    where pt_transaccion between 15300 and 15386 and pt_transaccion not in (15303, 15304, 15309) and pt_producto = 1
go


declare @w_moneda int
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'
 
-- Transacciones basicas de CEN
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15300,'V',getdate(),5176)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15301,'V',getdate(),5181)

insert into ad_pro_transaccion (pt_producto,pt_tipo,pt_moneda, pt_transaccion,pt_estado,pt_fecha_ult_mod,pt_procedure) 
values (1,'R',@w_moneda,15302,'V',getdate(),5188)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15305,'V',getdate(),5178)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15306,'V',getdate(),5178)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15307,'V',getdate(),5178)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15308,'V',getdate(),5178)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15310,'V',getdate(),5177)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15311,'V',getdate(),5177)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15312,'V',getdate(),5177)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15315,'V',getdate(),5182)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15316,'V',getdate(),5183)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15317,'V',getdate(),5184)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15318,'V',getdate(),5185)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15319,'V',getdate(),5179)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15320,'V',getdate(),5180)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15321,'V',getdate(),5186)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values (1,'R',@w_moneda,15322,'V',getdate(),5187)


-- Transacciones de Admin NET
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15327, 'V', getdate(), 5194, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15328, 'V', getdate(), 5194, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15329, 'V', getdate(), 5194, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15330, 'V', getdate(), 5194, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15331, 'V', getdate(), 5194, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15332, 'V', getdate(), 5195, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15333, 'V', getdate(), 5195, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15334, 'V', getdate(), 5195, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15335, 'V', getdate(), 5195, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15336, 'V', getdate(), 5195, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15337, 'V', getdate(), 5196, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15338, 'V', getdate(), 5196, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15339, 'V', getdate(), 5196, null)

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15340, 'V', getdate(), 5196, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15341, 'V', getdate(), 5196, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15342, 'V', getdate(), 5197, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15343, 'V', getdate(), 5197, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15344, 'V', getdate(), 5197, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15345, 'V', getdate(), 5197, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15346, 'V', getdate(), 5197, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15347, 'V', getdate(), 5198, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15348, 'V', getdate(), 5198, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15349, 'V', getdate(), 5198, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15350, 'V', getdate(), 5198, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15351, 'V', getdate(), 5199, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15352, 'V', getdate(), 5199, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15353, 'V', getdate(), 5199, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15354, 'V', getdate(), 5199, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15355, 'V', getdate(), 5200, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15356, 'V', getdate(), 5200, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15357, 'V', getdate(), 5200, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15358, 'V', getdate(), 5200, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15359, 'V', getdate(), 5200, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15360, 'V', getdate(), 5201, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15361, 'V', getdate(), 5201, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15362, 'V', getdate(), 5201, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15363, 'V', getdate(), 5201, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15364, 'V', getdate(), 5201, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15365, 'V', getdate(), 5202, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15366, 'V', getdate(), 5202, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15367, 'V', getdate(), 5202, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15369, 'V', getdate(), 5203, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15371, 'V', getdate(), 5203, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15372, 'V', getdate(), 5203, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15373, 'V', getdate(), 5204, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15374, 'V', getdate(), 5204, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15375, 'V', getdate(), 5204, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15377, 'V', getdate(), 5205, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15378, 'V', getdate(), 5205, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15379, 'V', getdate(), 5205, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15380, 'V', getdate(), 5205, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15381, 'V', getdate(), 5205, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15382, 'V', getdate(), 5206, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15383, 'V', getdate(), 5206, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15384, 'V', getdate(), 5206, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial) 
values (1, 'R', @w_moneda, 15385, 'V', getdate(), 5206, null)
 
insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
values (1, 'R', @w_moneda, 15386, 'V', getdate(), 5204, null) 
 
if  exists (select 1 from ad_pro_transaccion
            where pt_transaccion = 15986)
    delete ad_pro_transaccion
    where pt_transaccion = 15986
go    

declare @w_moneda int
declare @w_tran_tmp int 
--select @w_moneda = 1
select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO'
 and pa_producto = 'ADM'


select @w_tran_tmp = max(pd_procedure) from ad_procedure
select @w_tran_tmp = @w_tran_tmp + 1 

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure, pt_especial)
values (1, 'R', @w_moneda, 15986, 'V', getdate(), @w_tran_tmp, null) 
go
 
print 'Autorizacion de Transacciones al rol Administrador en ad_tr_autorizada'
go

if exists (select 1 from ad_tr_autorizada where ta_transaccion  between   15300 and   15386 and  ta_producto = 1)
   delete ad_tr_autorizada where ta_transaccion  between   15300 and   15386 and ta_transaccion not in (15303, 15304, 15309) and  ta_producto = 1
   
declare @w_rol smallint,
        @w_moneda tinyint
   
select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO' and pa_producto = 'ADM'


-- Autorizacion de Transacciones basicas de CEN
insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15300, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15301, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto,ta_tipo,ta_moneda, ta_transaccion,ta_rol,ta_fecha_aut,ta_autorizante, ta_estado,ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15302, @w_rol, getdate(), 1, 'V', getdate())

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15305, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15306, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15307, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15308, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15310, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15311, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15312, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15315, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15316, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15317, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15318, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15319, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15320, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15321, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15322, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15327, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15328, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15329, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15330, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15331, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15332, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15333, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15334, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15335, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15336, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15337, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15338, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15339, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15340, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15341, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15342, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15343, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15344, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15345, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15346, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15347, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15348, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15349, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15350, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15351, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15352, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15353, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15354, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15355, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15356, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15357, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15358, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15359, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15360, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15361, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15362, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15363, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15364, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15365, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15366, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15367, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15369, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15371, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15372, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15373, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15374, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15375, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15377, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15378, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15379, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15380, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15381, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15382, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15383, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15384, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15385, @w_rol, getdate(), 1, 'V', null)

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15386, @w_rol, getdate(), 1, 'V', null)
go


if exists (select 1 from ad_tr_autorizada
           where ta_transaccion = 15986)
           delete ad_tr_autorizada
           where ta_transaccion = 15986
GO
declare @w_rol smallint,
        @w_moneda tinyint
   
select @w_rol = ro_rol
from ad_rol
where ro_descripcion = 'MENU POR PROCESOS'

select @w_moneda = pa_tinyint
from cobis..cl_parametro
where pa_nemonico = 'MLO' and pa_producto = 'ADM'
 

insert into ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod) 
values (1, 'R', @w_moneda, 15986, @w_rol, getdate(), 1, 'V', null)
go
