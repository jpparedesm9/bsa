/**********************************************************************************************************************/
--No Bug                     : NA
--TÃ­tulo de la Historia      : 
--Fecha                      : 26/01/2018
--Descripción del Problema   : No existen instaladores referentes a lo contenido en el archivo
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Agregar menú y permisos
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93703/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_cew_menu.sql

use cobis
go

DECLARE @w_menu_parent_id INT,
        @w_menu_id INT,
        @w_producto int,
        @w_rol int,
        @w_menu_order int 

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'


SELECT @w_menu_parent_id = me_id FROM cew_menu WHERE me_name = 'MNU_ASSETS'
SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id

select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'

if @w_menu_parent_id is not null
begin
    --MENU ADMINISTRACION DE DISPOSITIVOS MÓVILES
    if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
	begin 
		if not exists (select 1 from cew_menu where me_name = 'MNU_ACCOUNT_STATUS')
	    begin
	        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
	        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
	        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
	        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_ACCOUNT_STATUS', 1, 'views/ASSTS/TRNSC/T_ASSTSFIQJZFID_726/1.0.0/VC_ACCOUNTSSA_935726_TASK.html', @w_menu_order, 
	        @w_producto, 0)
	    end    
	    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_ACCOUNT_STATUS'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
	else
	begin
		
		select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
		
		if not exists (select 1 from cew_menu where me_name = 'MNU_ACCOUNT_STATUS')
	    begin
	        SELECT @w_menu_id = isnull( max(me_id), 0 ) + 1 FROM cew_menu
	        SELECT @w_menu_order = isnull(max(me_id),0) FROM cew_menu WHERE me_id_parent = @w_menu_parent_id
	        INSERT INTO dbo.cew_menu (me_id, me_id_parent, me_name, me_visible, me_url, me_order, me_id_cobis_product, me_option)
	        VALUES (@w_menu_id, @w_menu_parent_id, 'MNU_ACCOUNT_STATUS', 1, 'views/ASSTS/TRNSC/T_ASSTSFIQJZFID_726/1.0.0/VC_ACCOUNTSSA_935726_TASK.html', @w_menu_order, 
	        @w_producto, 0)
	    end    
	    SELECT @w_menu_id = me_id from cew_menu where me_name = 'MNU_ACCOUNT_STATUS'    
	    if not exists (select 1 from cew_menu_role where mro_id_menu = @w_menu_id and mro_id_role = @w_rol)
	    begin
	        insert into cew_menu_role values (@w_menu_id, @w_rol)
	    end
	end
    
    
end
else
begin
    print 'No existe el menu padre: MNU_ADMIN'
end

go




--------------------------------------------------------------------------------------------
-- Agregar servicios
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93703/Activas/Cartera/Backend/sql
--Nombre Archivo             : servicios_autorizados.sql

use cobis
GO

IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'Loan.LoanMaintenance.SearchAccountStatus')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', csc_method_name = 'searchAccountStatus', csc_description = '', csc_trn = 0 WHERE csc_service_id = 'Loan.LoanMaintenance.SearchAccountStatus'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('Loan.LoanMaintenance.SearchAccountStatus', 'cobiscorp.ecobis.assets.cloud.service.ILoanMaintenance', 'searchAccountStatus', '', 0)
GO


USE cobis

