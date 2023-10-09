/********************************************************************/
/* Fecha:   19-Nov-2015                                             */
/* Objeto:  Script de creación de Menu de plataforma para CEN       */
/* Modulo:  Plataforma                                              */
/* Autor:   Estiwar V. Carrión J.                                   */
/********************************************************************/

use cobis
go

/*ELIMINACION TOTAL*/

declare @w_id_rol int

select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'
							   
delete from an_zone where zo_name = 'Zona WEB'

delete from an_page_zone WHERE pz_pa_id IN (SELECT pa_id FROM an_page WHERE pa_prod_name IN 
('M-POL','M-WKF','M-CRM','M-VCC','M-MCH','M-APF','M-IBX', 'M-WKFM', 'M-SIM'))


delete FROM an_role_component WHERE rc_co_id IN (SELECT co_id from an_component where co_prod_name IN 
('M-POL','M-WKF','M-CRM','M-VCC','M-MCH','M-APF','M-IBX', 'M-WKFM', 'M-SIM')) and rc_rol = @w_id_rol
							
delete from an_component where co_prod_name IN ('M-POL','M-WKF','M-CRM','M-VCC','M-MCH','M-APF','M-IBX', 'M-WKFM', 'M-SIM')


delete an_role_module where rm_mo_id in (select mo_id from an_module where mo_name in ('CRM.ConsultaReclamos','CRM.Reclamos','CRM.CategoriasSubCategorias','MCH.TransaccionesNegocio','WKF.Editor', 'WKF.Estadisticas','IBX.Consultas',
									  'IBX.SupervisorInbox','IBX.InboxOficial', 'IBX.ReimpresionDocumentos', 'POL.SistemasSubtipos', 'POL.VariablesProgramas','POL.EditorPoliticas','POL.SegReglasPoliticas',
									  'CRM.GestionReclamos','MCH.MakerAndChecker','WKF.Workflow','IBX.Inbox','POL.ReglasNegocio','VCC.AdministracionVista','VCC.VistaConsolidada','VCC.AdministradorContenido',
									  'VCC.SeguridadContenido','VCC.AdministradorSeccion','VCC.DtosPropiedades','WKF.Simulador','PI.ProcesosBackOffice','PI.ProcesosFrontOffice', 'PI.AdmProductosFinancieros'))
					    and rm_rol = @w_id_rol
									  
delete from an_module where mo_name in ('CRM.ConsultaReclamos','CRM.Reclamos','CRM.CategoriasSubCategorias','MCH.TransaccionesNegocio','WKF.Editor', 'WKF.Estadisticas','IBX.Consultas',
									  'IBX.SupervisorInbox','IBX.InboxOficial', 'IBX.ReimpresionDocumentos', 'POL.SistemasSubtipos', 'POL.VariablesProgramas','POL.EditorPoliticas','POL.SegReglasPoliticas',
									  'CRM.GestionReclamos','MCH.MakerAndChecker','WKF.Workflow','IBX.Inbox','POL.ReglasNegocio','VCC.AdministracionVista','VCC.VistaConsolidada','VCC.AdministradorContenido',
									  'VCC.SeguridadContenido','VCC.AdministradorSeccion','VCC.DtosPropiedades','WKF.Simulador','PI.ProcesosBackOffice','PI.ProcesosFrontOffice', 'PI.AdmProductosFinancieros')
									  
delete from an_module_group where mg_name in ('PI.ProcesosBackOffice','PI.ProcesosFrontOffice','PI.AtencionAlCliente','PI.AdmProductosFinancieros')	

delete an_role_page where rp_pa_id in (select pa_id from an_page where pa_prod_name IN ('M-POL','M-WKF','M-CRM','M-VCC','M-MCH','M-APF','M-IBX', 'M-WKFM'))
					    and rp_rol = @w_id_rol								  

delete from an_page WHERE pa_prod_name IN ('M-POL','M-WKF','M-CRM','M-VCC','M-MCH','M-APF','M-IBX', 'M-WKFM', 'M-SIM')

go


declare @w_id_label int,
		@w_id_label_SP int,
		@w_id_page  int,
		@w_id_page_parent int,
		@w_id_modulegroup int,
		@w_id_module int,
		@w_id_zone int,
		@w_id_component int,
		@w_id_pagezone int,
		@w_ip_port varchar(20), 
		@w_id_parent             int  -- OGU 24/09/2015  Identificador de la página padre

/*MODIFICAR POR EL IP Y PUERTO CORRECTO*/		
select @w_ip_port = '[cts_servername]' 
		
/*INSERCION DE ETIQUETAS*/

select @w_id_label = max(la_id) from an_label

-- Primer nivel
  
IF NOT EXISTS(SELECT 1 FROM an_label WHERE la_label = 'Procesos Back Office' AND la_prod_name = 'M-MENUPRIN')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label, 'ES_EC', 'Procesos Back Office', 'M-MENUPRIN' ) 
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label, 'EN_US', 'Back Office Process', 'M-MENUPRIN' ) 
END
ELSE IF NOT EXISTS(SELECT 1 FROM an_label WHERE la_label = 'Back Office Process' AND la_prod_name = 'M-MENUPRIN')
BEGIN 
	select @w_id_label_SP = la_id FROM an_label WHERE la_label = 'Procesos Back Office' AND la_prod_name = 'M-MENUPRIN'
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label_SP, 'EN_US', 'Back Office Process', 'M-MENUPRIN' )
END

--IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Procesos Front Office' AND la_prod_name = 'M-MENUPRIN')
--BEGIN 
--	select @w_id_label = @w_id_label + 1
--	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label, 'ES_EC', 'Procesos Front Office', 'M-MENUPRIN' ) 
--	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label, 'EN_US', 'Front Office Process', 'M-MENUPRIN' ) 
--END

