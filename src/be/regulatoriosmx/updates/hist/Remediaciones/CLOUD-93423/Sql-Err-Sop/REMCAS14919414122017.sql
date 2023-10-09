
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : 
--Fecha                      : 14/12/2017
--Descripción del Problema   : No existen instaladores referentes a lo contenido en el archivo
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Crear TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

USE cob_cartera
go

IF OBJECT_ID ('dbo.ca_ns_precancela_refer') IS NOT NULL
    DROP TABLE dbo.ca_ns_precancela_refer
GO

CREATE TABLE ca_ns_precancela_refer
	(
	npr_codigo INT NOT NULL,
	npr_operacion INT NOT NULL,
	npr_estado CHAR (1) NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX ca_ns_precancela_refer_Key
	ON dbo.ca_ns_precancela_refer (npr_codigo, npr_operacion)
GO



--------------------------------------------------------------------------------------------
-- Crear CATALOGO
--------------------------------------------------------------------------------------------
--Ruta TFS                   : 
--Nombre Archivo             : 

use cobis
go


delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CCA'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('ca_param_notif')
go

delete cl_catalogo_pro
  from cl_tabla
 where cp_producto = 'CCA'
   and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla in ('cl_tipos_contratos_camp')
   

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

insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NXML', 'ReferenciaPreCancelacion.xml', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NJAS', 'ReferenciaPreCancelacion.jasper', 'V')
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'GRPCN_NPDF', 'ReferenciaPreCancelacion_', 'V')

update cobis..cl_seqnos set siguiente = @w_tabla where tabla = 'cl_tabla'


insert into cl_catalogo_pro
select 'CCA', codigo
  from cl_tabla 
 where cl_tabla.tabla like 'ca_param_notif%'

go

insert into cl_catalogo_pro
select 'CCA', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_tipos_contratos_camp')

go

