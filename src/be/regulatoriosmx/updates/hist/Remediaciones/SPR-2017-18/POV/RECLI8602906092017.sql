/**********************************************************************************************************************/
--No Bug                       : NA
--Titulo de la Historia        : Incidencia #86029
--Fecha                        : 06/08/2017
--Descripcion del Problema     : No existe código fuente para Notificaciones Generales
--Descripcion de la Solucion   : Crear tablas y errores para Notificaciones Generales
--Autor                        : Paul Ortiz Vera
/**********************************************************************************************************************/



--------------------------------------------------------------------------------------------
-- Crear Catalogo
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
--Nombre Archivo             : 4_sta_catalogo.sql


USE cobis
GO



delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_modulo_cliente')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_modulo_cliente')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cl_modulo_cliente')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
INSERT INTO cobis..cl_tabla (codigo, tabla, descripcion)
VALUES (@w_tabla, 'cl_modulo_cliente', 'Modulos de Clientes')

--Insertando Catalogos
INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '1', 'INFORMACION GENERAL', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '2', 'DIRECCIONES Y CORREO', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '3', 'NEGOCIOS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '4', 'REFERENCIAS', 'V', NULL, NULL, NULL)

INSERT INTO cobis..cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '5', 'DOCUMENTOS DIGITALIZADOS', 'V', NULL, NULL, NULL)

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_modulo_cliente')
go