-- Segundo nivel
IF NOT EXISTS(SELECT 1 FROM an_label WHERE la_label = 'Gestión de Reclamos' AND la_prod_name = 'M-CRM')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label ( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'ES_EC', 'Gestión de Reclamos', 'M-CRM' ) 
	INSERT INTO an_label ( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'EN_US', 'Management Claims', 'M-CRM' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Maker and Checker' AND la_prod_name = 'M-MCH')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label ( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'ES_EC', 'Maker and Checker', 'M-MCH' ) 
	INSERT INTO an_label ( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'EN_US', 'Maker and Checker', 'M-MCH' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Workflow' AND la_prod_name = 'M-WKF')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Workflow', 'M-WKF')
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Workflow', 'M-WKF')
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Inbox' AND la_prod_name = 'M-IBX' and la_cod = 'ES_EC')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label ( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'ES_EC', 'Inbox', 'M-IBX' ) 
	INSERT INTO an_label ( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'EN_US', 'Inbox', 'M-IBX' ) 
END
ELSE IF NOT EXISTS(SELECT 1 FROM an_label WHERE la_label = 'Inbox' AND la_prod_name = 'M-IBX' and la_cod = 'EN_US')
BEGIN 
	select @w_id_label_SP = la_id FROM an_label WHERE la_label = 'Inbox' AND la_prod_name = 'M-IBX' and la_cod = 'ES_EC'
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label_SP, 'EN_US', 'Inbox', 'M-IBX' )
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Reglas de Negocio' AND la_prod_name = 'M-POL')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Reglas de Negocio', 'M-POL')
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Business Rules', 'M-POL')
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Vista Consolidada' AND la_prod_name = 'M-VCC')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Vista Consolidada', 'M-VCC')
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Consolidated View', 'M-VCC')
END

IF EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Administrador de Productos Financieros' AND la_prod_name = 'M-MENUPRIN')
BEGIN 
	select @w_id_label = @w_id_label + 1
	UPDATE  an_label SET la_prod_name = 'M-APF' WHERE la_label = 'Administrador de Productos Financieros' AND la_prod_name = 'M-MENUPRIN' 
END
ELSE
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label, 'ES_EC', 'Administrador de Productos Financieros', 'M-APF' ) 
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label, 'EN_US', 'Financial Product Manager', 'M-APF' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Vista Consolidada de Clientes' AND la_prod_name = 'M-VCC')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label(la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'ES_EC', 'Vista Consolidada de Clientes', 'M-VCC' ) 
	INSERT INTO an_label( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'EN_US', 'Policies Editor', 'M-VCC' ) 	
END
ELSE IF NOT EXISTS(SELECT 1 FROM an_label WHERE la_label = 'Consolidated View Customers' AND la_prod_name = 'M-VCC' and la_cod = 'EN_US')
BEGIN 
	select @w_id_label_SP = la_id FROM an_label WHERE la_label = 'Vista Consolidada de Clientes' AND la_prod_name = 'M-VCC' and la_cod = 'ES_EC'
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label_SP, 'EN_US', 'Consolidated View Customers', 'M-VCC' )
END

-- Tercer Nivel

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Consulta de Reclamos' AND la_prod_name = 'M-CRM')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Consulta de Reclamos', 'M-CRM' ) 
    INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Consultation Claims', 'M-CRM' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Reclamos' AND la_prod_name = 'M-CRM')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Reclamos', 'M-CRM' ) 
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Claims', 'M-CRM' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Categorías y SubCategorías' AND la_prod_name = 'M-CRM')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Categorías y SubCategorías', 'M-CRM' ) 
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Categories and SubCategories', 'M-CRM' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Transacciones de Negocio' AND la_prod_name = 'M-MCH')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Transacciones de Negocio', 'M-MCH' ) 
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Business Transactions', 'M-MCH' ) 
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Editor' AND la_prod_name = 'M-WKF')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label(la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Editor', 'M-WKF')
	insert into an_label(la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Editor', 'M-WKF')
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Estadísticas' AND la_prod_name = 'M-WKF')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label(la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Estadísticas', 'M-WKF')
	insert into an_label(la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Statistics', 'M-WKF')
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Consultas' AND la_prod_name = 'M-IBX' and la_cod = 'ES_EC')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label(la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Consultas', 'M-IBX')
	insert into an_label(la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Inbox Query', 'M-IBX')
END 
ELSE IF NOT EXISTS(SELECT 1 FROM an_label WHERE la_label = 'Inbox Query' AND la_prod_name = 'M-IBX' and la_cod = 'EN_US')
BEGIN 
	select @w_id_label_SP = la_id FROM an_label WHERE la_label = 'Consultas' AND la_prod_name = 'M-IBX' and la_cod = 'ES_EC'
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label_SP, 'EN_US', 'Inbox Query', 'M-IBX' )
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Supervisor Inbox' AND la_prod_name = 'M-IBX')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label(la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Supervisor Inbox', 'M-IBX')
	insert into an_label(la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Inbox Supervisor', 'M-IBX')
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Official Inbox' AND la_prod_name = 'M-IBX')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Official Inbox', 'M-IBX' ) 
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Inbox Oficial', 'M-IBX' ) 	
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Reimpresión de Documentos' AND la_prod_name = 'M-IBX')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Reimpresión de Documentos', 'M-IBX' ) 
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Reprint Documents', 'M-IBX' ) 	
END
IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Sistemas y Subtipos' AND la_prod_name = 'M-POL')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Sistemas y Subtipos', 'M-POL' ) 
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Systems and Subtypes', 'M-POL' ) 	
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Variables y Programas' AND la_prod_name = 'M-POL')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'ES_EC', 'Variables y Programas', 'M-POL' ) 
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name) VALUES ( @w_id_label , 'EN_US', 'Variables and Programs', 'M-POL' ) 	
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Editor de Políticas' AND la_prod_name = 'M-POL')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label(la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'ES_EC', 'Editor de Políticas', 'M-POL' ) 
	INSERT INTO an_label( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'EN_US', 'Policies Editor', 'M-POL' ) 	
