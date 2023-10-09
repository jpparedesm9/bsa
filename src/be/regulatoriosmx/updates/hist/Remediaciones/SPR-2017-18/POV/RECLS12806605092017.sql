/**********************************************************************************************************************/
--No Bug                       : NA
--Titulo de la Historia        : CGS-S128066 Formato Mensajes
--Fecha                        : 04/08/2017
--Descripcion del Problema     : No existe código fuente para Notificaciones Generales
--Descripcion de la Solucion   : Crear tablas y errores para Notificaciones Generales
--Autor                        : Paul Ortiz Vera
/**********************************************************************************************************************/


---------------------------------------------------------------------------------------
-------------------------- Crear tabla de  validar secciones --------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql

use cobis
go


IF OBJECT_ID ('dbo.cl_notificacion_general') IS NOT NULL
	DROP TABLE dbo.cl_notificacion_general
GO

CREATE TABLE dbo.cl_notificacion_general
	(
	ng_codigo           int not null,
	ng_mensaje          VARCHAR(1000) NOT null,
	ng_correo         	VARCHAR(60) NOT NULL,
	ng_asunto           VARCHAR(255) NOT null
	)
GO

CREATE UNIQUE CLUSTERED INDEX cl_notificacion_general_Key
	ON dbo.cl_notificacion_general (ng_codigo)
GO

--------------------------------------------------------------------------------------------
-- Insertar en tabla de secuenciales
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_ins.sql


use cobis
go


DELETE cobis..cl_seqnos where bdatos = 'cobis' and tabla = 'cl_notificacion_general'

INSERT INTO dbo.cl_seqnos (bdatos, tabla, siguiente, pkey)
VALUES ('cobis', 'cl_notificacion_general', 0, 'ng_codigo')
GO

---------------------------------------------------------------------------------------
-------------------------- Crear tabla de  validar secciones --------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_table.sql

use cobis
go

IF OBJECT_ID ('dbo.cl_ns_generales_estado') IS NOT NULL
	DROP TABLE dbo.cl_ns_generales_estado
GO

CREATE TABLE dbo.cl_ns_generales_estado
	(
	nge_codigo 	INT NOT NULL,
	nge_estado  	CHAR (1) NOT NULL
	)
GO


CREATE UNIQUE CLUSTERED INDEX cl_ns_generales_estado_Key
	ON dbo.cl_ns_generales_estado (nge_codigo)
GO


---------------------------------------------------------------------------------------
-------------------------- Crear tabla de  validar secciones --------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : cl_error.sql

delete cl_errores where numero IN (103152,103153)

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103152, 0, ' Error al insertar Notificación General ')

insert into cobis..cl_errores (numero, severidad, mensaje)
values (103153, 0, ' Error al insertar estado de Notificación General ')

go


---------------------------------------------------------------------------------------
-------------------------- Crear tabla de  validar secciones --------------------------
---------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_catalogo.sql


use cobis
go


delete cl_catalogo_pro
from cl_tabla
where tabla in ('ca_param_notif')
  and codigo = cp_tabla
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

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NXML', 'NotificacionGeneral.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NJAS', 'NotificacionGeneral.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'NTGNR_NPDF', 'NotificacionGeneral_', 'V')

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



go