GO
declare @w_rol int, @w_producto int

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin  
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'
	
	DELETE cobis..ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.SearchAccountStatus'
	INSERT INTO cobis..ad_servicio_autorizado values('Loan.LoanMaintenance.SearchAccountStatus', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado'
end
else
begin
	
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	select @w_producto = pd_producto from cl_producto where pd_descripcion = 'CARTERA'
	
	DELETE cobis..ad_servicio_autorizado where ts_servicio = 'Loan.LoanMaintenance.SearchAccountStatus'
	INSERT INTO cobis..ad_servicio_autorizado values('Loan.LoanMaintenance.SearchAccountStatus', @w_rol,@w_producto,'R',0,getdate(),'V',getdate())
	print 'insert en ad_servicio_autorizado'
end
---------------------------------------------------------------------------------------
-------------------Crear tabla de notificaciones de estado de cuenta-------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93703/RegulatoriosMX/sql
--Nombre Archivo             : reg_tabla.sql

use cob_conta_super
go


IF OBJECT_ID ('dbo.sb_ns_estado_cuenta') IS NOT NULL
	DROP TABLE dbo.sb_ns_estado_cuenta
go

CREATE TABLE dbo.sb_ns_estado_cuenta
	(
		nec_codigo             int not null,
		nec_banco              varchar(15) not null,
		nec_fecha              datetime    not null,
		nec_correo             varchar(64) not null,
		nec_estado             char(1) not null
	)
go

CREATE UNIQUE CLUSTERED INDEX sb_ns_estado_cuenta_Key
	ON dbo.sb_ns_estado_cuenta (nec_codigo)
go

--------------------------------------------------------------------------------------------
-- Insertar en tabla de secuenciales
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93703/RegulatoriosMX/sql
--Nombre Archivo             : reg_tabla.sql


use cobis
go


DELETE cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_ns_estado_cuenta'

INSERT INTO dbo.cl_seqnos (bdatos, tabla, siguiente, pkey)
VALUES ('cob_conta_super', 'sb_ns_estado_cuenta', 0, 'nec_codigo')
go




--------------------------------------------------------------------------------------------
-- REGISTRO SP - SEGURIDADES -- con_conta_super   --sp_estado_cuenta
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/ISS/CLOUD-93703/RegulatoriosMX/BackEnd/sql
--Nombre Archivo             : reg_trn.sql
PRINT '--->> Registro de sp sp_estado_cuenta.sp'
GO


use cobis
GO

DECLARE @w_numero int, @w_producto int
select @w_numero = 36006
select @w_producto = 36
-- reprocesable
delete cobis..ad_tr_autorizada where ta_transaccion = @w_numero and ta_producto = @w_producto
delete cobis..ad_pro_transaccion where pt_procedure = @w_numero and pt_transaccion = @w_numero and pt_producto = @w_producto
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero+1
delete cobis..cl_ttransaccion where tn_trn_code = @w_numero
delete cobis..ad_procedure where pd_procedure = @w_numero

-- sql\ca_segur.sql
insert into cobis..ad_procedure(pd_procedure,pd_stored_procedure,pd_base_datos,pd_estado,pd_fecha_ult_mod,pd_archivo)
values (@w_numero,'sp_estado_cuenta','cob_conta_super','V',getdate(),'sp_es_cuen.sp')


INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (36006, 'INSERTAR ESTADO CUENTA', '36006', 'INSERTA REGISTROS DE ESTADO PARA ESTADO CUENTA')

INSERT INTO dbo.cl_ttransaccion (tn_trn_code, tn_descripcion, tn_nemonico, tn_desc_larga)
VALUES (36007, 'CONSUTA ESTADO CUENTA', '36007', 'CONSULTA TODOS LOS BANCOS A ENVIAR ESTADO CUENTA')

insert into ad_pro_transaccion (pt_producto, pt_tipo, pt_moneda, pt_transaccion, pt_estado, pt_fecha_ult_mod, pt_procedure) 
values  (@w_producto,'R',0,@w_numero,'V',getdate(),@w_numero)

declare @w_moneda tinyint, @w_fecha datetime, @w_rol int
select @w_moneda = pa_tinyint from cobis..cl_parametro where pa_nemonico = 'MLO' and pa_producto = 'ADM'
set    @w_fecha = getdate()
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'

if exists(select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin 

	INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, @w_fecha, 1, 'V', @w_fecha)
	
end
else
begin
	
	select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'ADMINISTRADOR'
	
	INSERT INTO ad_tr_autorizada (ta_producto, ta_tipo, ta_moneda, ta_transaccion, ta_rol, ta_fecha_aut, ta_autorizante, ta_estado, ta_fecha_ult_mod)
	VALUES (@w_producto, 'R',@w_moneda, @w_numero, @w_rol, @w_fecha, 1, 'V', @w_fecha)
	
end
go


--------------------------------------------------------------------------------------------
-- Crear CATALOGO
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93703/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_catalogo.sql

use cobis
go


delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CCA'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('ca_param_notif')
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('ca_param_notif')                                              
and cl_tabla.codigo = cl_catalogo.tabla

go                                       
delete cl_tabla                          
 where cl_tabla.tabla in ('ca_param_notif')                                    
go


declare @w_tabla int
select @w_tabla = isnull(max(codigo), 0) + 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'ca_param_notif', 'PARAMETROS NOTIFICACIONES CARTERA')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCO_NXML', 'PagoCorresponsal.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCO_NJAS', 'PagoCorresponsal.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCO_NPDF', 'PagoCorresponsal_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVG_NXML', 'gruposvencigerent.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVG_NJAS', 'GrupoVenciGeren.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVG_NPDF', 'GrupoVenciGeren_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVC_NXML', 'gruposvencicoord.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVC_NJAS', 'GrupoVenciCoord.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGVC_NPDF', 'GrupoVenciCoord_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFCVE_NXML', 'vencicuotas.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFCVE_NJAS', 'AvisoVencCuotas.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFCVE_NPDF', 'AvisoVencCuotas_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFIAV_NXML', 'IncumplimientoAval.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFIAV_NJAS', 'IncumplimientoAvalista.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFIAV_NPDF', 'IncumplimientoAvalista_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLQ_NXML', 'pagogaraliq.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLQ_NJAS', 'GarantiasLiquidas.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFGLQ_NPDF', 'GarantiasLiquidas_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCV_NXML', 'PagoCorresponsal.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCV_NJAS', 'PagoCorresponsal.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'PFPCV_NPDF', 'PagoCorresponsal_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NXML', 'NotificacionGeneral.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NJAS', 'NotificacionGeneral.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NPDF', 'NotificacionGeneral_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NXML', 'ReferenciaPreCancelacion.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NJAS', 'ReferenciaPreCancelacion.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NPDF', 'ReferenciaPreCancelacion_', 'V')

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCUE_NXML', 'AccountStatus.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCUE_NJAS', 'AccountStatus.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'ETCUE_NPDF', 'EstadoCuenta_', 'V')

update cobis..cl_seqnos set siguiente = @w_tabla where tabla = 'cl_tabla'


insert into cl_catalogo_pro
select 'CCA', codigo
  from cl_tabla 
 where cl_tabla.tabla like 'ca_%'

go

insert into cl_catalogo_pro
select 'CCA', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('ca_param_notif')

go