END
ELSE IF NOT EXISTS(SELECT 1 FROM an_label WHERE la_label = 'Policies Editor' AND la_prod_name = 'M-POL' and la_cod = 'EN_US')
BEGIN 
	select @w_id_label_SP = la_id FROM an_label WHERE la_label = 'Editor de Políticas' AND la_prod_name = 'M-POL' and la_cod = 'ES_EC'
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label_SP, 'EN_US', 'Policies Editor', 'M-POL' )
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Seguridades de Reglas y Políticas' AND la_prod_name = 'M-POL')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label(la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'ES_EC', 'Seguridades de Reglas y Políticas', 'M-POL' ) 
	INSERT INTO an_label( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'EN_US', 'Security Rules and Policies', 'M-POL' ) 	
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Administración Vista 360' AND la_prod_name = 'M-VCC')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Administración Vista 360', 'M-VCC')
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Management View 360', 'M-VCC')
END
ELSE IF NOT EXISTS(SELECT 1 FROM an_label WHERE la_label = 'Management View 360' AND la_prod_name = 'M-VCC' and la_cod = 'EN_US')
BEGIN 
	select @w_id_label_SP = la_id FROM an_label WHERE la_label = 'Administración Vista 360' AND la_prod_name = 'M-VCC' and la_cod = 'ES_EC'
	INSERT INTO an_label (la_id, la_cod, la_label, la_prod_name ) VALUES (@w_id_label_SP, 'EN_US', 'Management View 360', 'M-VCC' )
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Administrador de Contenido' AND la_prod_name = 'M-VCC')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Administrador de Contenido', 'M-VCC')
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Content Manager', 'M-VCC')
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Seguridad de Contenido' AND la_prod_name = 'M-VCC')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Seguridad de Contenido', 'M-VCC')
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Content Security', 'M-VCC')
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Administrador de Secciones' AND la_prod_name = 'M-VCC')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Administrador de Secciones', 'M-VCC')
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Sections Manager', 'M-VCC')
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Dtos y Propiedades' AND la_prod_name = 'M-VCC')
BEGIN 
	select @w_id_label = @w_id_label + 1
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'ES_EC', 'Dtos y Propiedades', 'M-VCC')
	insert into an_label (la_id, la_cod, la_label, la_prod_name) values (@w_id_label, 'EN_US', 'Dtos and Properties', 'M-VCC')
END

IF NOT EXISTS(SELECT 1 FROM an_label WHERE  la_label = 'Simulador' AND la_prod_name = 'M-WKF')
BEGIN 
	select @w_id_label = @w_id_label + 1
	INSERT INTO an_label(la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'ES_EC', 'Simulador', 'M-WKF' ) 
	INSERT INTO an_label( la_id, la_cod, la_label, la_prod_name ) VALUES ( @w_id_label , 'EN_US', 'Simulator', 'M-WKF' ) 	
END

/*INSERCION DE PAGINAS*/

select @w_id_page = max(pa_id) + 1 from an_page

-- Primer nivel
IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PI.Procesos Internos' AND pa_prod_name = 'M-MENUPRIN')  -- OGU 24/09/2015
BEGIN
	IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PI.ProcesosBackOffice' AND pa_prod_name = 'M-MENUPRIN')
	BEGIN 
		select @w_id_page = @w_id_page + 1
		select @w_id_label = la_id from an_label where la_label = 'Procesos Back Office' AND la_prod_name = 'M-MENUPRIN'
		INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
		VALUES (@w_id_page, @w_id_label, 'PI.ProcesosBackOffice', 'icono pagina', 0, 1, 'horizontal', 'Nemonic', 'M-MENUPRIN', NULL, NULL, 1 ) 		
	END
END	

--IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PI.ProcesosFrontOffice' AND pa_prod_name = 'M-MENUPRIN')
--BEGIN 
--	select @w_id_page = @w_id_page + 1
--	select @w_id_label = la_id from an_label where la_label = 'Procesos Front Office' AND la_prod_name = 'M-MENUPRIN'
--	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
--	VALUES (@w_id_page, @w_id_label, 'PI.ProcesosFrontOffice', 'icono pagina', 0, 2, 'horizontal', 'Nemonic', 'M-MENUPRIN', NULL, NULL, 1 ) 		
--END

-- Segundo nivel

select @w_id_page_parent = pa_id from an_page where pa_name = 'PI.Procesos Internos' AND pa_prod_name = 'M-MENUPRIN'  --OGU

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'CRM.GestionReclamos' AND pa_prod_name = 'M-CRM')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Gestión de Reclamos' AND la_prod_name = 'M-CRM'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'CRM.GestionReclamos', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-CRM', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'MCH.MakerAndChecker' AND pa_prod_name = 'M-MCH')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Maker and Checker' AND la_prod_name = 'M-MCH'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'MCH.MakerAndChecker', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-MCH', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'WKF.Workflow' AND pa_prod_name = 'M-WKF')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Workflow' AND la_prod_name = 'M-WKF'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'WKF.Workflow', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-WKF', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'IBX.Inbox' AND pa_prod_name = 'M-IBX')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Inbox' AND la_prod_name = 'M-IBX'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'IBX.Inbox', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-IBX', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'POL.ReglasNegocio' AND pa_prod_name = 'M-POL')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Reglas de Negocio' AND la_prod_name = 'M-POL'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'POL.ReglasNegocio', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-POL', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'VCC.VistaConsolidadaClientes' AND pa_prod_name = 'M-VCC')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Vista Consolidada de Clientes' AND la_prod_name = 'M-VCC'
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'VCC.VistaConsolidadaClientes', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-VCC', NULL, NULL, 1 ) 		
END

select @w_id_page_parent = pa_id from an_page where pa_name = 'AC.Atención al Cliente' AND pa_prod_name = 'M-MENUPRIN'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'VCC.VistaConsolidada' AND pa_prod_name = 'M-VCC')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Vista Consolidada' AND la_prod_name = 'M-VCC'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'VCC.VistaConsolidada', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-VCC', NULL, NULL, 1 ) 		
END

select @w_id_page_parent = pa_id from an_page where pa_name = 'PP.Parametrización de Productos' AND pa_prod_name = 'M-MENUPRIN'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'PI.AdmProductosFinancieros' AND pa_prod_name = 'M-APF')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Administrador de Productos Financieros' AND la_prod_name = 'M-APF'
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'PI.AdmProductosFinancieros', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-APF', NULL, NULL, 1 ) 		
END

-- Tercer Nivel

select @w_id_page_parent = pa_id from an_page where pa_name = 'CRM.GestionReclamos' AND pa_prod_name = 'M-CRM'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'CRM.ConsultaReclamos' AND pa_prod_name = 'M-CRM')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Consulta de Reclamos' AND la_prod_name = 'M-CRM'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'CRM.ConsultaReclamos', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-CRM', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'CRM.Reclamos' AND pa_prod_name = 'M-CRM')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Reclamos' AND la_prod_name = 'M-CRM'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'CRM.Reclamos', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-CRM', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'CRM.CategoriasSubCategorias' AND pa_prod_name = 'M-CRM')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Categorías y SubCategorías' AND la_prod_name = 'M-CRM'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'CRM.CategoriasSubCategorias', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-CRM', NULL, NULL, 1 ) 		
END

