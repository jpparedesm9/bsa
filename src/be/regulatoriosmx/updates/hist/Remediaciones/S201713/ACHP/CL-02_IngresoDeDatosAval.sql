/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S121906 Ingreso de Solicitud - Flujo Individual
--Fecha                      : 06/07/2017
--Descripción del Problema   : Agregar pantalla de Aval - campos nuevos en ingreso de datos
--Descripción de la Solución : Agregar pantalla de Aval - campos nuevos en ingreso de datos
--Autor                      : Adriana Chiluisa
/**********************************************************************************************************************/

-------------------------------------------------------------------------------------------
-- Registro de pantallas para individual
--------------------------------------------------------------------------------------------
--Instalador                 : an_component.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql
--------------
PRINT 'Registro de pantallas para individual'
--------------
use cobis
go

DECLARE @w_co_id INT, 
        @w_prod_name varchar(10), 
        @w_mo_id int

SELECT @w_prod_name = 'WF' 
SELECT @w_mo_id = mo_id  
from   cobis..an_module 
where  mo_name = 'IBX.InboxOficial'
 
SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component 

SELECT @w_co_id =  isnull(@w_co_id,1)
SELECT @w_mo_id = isnull(@w_mo_id ,1)

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=E')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Ingreso de Datos - Individual', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=E', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, @w_prod_name)
end 

SELECT @w_co_id = max(co_id) + 1 FROM cobis..an_component

IF NOT EXISTS (SELECT 1 FROM an_component WHERE co_class = 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=Q')
begin
	INSERT INTO an_component (co_id, co_mo_id, co_name, co_class, co_namespace, co_ct_id, co_arguments, co_prod_name)
	VALUES (@w_co_id, @w_mo_id, 'Ingreso de Datos - Individual Consulta', 'VC_OIIRL51_CNLTO_343_TASK.html?SOLICITUD=NORMAL&MODE=Q', 'views/BUSIN/FLCRE/T_FLCRE_82_OIIRL51/1.0.0/', 'I', NULL, @w_prod_name)
	                                                                       
end 
GO

-------------------------------------------------------------------------------------------
-- REGISTRO CATALOGOS
--------------------------------------------------------------------------------------------
--Instalador                 : cr_catalogos.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--------------------------------------------------------------------------------------------
PRINT '--->> Registro de catalogos-cr_plazo_ind'
use cobis
go
declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cr_plazo_ind'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_plazo_ind', 'PLAZOS PARA INDIVIDUAL')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end

delete from cobis..cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '1', '1', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '2', '2', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '3', '3', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '4', '4', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '5', '5', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '6', '6', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '7', '7', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '8', '8', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '9', '9', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '10', '10', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '11', '11', 'V' )
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tabla, '12', '12', 'V' )
GO

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
PRINT '--->> Registro de catalogos-cr_tplazo_ind'
use cobis
go
declare @w_tabla int

select @w_tabla = codigo from cl_tabla where tabla = 'cr_tplazo_ind'

if isnull(@w_tabla,0) = 0
begin
    select @w_tabla = isnull(max(codigo), 0) + 1
    from   cobis..cl_tabla

    insert into cobis..cl_tabla (codigo, tabla, descripcion)
    values (@w_tabla,'cr_tplazo_ind', 'FRECUENCIA PARA INDIVIDUAL')

    insert into cobis..cl_catalogo_pro (cp_producto, cp_tabla)
    values ('CRE', @w_tabla)

    update cobis..cl_seqnos
    set    siguiente = @w_tabla + 1
    where  tabla = 'cl_tabla'
end

delete from cobis..cl_catalogo where tabla = @w_tabla

INSERT INTO cl_catalogo (tabla, codigo, valor, estado)
SELECT @w_tabla, td_tdividendo, td_descripcion, td_estado
FROM cob_cartera..ca_tdividendo
GO

-------------------------------------------------------------------------------------------
-- REGISTRO de Servicios
--------------------------------------------------------------------------------------------
--Instalador                 : $/COB/Desarrollos/DEV_SaaSMx/SSSuite/BusinessProcess/source/backend/sql
--Ruta Instalador            : service_authorization.sql
print '-- REGISTRO DE SERVICIOS'
go

use cobis
go

declare @w_rol int,
        @w_producto int

if not exists (select 1 from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS')
begin
    select @w_rol =  max(ro_rol)+1 from cobis..ad_rol
    insert into cobis..ad_rol (ro_rol, ro_filial, ro_descripcion, ro_fecha_crea, ro_creador, ro_estado, ro_fecha_ult_mod, ro_time_out)
    values (@w_rol, 1, 'MENU POR PROCESOS', getdate(), 1, 'V', getdate(), 9000)
end
select @w_rol = ro_rol from cobis..ad_rol where ro_descripcion = 'MENU POR PROCESOS'
select @w_producto = pd_producto from cl_producto where pd_descripcion = 'MANAGEMENT INFORMATION SYSTEM'

delete cts_serv_catalog where csc_service_id in ('CustomerDataManagementService.CustomerManagement.ReadDataCustomer')

--CREATE VERIFICATION
insert into cts_serv_catalog
(csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn, csc_support_offline, csc_component, csc_procedure_validation)
values('CustomerDataManagementService.CustomerManagement.ReadDataCustomer',  'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'readCustomer', '', 132, null, null, 'N')

delete ad_servicio_autorizado where ts_servicio in ('CustomerDataManagementService.CustomerManagement.ReadDataCustomer')

insert into ad_servicio_autorizado
(ts_servicio, ts_producto, ts_tipo, ts_moneda, ts_fecha_aut, ts_rol, ts_estado, ts_fecha_ult_mod)
values('CustomerDataManagementService.CustomerManagement.ReadDataCustomer', @w_producto, 'R', 0, getdate(), @w_rol, 'V', getdate())

go
