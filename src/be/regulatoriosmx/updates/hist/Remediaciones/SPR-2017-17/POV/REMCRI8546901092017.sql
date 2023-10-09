
/**********************************************************************************************************************/
--No Bug                     : Incidencia #85469
--Título de la Historia      : NA
--Fecha                      : 01/09/2017
--Descripción del Problema   : Faltan registros en catalogos
--Descripción de la Solución : Reinsertar la tabla del catalogo
--Autor                      : Paúl Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- Crear Catalogo
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_catalogos.sql


USE cobis
GO



delete cl_catalogo_pro
from cl_tabla
where tabla in ('cr_tipo_local')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cr_tipo_local')
  and cl_tabla.codigo = cl_catalogo.tabla
go
delete cl_tabla
where cl_tabla.tabla in ('cr_tipo_local')
go

declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla


insert into cl_tabla values (@w_tabla, 'cr_tipo_local', 'TIPO DE LOCAL') 
insert into cl_catalogo_pro values ('CRE ', @w_tabla)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'1','PROPIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'2','RENTADO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'3','MISMO DE DOMICILIO','V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla,'4','MERCADO','V')

-- Actualizacion secuencial tabla de catalogos

update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 
go