select @w_id_page_parent = pa_id from an_page where pa_name = 'MCH.MakerAndChecker' AND pa_prod_name = 'M-MCH'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'MCH.TransaccionesNegocio' AND pa_prod_name = 'M-MCH')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Transacciones de Negocio' AND la_prod_name = 'M-MCH'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'MCH.TransaccionesNegocio', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-MCH', NULL, NULL, 1 ) 		
END

select @w_id_page_parent = pa_id from an_page where pa_name = 'WKF.Workflow' AND pa_prod_name = 'M-WKF'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'WKF.Editor' AND pa_prod_name = 'M-WKF')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Editor' AND la_prod_name = 'M-WKF'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'WKF.Editor', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-WKF', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'WKF.Estadisticas' AND pa_prod_name = 'M-WKF')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Estadísticas' AND la_prod_name = 'M-WKF'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'WKF.Estadisticas', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-WKF', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'WKF.Simulador' AND pa_prod_name = 'M-WKF')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Simulador' AND la_prod_name = 'M-WKF'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'WKF.Simulador', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-WKF', NULL, NULL, 1 ) 		
END

select @w_id_page_parent = pa_id from an_page where pa_name = 'IBX.Inbox' AND pa_prod_name = 'M-IBX'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'IBX.Consultas' AND pa_prod_name = 'M-IBX')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Consultas' AND la_prod_name = 'M-IBX'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'IBX.Consultas', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-IBX', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'IBX.SupervisorInbox' AND pa_prod_name = 'M-IBX')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Supervisor Inbox' AND la_prod_name = 'M-IBX'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'IBX.SupervisorInbox', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-IBX', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'IBX.InboxOficial' AND pa_prod_name = 'M-IBX')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Official Inbox' AND la_prod_name = 'M-IBX'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'IBX.InboxOficial', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-IBX', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'IBX.ReimpresionDocumentos' AND pa_prod_name = 'M-IBX')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Reimpresión de Documentos' AND la_prod_name = 'M-IBX'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'IBX.ReimpresionDocumentos', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-IBX', NULL, NULL, 1 ) 		
END
select @w_id_page_parent = pa_id from an_page where pa_name = 'POL.ReglasNegocio' AND pa_prod_name = 'M-POL'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'POL.SistemasSubtipos' AND pa_prod_name = 'M-POL')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Sistemas y Subtipos' AND la_prod_name = 'M-POL'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'POL.SistemasSubtipos', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-POL', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'POL.VariablesProgramas' AND pa_prod_name = 'M-POL')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Variables y Programas' AND la_prod_name = 'M-POL'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'POL.VariablesProgramas', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-POL', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'POL.EditorPoliticas' AND pa_prod_name = 'M-POL')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Editor de Políticas' AND la_prod_name = 'M-POL'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'POL.EditorPoliticas', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-POL', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'POL.SegReglasPoliticas' AND pa_prod_name = 'M-POL')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Seguridades de Reglas y Políticas' AND la_prod_name = 'M-POL'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'POL.SegReglasPoliticas', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-POL', NULL, NULL, 1 ) 		
END

select @w_id_page_parent = pa_id from an_page where pa_name = 'VCC.VistaConsolidadaClientes' AND pa_prod_name = 'M-VCC'

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'VCC.AdministracionVista' AND pa_prod_name = 'M-VCC')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Administración Vista 360' AND la_prod_name = 'M-VCC'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'VCC.AdministracionVista', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-VCC', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'VCC.AdministradorContenido' AND pa_prod_name = 'M-VCC')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Administrador de Contenido' AND la_prod_name = 'M-VCC'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'VCC.AdministradorContenido', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-VCC', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'VCC.SeguridadContenido' AND pa_prod_name = 'M-VCC')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Seguridad de Contenido' AND la_prod_name = 'M-VCC'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'VCC.SeguridadContenido', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-VCC', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'VCC.AdministradorSeccion' AND pa_prod_name = 'M-VCC')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Administrador de Secciones' AND la_prod_name = 'M-VCC'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'VCC.AdministradorSeccion', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-VCC', NULL, NULL, 1 ) 		
END

IF NOT EXISTS(SELECT 1 FROM an_page WHERE pa_name = 'VCC.DtosPropiedades' AND pa_prod_name = 'M-VCC')
BEGIN 
	select @w_id_page = @w_id_page + 1
	select @w_id_label = la_id from an_label where la_label = 'Dtos y Propiedades' AND la_prod_name = 'M-VCC'	
	INSERT INTO an_page ( pa_id, pa_la_id, pa_name, pa_icon, pa_id_parent, pa_order, pa_splitter, pa_nemonic, pa_prod_name, pa_arguments, pa_he_id, pa_visible ) 
	VALUES (@w_id_page, @w_id_label, 'VCC.DtosPropiedades', 'icono pagina', @w_id_page_parent, 1, 'horizontal', 'Nemonic', 'M-VCC', NULL, NULL, 1 ) 		
END

--INSERCION DE GRUPO DE MODULOS

select @w_id_modulegroup = max(mg_id) from an_module_group

IF NOT EXISTS(SELECT 1 FROM an_module_group WHERE mg_name = 'PI.ProcesosBackOffice' AND mg_store_name = 'M-MENUPRIN')
BEGIN 
	select @w_id_modulegroup = @w_id_modulegroup + 1
	INSERT INTO an_module_group(mg_id, mg_name, mg_version, mg_location, mg_store_name) VALUES ( @w_id_modulegroup, 'PI.ProcesosBackOffice', '1.0.0', 'Ninguno', 'M-MENUPRIN' )  		
END

IF NOT EXISTS(SELECT 1 FROM an_module_group WHERE mg_name = 'PI.AtencionAlCliente' AND mg_store_name = 'M-MENUPRIN')
BEGIN 
	select @w_id_modulegroup = @w_id_modulegroup + 1
	INSERT INTO an_module_group(mg_id, mg_name, mg_version, mg_location, mg_store_name) VALUES ( @w_id_modulegroup, 'PI.AtencionAlCliente', '1.0.0', 'Ninguno', 'M-MENUPRIN' )  		
END

--IF NOT EXISTS(SELECT 1 FROM an_module_group WHERE mg_name = 'PI.ProcesosFrontOffice' AND mg_store_name = 'M-MENUPRIN')
--BEGIN 
--	select @w_id_modulegroup = @w_id_modulegroup + 1
--	INSERT INTO an_module_group(mg_id, mg_name, mg_version, mg_location, mg_store_name) VALUES ( @w_id_modulegroup, 'PI.ProcesosFrontOffice', '1.0.0', 'Ninguno', 'M-MENUPRIN' )  	
--END

