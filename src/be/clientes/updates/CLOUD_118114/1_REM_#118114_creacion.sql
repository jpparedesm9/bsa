--------------------------------------------------------------------------------------------
--REMEDIACION
--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
-- Error
--------------------------------------------------------------------------------------------
use cobis
go
select * from cl_errores where numero = 2109114

delete from cl_errores where numero = 2109114

insert into cl_errores (numero, severidad, mensaje)
values (2109114, 1, 'El estado no permite sincronizar')

select * from cl_errores where numero = 2109114
go

--------------------------------------------------------------------------------------------
-- Error
--------------------------------------------------------------------------------------------
use cobis
go
select * from cl_errores where numero = 2109115

delete from cl_errores where numero = 2109115

insert into cl_errores (numero, severidad, mensaje)
values (2109115, 1, 'El Oficial ya tiene asignado este móvil')

select * from cl_errores where numero = 2109115
go

--------------------------------------------------------------------------------------------
-- Error
--------------------------------------------------------------------------------------------
use cobis
go
select * from cl_errores where numero = 2109116

delete from cl_errores where numero = 2109116

insert into cl_errores (numero, severidad, mensaje)
values (2109116, 1, 'Un Oficial ya tiene asignado este móvil')

select * from cl_errores where numero = 2109116
go

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

/*Declarando para crear catalogo*/
declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

--Creando Tabla
insert into cobis..cl_tabla (codigo, tabla, descripcion)
values (@w_tabla, 'mo_device_status_no_sincro', 'Estado del dispositivo movil que no deben ser sincronizados')

--Insertando Catalogos
insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'L', 'BLOQUEADO', 'V', NULL, NULL, NULL)

insert into dbo.cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
values (@w_tabla, 'U', 'NO_SUSCRITO', 'V', NULL, NULL, NULL)

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_tabla 
where tabla  = 'cl_tabla' 

insert into cl_catalogo_pro
select 'CLI', codigo
  from cl_tabla 
 where cl_tabla.tabla in ('mo_device_status_no_sincro')

/*Select final*/
select * from cl_catalogo_pro, cl_tabla where tabla in ('mo_device_status_no_sincro') 
and codigo = cp_tabla
select * from cl_catalogo, cl_tabla where cl_tabla.tabla in ('mo_device_status_no_sincro')
and cl_tabla.codigo = cl_catalogo.tabla
select * from  cl_tabla where cl_tabla.tabla in ('mo_device_status_no_sincro')
go
