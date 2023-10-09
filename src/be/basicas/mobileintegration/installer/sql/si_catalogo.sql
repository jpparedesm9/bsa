/**********************************************************************/
/*   Archivo:         si_catalogo.sql                                 */
/*   Data base:       cobis                                           */
/**********************************************************************/
/*                     IMPORTANTE                                     */
/*   Esta aplicacion es parte de los  paquetes bancarios              */
/*   propiedad de COBISCORP.                                          */
/*   Su uso no autorizado queda  expresamente  prohibido              */
/*   asi como cualquier alteracion o agregado hecho  por              */
/*   alguno de sus usuarios sin el debido consentimiento              */
/*   por escrito de COBISCORP.                                        */
/*   Este programa esta protegido por la ley de derechos              */
/*   de autor y por las convenciones  internacionales de              */
/*   propiedad intelectual.  Su uso  no  autorizado dara              */
/*   derecho a COBISCORP para obtener ordenes  de secuestro           */
/*   o  retencion  y  para  perseguir  penalmente a  los              */
/*   autores de cualquier infraccion.                                 */
/**********************************************************************/
/*                      PROPOSITO                                     */
/*      Creación de catalogos para el módulo MOVILEINTEGRATION        */
/**********************************************************************/
/*                      MODIFICACIONES                                */
/*   FECHA              AUTOR                  RAZON                  */
/*   02-08-2017         Paúl Ortiz             Emision Inicial        */
/**********************************************************************/

/* Creación de catalogos para el módulo móvil */

USE cobis
GO

delete cl_catalogo_pro
from cl_tabla
where tabla in ('si_tipo_movil', 'si_sincroniza', 'mo_device_status','cr_filtro_terminal','si_sinc_estado','mo_device_status_no_sincro')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('si_tipo_movil', 'si_sincroniza', 'mo_device_status','cr_filtro_terminal','si_sinc_estado','mo_device_status_no_sincro')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('si_tipo_movil', 'si_sincroniza', 'mo_device_status','cr_filtro_terminal','si_sinc_estado','mo_device_status_no_sincro')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'si_tipo_movil', 'Tipos de Sistemas Operativos Movil')

--Insertando Catalogos

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'AD', 'ANDROID', 'V', NULL, NULL, NULL)

GO
--///////////////////////////////////////////

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'si_sincroniza', 'Entidades a Sincronizar - Movil')

--Insertando Catalogos

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '1', 'CLIENTE', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '2', 'GRUPO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '3', 'SOLICITUD GRUPAL', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '4', 'SOLICITUD INDIVIDUAL', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '5', 'PAGOS', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '6', 'CUESTIONARIO GRUPAL', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '7', 'CUESTIONARIO INDIVIDUAL', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '8', 'AGENDA', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '9', 'DOCUMENTOS DIGITALIZADOS LCR', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '10', 'FIRMAS Y CUESTIONARIO COLECTIVO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '11', 'CUESTIONARIO COLECTIVO', 'V', NULL, NULL, NULL)
go

--///////////////////////////////////////////

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'mo_device_status', 'Estado del dispositivo mobil')

--Insertando Catalogos

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'P', 'PRE_REGISTRADO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'R', 'REGISTRADO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'L', 'BLOQUEADO', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'U', 'NO_SUSCRITO', 'V', NULL, NULL, NULL)
GO


--///////////////////////////////////////////

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'si_sinc_estado', 'Estado de la sincronización')

--Insertando Catalogos
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'P', 'Pendiente', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'D', 'Descargando', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'S', 'Sincronizado', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, 'E', 'Eliminado ', 'V', NULL, NULL, NULL)


--Catalogo filtro terminales

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando tabla cr_filtro_terminal
INSERT INTO cl_tabla (codigo, tabla, descripcion)
VALUES ( @w_tabla, 'cr_filtro_terminal', 'Filtro para terminales')

--Insertando registros  cr_filtro_terminal
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES ( @w_tabla, 'NAME', 'Nombre del Equipo', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES ( @w_tabla, 'MAC', 'MAC', 'V', NULL, NULL, NULL)

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES ( @w_tabla, 'DESC', 'Descripción', 'V', NULL, NULL, NULL)

--Insertando Catalogos para dispositivos que no deen ser sincronizados
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'mo_device_status_no_sincro', 'Estado del dispositivo movil que no deben ser sincronizados')

insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'L', 'BLOQUEADO', 'V', NULL, NULL, NULL)

insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'U', 'NO_SUSCRITO', 'V', NULL, NULL, NULL)

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
GO

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('si_tipo_movil', 'si_sincroniza', 'mo_device_status','cr_filtro_terminal','mo_device_status_no_sincro')
go