IF NOT EXISTS(SELECT 1 FROM an_module_group WHERE mg_name = 'PI.AdmProductosFinancieros' AND mg_store_name = 'M-APF')
BEGIN 
	select @w_id_modulegroup = @w_id_modulegroup + 1
	INSERT INTO an_module_group(mg_id, mg_name, mg_version, mg_location, mg_store_name) VALUES ( @w_id_modulegroup, 'PI.AdmProductosFinancieros', '1.0.0', 'Ninguno', 'M-APF' )  		
END

-- INSERCION DE MODULOS

select @w_id_module = max(mo_id) FROM an_module

-- Segundo Nivel

select @w_id_modulegroup = mg_id FROM an_module_group WHERE mg_name = 'PI.AtencionAlCliente' AND mg_store_name = 'M-MENUPRIN'

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'VCC.VistaConsolidada')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Vista Consolidada' AND la_prod_name = 'M-VCC'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'VCC.VistaConsolidada', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

-- Tercer Nivel

select @w_id_modulegroup = mg_id FROM an_module_group WHERE mg_name = 'PI.ProcesosBackOffice' AND mg_store_name = 'M-MENUPRIN'

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'VCC.AdministracionVista')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Administración Vista 360' AND la_prod_name = 'M-VCC'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'VCC.AdministracionVista', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'VCC.AdministradorContenido')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Administrador de Contenido' AND la_prod_name = 'M-VCC'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'VCC.AdministradorContenido', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'VCC.SeguridadContenido')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Seguridad de Contenido' AND la_prod_name = 'M-VCC'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'VCC.SeguridadContenido', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'VCC.AdministradorSeccion')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Administrador de Secciones' AND la_prod_name = 'M-VCC'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'VCC.AdministradorSeccion', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'VCC.DtosPropiedades')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Dtos y Propiedades' AND la_prod_name = 'M-VCC'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'VCC.DtosPropiedades', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'CRM.ConsultaReclamos')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Consulta de Reclamos' AND la_prod_name = 'M-CRM'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'CRM.ConsultaReclamos', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'CRM.Reclamos')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Reclamos' AND la_prod_name = 'M-CRM'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'CRM.Reclamos', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'CRM.CategoriasSubCategorias')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Categorías y SubCategorías' AND la_prod_name = 'M-CRM'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'CRM.CategoriasSubCategorias', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'MCH.TransaccionesNegocio')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Transacciones de Negocio' AND la_prod_name = 'M-MCH'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'MCH.TransaccionesNegocio', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'WKF.Editor')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Editor' AND la_prod_name = 'M-WKF'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'WKF.Editor', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'WKF.Estadisticas')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Estadísticas' AND la_prod_name = 'M-WKF'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'WKF.Estadisticas', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'WKF.Simulador')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Simulador' AND la_prod_name = 'M-WKF'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'WKF.Simulador', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'IBX.Consultas')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Consultas' AND la_prod_name = 'M-IBX'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'IBX.Consultas', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'IBX.SupervisorInbox')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Supervisor Inbox' AND la_prod_name = 'M-IBX'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'IBX.SupervisorInbox', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'IBX.InboxOficial')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Official Inbox' AND la_prod_name = 'M-IBX'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'IBX.InboxOficial', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'IBX.ReimpresionDocumentos')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Reimpresión de Documentos' AND la_prod_name = 'M-IBX'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'IBX.ReimpresionDocumentos', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END
IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'POL.SistemasSubtipos')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Sistemas y Subtipos' AND la_prod_name = 'M-POL'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'POL.SistemasSubtipos', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'POL.VariablesProgramas')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Variables y Programas' AND la_prod_name = 'M-POL'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'POL.VariablesProgramas', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'POL.EditorPoliticas')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Editor de Políticas' AND la_prod_name = 'M-POL'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'POL.EditorPoliticas', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'POL.SegReglasPoliticas')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Seguridades de Reglas y Políticas' AND la_prod_name = 'M-POL'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, @w_id_label, 'POL.SegReglasPoliticas', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END

select @w_id_modulegroup = mg_id FROM an_module_group WHERE mg_name = 'PI.AdmProductosFinancieros' AND mg_store_name = 'M-APF'

IF NOT EXISTS(SELECT 1 FROM an_module WHERE mo_name = 'PI.AdmProductosFinancieros')
BEGIN 
	select @w_id_module = @w_id_module + 1
	select @w_id_label = la_id from an_label where la_label = 'Administrador de Productos Financieros' AND la_prod_name = 'M-APF'
	INSERT INTO an_module ( mo_id, mo_mg_id, mo_la_id, mo_name, mo_filename, mo_id_parent, mo_key_token ) 
	VALUES ( @w_id_module, @w_id_modulegroup, 87353, 'PI.AdmProductosFinancieros', 'COBISCorp.eCOBIS.COBISExplorer.Container.WebPageContainer.dll', 0, NULL ) 
END


-- INSERCION DE COMPONENTES

select @w_id_component = max(co_id) from an_component

-- Segundo nivel

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'VCC.VistaConsolidada' and co_prod_name = 'M-VCC')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'VCC.VistaConsolidada'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'VCC.VistaConsolidada', 'container.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/commons/', 'I', 'cobis5OnCen=yes;url=/CTSProxy/services/cobis/web/views/clientviewer/container-clientviewer.html;urlId=30;title=MNU_VCC', 'M-VCC' )
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'PI.AdmProductosFinancieros' and co_prod_name = 'M-APF')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'PI.AdmProductosFinancieros'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'PI.AdmProductosFinancieros', 'fpm-tree-process-page.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/fpm/', 'I', 'cobis5OnCen=yes', 'M-APF' )  
END

