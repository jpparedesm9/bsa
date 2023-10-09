--------------------------------------------------------------------------------------------
-- CATALOGO ESTADOS DE DISPOSITIVOS QUE NO DEBEN SER SINCRONIZADOS
--------------------------------------------------------------------------------------------
use cobis
go

/*Select inicial*/
select * from cl_catalogo_pro, cl_tabla where tabla in ('cl_correo_activar') 
and codigo = cp_tabla
select * from cl_catalogo, cl_tabla where cl_tabla.tabla in ('cl_correo_activar')
and cl_tabla.codigo = cl_catalogo.tabla
select * from  cl_tabla where cl_tabla.tabla in ('cl_correo_activar')

/*Eliminar Registros*/
delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_correo_activar')
  and codigo = cp_tabla

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_correo_activar')
  and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where cl_tabla.tabla in ('cl_correo_activar')
go

/*Declarando para crear catalogo*/
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'cl_correo_activar', 'Listado de Correo para activiar o desactivarlos')

--Insertando Catalogos
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'NOTACTINFO', 'NOTIFICACION DE ACTUALIZACION DE INFORMACION', 'B', NULL, NULL, NULL)

insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'CREDISPONI', 'TU CREDITO YA ESTA DISPONIBLE', 'B', NULL, NULL, NULL)

insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'NOTAUTSDC', 'NOTIFICACION AUTOMATICA - SOLICITUD DE CREDITO', 'B', NULL, NULL, NULL)


-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('cl_correo_activar')

/*Select final*/
select * from cl_catalogo_pro, cl_tabla where tabla in ('cl_correo_activar') 
and codigo = cp_tabla
select * from cl_catalogo, cl_tabla where cl_tabla.tabla in ('cl_correo_activar')
and cl_tabla.codigo = cl_catalogo.tabla
select * from  cl_tabla where cl_tabla.tabla in ('cl_correo_activar')
go