--------------------------------------------------------------------------------------------
--ROLLBACK
--------------------------------------------------------------------------------------------
-- Error
--------------------------------------------------------------------------------------------
use cobis
go
select * from cl_errores where numero = 2109114
delete from cl_errores where numero = 2109114

select * from cl_errores where numero = 2109115
delete from cl_errores where numero = 2109115

select * from cl_errores where numero = 2109116
delete from cl_errores where numero = 2109116

--------------------------------------------------------------------------------------------
-- CATALOGO ESTADOS DE DISPOSITIVOS QUE NO DEBEN SER SINCRONIZADOS
--------------------------------------------------------------------------------------------
use cobis
go

/*Select inicial*/
select * from cl_catalogo_pro, cl_tabla where tabla in ('mo_device_status_no_sincro') 
and codigo = cp_tabla
select * from cl_catalogo, cl_tabla where cl_tabla.tabla in ('mo_device_status_no_sincro')
and cl_tabla.codigo = cl_catalogo.tabla
select * from  cl_tabla where cl_tabla.tabla in ('mo_device_status_no_sincro')

/*Eliminar Registros*/
delete cl_catalogo_pro
from cl_tabla
where tabla in ('mo_device_status_no_sincro')
  and codigo = cp_tabla

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('mo_device_status_no_sincro')
  and cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where cl_tabla.tabla in ('mo_device_status_no_sincro')
go

/*Select final*/
select * from cl_catalogo_pro, cl_tabla where tabla in ('mo_device_status_no_sincro') 
and codigo = cp_tabla
select * from cl_catalogo, cl_tabla where cl_tabla.tabla in ('mo_device_status_no_sincro')
and cl_tabla.codigo = cl_catalogo.tabla
select * from  cl_tabla where cl_tabla.tabla in ('mo_device_status_no_sincro')
go