-- Tercer nivel

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'VCC.AdministracionVista' and co_prod_name = 'M-VCC')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'VCC.AdministracionVista'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'VCC.AdministracionVista', 'admin-client-viewer.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/admin-clientviewer/', 'I', 'cobis5OnCen=yes;url=/CTSProxy/services/cobis/web/views/clientviewer/container-clientviewer.html;urlId=30', 'M-VCC' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'VCC.AdministradorContenido' and co_prod_name = 'M-VCC')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'VCC.AdministradorContenido'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'VCC.AdministradorContenido', 'VC_NSOSK11_NNTOO_561_TASK.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/LATFO/PLATF/T_PLATF_99_NSOSK11/1.0.0/', 'I', 'cobis5OnCen=yes', 'M-VCC' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'VCC.SeguridadContenido' and co_prod_name = 'M-VCC')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'VCC.SeguridadContenido'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'VCC.SeguridadContenido', 'VC_LTNTI84_REONA_308_TASK.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/LATFO/PLATF/T_PLATF_90_LTNTI84/1.0.0/', 'I', 'cobis5OnCen=yes', 'M-VCC' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'VCC.AdministradorSeccion' and co_prod_name = 'M-VCC')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'VCC.AdministradorSeccion'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'VCC.AdministradorSeccion', 'admin-clientviewer-tree-page.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/admin-clientviewer/', 'I', 'cobis5OnCen=yes', 'M-VCC' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'VCC.DtosPropiedades' and co_prod_name = 'M-VCC')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'VCC.DtosPropiedades'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'VCC.DtosPropiedades', 'VC_KTOIT54_DOLST_848_TASK.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/LATFO/UCSPM/T_UCSPM_16_KTOIT54/1.0.0/', 'I', 'cobis5OnCen=yes', 'M-VCC' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'CRM.ConsultaReclamos' and co_prod_name = 'M-CRM')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'CRM.ConsultaReclamos'
	
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'CRM.ConsultaReclamos', 'container.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/commons/', 'I', 'cobis5OnCen=yes;url=/CTSProxy/services/cobis/web/views/LATFO/CLAIM/T_CLAIM_41_AHMES22/1.0.0/VC_AHMES22_FSCHE_616_TASK.html;urlId=123605;title=cobis5OnCen=yes;url=/CTSProxy/services/cobis/web/views/LATFO/CLAIM/T_CLAIM_41_AHMES22/1.0.0/VC_AHMES22_FSCHE_616_TASK.html;urlId=123605;title=CRESP_DUP', 'M-CRM' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'CRM.Reclamos' and co_prod_name = 'M-CRM')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'CRM.Reclamos'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'CRM.Reclamos', 'VC_TCLAM34_TCAIM_737_TASK.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/LATFO/CLAIM/T_CLAIM_16_TCLAM34/1.0.0/', 'I', 'cobis5OnCen=yes', 'M-CRM' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'CRM.CategoriasSubCategorias' and co_prod_name = 'M-CRM')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'CRM.CategoriasSubCategorias'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'CRM.CategoriasSubCategorias', 'VC_AGORY85_CEGOR_783_TASK.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/LATFO/CLAIM/T_CLAIM_44_AGORY85/1.0.0/', 'I', 'cobis5OnCen=yes', 'M-CRM' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'MCH.TransaccionesNegocio' and co_prod_name = 'M-MCH')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'MCH.TransaccionesNegocio'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'MCH.TransaccionesNegocio', 'VC_NSACG04_EASAD_863_TASK.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/MKCHK/ADMWS/T_ADMWS_85_NSACG04/1.0.0/', 'I', 'cobis5OnCen=yes', 'M-MCH' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'WKF.Editor' and co_prod_name = 'M-WKF')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'WKF.Editor'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'WKF.Editor', 'workflow-tree-process-page.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/workflow/', 'I', 'cobis5OnCen=yes', 'M-WKF' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'WKF.Estadisticas' and co_prod_name = 'M-WKF')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'WKF.Estadisticas'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'WKF.Estadisticas', 'workflow-container-statistics.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/workflow/', 'I', 'cobis5OnCen=yes', 'M-WKF' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'IBX.Consultas' and co_prod_name = 'M-IBX')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'IBX.Consultas'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'IBX.Consultas', 'inbox-query.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/inbox/', 'I', 'cobis5OnCen=yes', 'M-IBX' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'IBX.SupervisorInbox' and co_prod_name = 'M-IBX')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'IBX.SupervisorInbox'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'IBX.SupervisorInbox', 'VC_NXNNR78_TSOGE_560_TASK.html?cweb=1&role=S', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/', 'I', 'cobis5OnCen=yes', 'M-IBX' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'IBX.InboxOficial' and co_prod_name = 'M-IBX')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'IBX.InboxOficial'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'IBX.InboxOficial', 'container.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/commons/', 'I', 'cobis5OnCen=yes;url=/CTSProxy/services/cobis/web/views/LATFO/INBOX/T_INBOX_72_NXNNR78/1.0.0/VC_NXNNR78_TSOGE_560_TASK.html?cweb=1&role=F;urlId=96596;title=MNU_CONTAINER_INBOX_FF', 'M-IBX' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'IBX.ReimpresionDocumentos' and co_prod_name = 'M-IBX')
BEGIN 
	declare @w_arguments varchar(255)
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'IBX.ReimpresionDocumentos'
	select @w_id_page = pa_id from an_page where pa_name = 'IBX.ReimpresionDocumentos'
	set @w_arguments = 'cobis5OnCen=yes;url=/CTSProxy/services/cobis/web/views/BUSIN/FLCRE/T_FLCRE_13_RPUME79/1.0.0/VC_RPUME79_RERNO_643_TASK.html;urlId='+convert(varchar,@w_id_page)+';title=MNU_REPRINT_DOCUMENT'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'IBX.ReimpresionDocumentos', 'container.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/commons/', 'I', @w_arguments, 'M-IBX' )  
END
IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'POL.SistemasSubtipos' and co_prod_name = 'M-POL')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'POL.SistemasSubtipos'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'POL.SistemasSubtipos', 'container-group-businessrules.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/businessrules/', 'I', 'cobis5OnCen=yes', 'M-POL' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'POL.VariablesProgramas' and co_prod_name = 'M-POL')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'POL.VariablesProgramas'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'POL.VariablesProgramas', 'container-businessrules.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/businessrules/', 'I', 'cobis5OnCen=yes', 'M-POL' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'POL.EditorPoliticas' and co_prod_name = 'M-POL')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'POL.EditorPoliticas'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'POL.EditorPoliticas', 'container-rules-editor.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/businessrules/', 'I', 'cobis5OnCen=yes', 'M-POL' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'POL.SegReglasPoliticas' and co_prod_name = 'M-POL')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'POL.SegReglasPoliticas'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'POL.SegReglasPoliticas', 'container-admin-businessrules.html', 'http://'+ @w_ip_port + '/CTSProxy/services/cobis/web/views/businessrules/', 'I', 'cobis5OnCen=yes', 'M-POL' )  
END

