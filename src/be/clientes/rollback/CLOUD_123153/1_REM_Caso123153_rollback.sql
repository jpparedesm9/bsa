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
