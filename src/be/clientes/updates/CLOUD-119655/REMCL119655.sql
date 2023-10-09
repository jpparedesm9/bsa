
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Requerimiento 119655: Cambios WEB APP Auditoría
--Fecha                      : 29/05/2019
--Descripción del Problema   : 
--Descripción de la Solución : 
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- INSERTAR PARAMETROS
--------------------------------------------------------------------------------------------

delete cobis..cl_parametro where pa_nemonico  in ('EDADMA')

insert into cobis..cl_parametro values ('EDAD DE ADULTOS MAYORES', 'EDADMA', 'T', null, 70, null, null, null, null, null, 'CLI')
go

--------------------------------------------------------------------------------------------
-- INSERTAR ERRORES
--------------------------------------------------------------------------------------------

delete cobis..cl_errores where numero in (101269)

insert into cobis..cl_errores values (101269, 0, 'El correo electrónico ingresado ya fue registrado')
go





--------------------------------------------------------------------------------------------
-- CREAR TABLA
--------------------------------------------------------------------------------------------

use cobis
go

IF OBJECT_ID ('dbo.cl_clientes_calif') IS NOT null
	DROP TABLE dbo.cl_clientes_calif
GO

create table cl_clientes_calif (
	cc_ente		int not null,
	cc_calif    char(1)
)
CREATE NONCLUSTERED INDEX cl_clientes_calif
	ON dbo.cl_clientes_calif (cc_ente)
GO





--------------------------------------------------------------------------------------------
-- AGREGAR PARAMETROS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Main/PreProd/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql

use cobis
go

--CAMBIAR TIPO DE DATO DE PUNTAJE
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_puntaje_riesgo_cg ' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_puntaje_riesgo_cg  char(3) null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_puntaje_riesgo_cg  char(3) null
end

--FECHA EVALUACION RIESGO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_fecha_evaluacion' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_fecha_evaluacion datetime null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_fecha_evaluacion datetime null
end

--SUMA RIESGO VENCIDO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_sum_vencido' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_sum_vencido money null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_sum_vencido money null
end
--NUMERO RIESGO VENCIDO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_num_vencido' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_num_vencido int null
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_num_vencido int null
end

use cob_sincroniza
go
--NUMERO RIESGO VENCIDO
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'sid_observacion' and TABLE_NAME = 'si_sincroniza_det')
begin
    alter table cob_sincroniza..si_sincroniza_det add sid_observacion varchar(5000) null
end
else
begin
	alter table cob_sincroniza..si_sincroniza_det alter column sid_observacion varchar(5000) null
end

--------------------------------------------------------------------------------------------
-- CATALOGO MATRIZ -
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go

delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_calificacion_riesgo_ext')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_calificacion_riesgo_ext', 'Calificacion Riesgo Individual Externo')
--Insertando Catalogos
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'A', 'A', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'B', 'B', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'C', 'C', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'D', 'D', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'E', 'E', 'V', null, null, null)
insert into cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'F', 'F', 'V', null, null, null)


-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_calificacion_riesgo_ext')
go

--CAMPO DE REFERENCIA
use cobis
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'di_referencia' and TABLE_NAME = 'cl_direccion')
begin
    alter table cobis..cl_direccion add di_referencia varchar(250) null
end
else
begin
	alter table cobis..cl_direccion alter column di_referencia varchar(250) null
end




--SERVICIO DE VALIDACION DE CORREOS


use cobis
go

delete from cobis..cl_errores where numero = 70074
insert into cobis..cl_errores values (70074, 0,'Es necesario actualizar el correo electrónico')
go

delete from cobis..cl_errores where numero = 70075
insert into cobis..cl_errores values (70075, 0,'Es necesario ingresar el campo REFERENCIAS en la Dirección de Negocio/Domicilio del cliente')
go

use cobis
GO


    
IF EXISTS (SELECT * FROM cts_serv_catalog WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.ValidateAddress')
	UPDATE cts_serv_catalog SET csc_class_name = 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', csc_method_name = 'validateAddress', csc_description = '', csc_trn = 1227 WHERE csc_service_id = 'CustomerDataManagementService.CustomerManagement.ValidateAddress'
ELSE
	INSERT INTO cts_serv_catalog (csc_service_id, csc_class_name, csc_method_name, csc_description, csc_trn ) VALUES ('CustomerDataManagementService.CustomerManagement.ValidateAddress', 'cobiscorp.ecobis.customerdatamanagementservice.service.ICustomerManagement', 'validateAddress', '', 1227)
GO
	  
	  
  
delete from cobis..ad_servicio_autorizado where ts_servicio = 'CustomerDataManagementService.CustomerManagement.ValidateAddress' 
and ts_rol in (1,2,10,11,12,13,14,19,29)

insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.ValidateAddress' ,1,7,'R',0,getDate(),'V',getDate())

insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.ValidateAddress' ,2,7,'R',0,getDate(),'V',getDate())

insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.ValidateAddress' ,10,7,'R',0,getDate(),'V',getDate())

insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.ValidateAddress' ,11,7,'R',0,getDate(),'V',getDate())

insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.ValidateAddress' ,12,7,'R',0,getDate(),'V',getDate())

insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.ValidateAddress' ,13,7,'R',0,getDate(),'V',getDate())

insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.ValidateAddress' ,14,7,'R',0,getDate(),'V',getDate())

insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.ValidateAddress' ,19,7,'R',0,getDate(),'V',getDate())

insert into cobis..ad_servicio_autorizado
values('CustomerDataManagementService.CustomerManagement.ValidateAddress' ,29,7,'R',0,getDate(),'V',getDate())

---	CAMPO PARA INGRESOS DE NEGOCIO MENSUAL
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where COLUMN_NAME = 'ea_ingreso_negocio' and TABLE_NAME = 'cl_ente_aux')
begin
    alter table cobis..cl_ente_aux add ea_ingreso_negocio money
end
else
begin
	alter table cobis..cl_ente_aux alter column ea_ingreso_negocio money
end

go

--gerente de oficina - mantenimiento de personas naturales
use cobis
go
declare @w_rol int, @w_resource int
select @w_rol = ro_rol from ad_rol where ro_descripcion='GERENTE OFICINA'
select @w_resource = re_id from cew_resource where re_pattern='/cobis/web/views/CSTMR/.*'
delete from cew_resource_rol where rro_id_rol = @w_rol and rro_id_resource = @w_resource
insert into cew_resource_rol values(@w_resource,@w_rol)
go