IF NOT EXISTS(SELECT 1 FROM an_component WHERE co_name = 'WKF.Simulador' and co_prod_name = 'M-WKF')
BEGIN 
	select @w_id_component = @w_id_component + 1
	select @w_id_module = mo_id from an_module where mo_name = 'WKF.Simulador'
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name ) 
	VALUES ( @w_id_component, @w_id_module, 'WKF.Simulador', 'VC_ESAOR56_SATOR_398_TASK.html', 'http://'+@w_ip_port+ '/CTSProxy/services/cobis/web/views/LATFO/SIMUL/T_SIMUL_55_ESAOR56/1.0.0/', 'I', 'cobis5OnCen=yes', 'M-WKF' )  
END
-- INSERCION DE ZONA

select @w_id_zone = max(zo_id) from an_zone

IF NOT EXISTS(SELECT 1 FROM an_zone WHERE zo_name = 'Zona WEB')
BEGIN 
	select @w_id_zone = @w_id_zone + 1	
	INSERT INTO an_zone (zo_id, zo_name, zo_pin_visible, zo_close_visible, zo_title_visible, zo_pin_value ) VALUES ( @w_id_zone, 'Zona WEB', 1, 0, 0, 1 ) 
END

-- INSERCION DE PAGINAS POR ZONA

select @w_id_pagezone = isnull(max(pz_id),0) from an_page_zone
select @w_id_zone = zo_id from an_zone where zo_name = 'Zona WEB'

-- Segundo nivel

select @w_id_page = pa_id from an_page where pa_name = 'VCC.VistaConsolidada' and pa_prod_name = 'M-VCC'
select @w_id_component = co_id from an_component where co_name = 'VCC.VistaConsolidada' and co_prod_name = 'M-VCC'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Vista Consolidada' AND la_prod_name = 'M-VCC'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'PI.AdmProductosFinancieros' and pa_prod_name = 'M-APF'
select @w_id_component = co_id from an_component where co_name = 'PI.AdmProductosFinancieros' and co_prod_name = 'M-APF'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Administrador de Productos Financieros' AND la_prod_name = 'M-APF'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

-- Tercer nivel

select @w_id_page = pa_id from an_page where pa_name = 'VCC.AdministracionVista' and pa_prod_name = 'M-VCC'
select @w_id_component = co_id from an_component where co_name = 'VCC.AdministracionVista' and co_prod_name = 'M-VCC'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Administración Vista 360' AND la_prod_name = 'M-VCC'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'VCC.AdministradorContenido' and pa_prod_name = 'M-VCC'
select @w_id_component = co_id from an_component where co_name = 'VCC.AdministradorContenido' and co_prod_name = 'M-VCC'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Administrador de Contenido' AND la_prod_name = 'M-VCC'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'VCC.SeguridadContenido' and pa_prod_name = 'M-VCC'
select @w_id_component = co_id from an_component where co_name = 'VCC.SeguridadContenido' and co_prod_name = 'M-VCC'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Seguridad de Contenido' AND la_prod_name = 'M-VCC'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'VCC.AdministradorSeccion' and pa_prod_name = 'M-VCC'
select @w_id_component = co_id from an_component where co_name = 'VCC.AdministradorSeccion' and co_prod_name = 'M-VCC'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Administrador de Secciones' AND la_prod_name = 'M-VCC'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'VCC.DtosPropiedades' and pa_prod_name = 'M-VCC'
select @w_id_component = co_id from an_component where co_name = 'VCC.DtosPropiedades' and co_prod_name = 'M-VCC'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Dtos y Propiedades' AND la_prod_name = 'M-VCC'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'CRM.ConsultaReclamos' and pa_prod_name = 'M-CRM'
select @w_id_component = co_id from an_component where co_name = 'CRM.ConsultaReclamos' and co_prod_name = 'M-CRM'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Consulta de Reclamos' AND la_prod_name = 'M-CRM'	
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'CRM.Reclamos' and pa_prod_name = 'M-CRM'
select @w_id_component = co_id from an_component where co_name = 'CRM.Reclamos' and co_prod_name = 'M-CRM'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Reclamos' AND la_prod_name = 'M-CRM'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'CRM.CategoriasSubCategorias' and pa_prod_name = 'M-CRM'
select @w_id_component = co_id from an_component where co_name = 'CRM.CategoriasSubCategorias' and co_prod_name = 'M-CRM'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Categorías y SubCategorías' AND la_prod_name = 'M-CRM'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'MCH.TransaccionesNegocio' and pa_prod_name = 'M-MCH'
select @w_id_component = co_id from an_component where co_name = 'MCH.TransaccionesNegocio' and co_prod_name = 'M-MCH'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Transacciones de Negocio' AND la_prod_name = 'M-MCH'	
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'WKF.Editor' and pa_prod_name = 'M-WKF'
select @w_id_component = co_id from an_component where co_name = 'WKF.Editor' and co_prod_name = 'M-WKF'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Editor' AND la_prod_name = 'M-WKF'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'WKF.Estadisticas' and pa_prod_name = 'M-WKF'
select @w_id_component = co_id from an_component where co_name = 'WKF.Estadisticas' and co_prod_name = 'M-WKF'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Estadísticas' AND la_prod_name = 'M-WKF'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'IBX.Consultas' and pa_prod_name = 'M-IBX'
select @w_id_component = co_id from an_component where co_name = 'IBX.Consultas' and co_prod_name = 'M-IBX'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Consultas' AND la_prod_name = 'M-IBX'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'IBX.SupervisorInbox' and pa_prod_name = 'M-IBX'
select @w_id_component = co_id from an_component where co_name = 'IBX.SupervisorInbox' and co_prod_name = 'M-IBX'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Supervisor Inbox' AND la_prod_name = 'M-IBX'	
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'IBX.InboxOficial' and pa_prod_name = 'M-IBX'
select @w_id_component = co_id from an_component where co_name = 'IBX.InboxOficial' and co_prod_name = 'M-IBX'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Official Inbox' AND la_prod_name = 'M-IBX'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'IBX.ReimpresionDocumentos' and pa_prod_name = 'M-IBX'
select @w_id_component = co_id from an_component where co_name = 'IBX.ReimpresionDocumentos' and co_prod_name = 'M-IBX'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Reimpresión de Documentos' AND la_prod_name = 'M-IBX'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END
select @w_id_page = pa_id from an_page where pa_name = 'POL.SistemasSubtipos' and pa_prod_name = 'M-POL'
select @w_id_component = co_id from an_component where co_name = 'POL.SistemasSubtipos' and co_prod_name = 'M-POL'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Sistemas y Subtipos' AND la_prod_name = 'M-POL'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'POL.VariablesProgramas' and pa_prod_name = 'M-POL'
select @w_id_component = co_id from an_component where co_name = 'POL.VariablesProgramas' and co_prod_name = 'M-POL'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Variables y Programas' AND la_prod_name = 'M-POL'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'POL.EditorPoliticas' and pa_prod_name = 'M-POL'
select @w_id_component = co_id from an_component where co_name = 'POL.EditorPoliticas' and co_prod_name = 'M-POL'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Editor de Políticas' AND la_prod_name = 'M-POL'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'POL.SegReglasPoliticas' and pa_prod_name = 'M-POL'
select @w_id_component = co_id from an_component where co_name = 'POL.SegReglasPoliticas' and co_prod_name = 'M-POL'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Seguridades de Reglas y Políticas' AND la_prod_name = 'M-POL'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END

select @w_id_page = pa_id from an_page where pa_name = 'WKF.Simulador' and pa_prod_name = 'M-WKF'
select @w_id_component = co_id from an_component where co_name = 'WKF.Simulador' and co_prod_name = 'M-WKF'

IF NOT EXISTS(SELECT 1 FROM an_page_zone WHERE pz_zo_id = @w_id_zone and pz_pa_id =  @w_id_page  and pz_co_id = @w_id_component)
BEGIN 
	select @w_id_pagezone = @w_id_pagezone + 1	
	select @w_id_label = la_id from an_label where la_label = 'Simulador' AND la_prod_name = 'M-WKF'
	INSERT INTO an_page_zone (pz_id, pz_zo_id, pz_la_id, pz_pa_id, pz_co_id, pz_order, pz_hor_size, pz_ver_size, pz_icon, pz_split_style, pz_id_parent, pz_component_optional, pz_he_id ) 
	VALUES ( @w_id_pagezone, @w_id_zone, @w_id_label, @w_id_page, @w_id_component, 1, 100, 100, 'Ninguno', 'vertical', 0, 1, NULL ) 
END
go

/******AUTORIZACION**********/

declare @w_id_rol int

select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'MENU POR PROCESOS'

--Autoriza los modulos

insert into an_role_module(rm_mo_id, rm_rol)
select mo_id,@w_id_rol from an_module where mo_name in ('CRM.ConsultaReclamos','CRM.CategoriasSubCategorias','MCH.TransaccionesNegocio','WKF.Editor', 'WKF.Estadisticas','IBX.Consultas',
									  'IBX.SupervisorInbox','IBX.InboxOficial', 'IBX.ReimpresionDocumentos', 'POL.SistemasSubtipos', 'POL.VariablesProgramas','POL.EditorPoliticas','POL.SegReglasPoliticas',
									  'CRM.GestionReclamos','MCH.MakerAndChecker','WKF.Workflow','IBX.Inbox','POL.ReglasNegocio','VCC.AdministracionVista','VCC.VistaConsolidada','VCC.AdministradorContenido',
									  'VCC.SeguridadContenido','WKF.Simulador', 'VCC.AdministradorSeccion','VCC.DtosPropiedades','PI.ProcesosBackOffice','PI.ProcesosFrontOffice', 'PI.AdmProductosFinancieros')
	and mo_id not in (select rm_mo_id from an_role_module where rm_rol = @w_id_rol)

--Autoriza los componentes

insert into an_role_component(rc_co_id, rc_rol)
select co_id,@w_id_rol from an_component where co_name in ('CRM.ConsultaReclamos','CRM.CategoriasSubCategorias','MCH.TransaccionesNegocio','WKF.Editor', 'WKF.Estadisticas','IBX.Consultas',
									  'IBX.SupervisorInbox','IBX.InboxOficial', 'IBX.ReimpresionDocumentos', 'POL.SistemasSubtipos', 'POL.VariablesProgramas','POL.EditorPoliticas','POL.SegReglasPoliticas',
									  'CRM.GestionReclamos','MCH.MakerAndChecker','WKF.Workflow','IBX.Inbox','POL.ReglasNegocio','VCC.AdministracionVista','VCC.VistaConsolidada','VCC.AdministradorContenido',
									  'VCC.SeguridadContenido', 'WKF.Simulador','VCC.AdministradorSeccion','VCC.DtosPropiedades','PI.ProcesosBackOffice','PI.ProcesosFrontOffice', 'PI.AdmProductosFinancieros')
	and co_id not in (select rc_co_id from an_role_component where rc_rol = @w_id_rol)

--Autoriza las páginas
						
insert into an_role_page(rp_pa_id, rp_rol)
select pa_id,@w_id_rol from an_page where pa_name in ('CRM.ConsultaReclamos','CRM.CategoriasSubCategorias','MCH.TransaccionesNegocio','WKF.Editor', 'WKF.Estadisticas','IBX.Consultas',
									  'IBX.SupervisorInbox','IBX.InboxOficial', 'POL.SistemasSubtipos', 'IBX.ReimpresionDocumentos', 'POL.VariablesProgramas','POL.EditorPoliticas','POL.SegReglasPoliticas',
									  'CRM.GestionReclamos','MCH.MakerAndChecker','WKF.Workflow','IBX.Inbox','POL.ReglasNegocio','VCC.AdministracionVista','VCC.VistaConsolidada','VCC.AdministradorContenido',
									  'VCC.SeguridadContenido', 'WKF.Simulador', 'VCC.AdministradorSeccion','VCC.DtosPropiedades','PI.ProcesosBackOffice','PI.ProcesosFrontOffice', 'PI.AdmProductosFinancieros','VCC.VistaConsolidadaClientes')
	and pa_id not in (select rp_pa_id from an_role_page where rp_rol = @w_id_rol)
go

---------------------------------- MAKER & CHECKER ---------------------------------------------------
use cobis
go
declare @w_co_id int

select @w_co_id = co_id from an_component WHERE co_name = 'MCH.TransaccionesNegocio'

--Servicios de Administración
delete from an_service_component
where sc_co_id = @w_co_id
  
--Trasacciones de Mantenimiento de Roles Administrativos
delete from an_transaction_component
where tc_co_id = @w_co_id
  and tc_oc_nemonic = null
  
insert into an_service_component (sc_co_id, sc_csc_service_id, sc_oc_nemonic) values (@w_co_id,'Designer.MiddlewareManager.Persist',null)
go
