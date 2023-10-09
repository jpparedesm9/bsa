

use cobis
go

/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ( 'cl_producto','cl_moneda')
   and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cl_producto','cl_moneda')
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where cl_tabla.tabla in ('cl_producto','cl_moneda')
go

----------------------------------------------------------------------------------------------
declare @w_maxtabla smallint
select @w_maxtabla = max(codigo) + 1
from cl_tabla

update cl_seqnos
set siguiente = @w_maxtabla
where tabla = 'cl_tabla'

declare @w_codigo smallint
select @w_codigo = siguiente + 1
  from cl_seqnos
 where tabla = 'cl_tabla'
----------------------------------------------------------------------------------------------
 
select @w_codigo= @w_codigo + 1
print 'Productos COBIS'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cl_producto', 'PRODUCTOS COBIS')
insert into cl_catalogo_pro values ('ADM', @w_codigo)
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '1', 'ADMINISTRACION', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '2', 'MANAGEMENT INFORMATION SYSTEM', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '3', 'CUENTA CORRIENTE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '4', 'CUENTA DE AHORROS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '5', 'FIRMAS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '6', 'CONTABILIDAD', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '7', 'CARTERA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '8', 'BATCH', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '10', 'REMESAS Y CAMARA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '13', 'ATX - BRANCH', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '14', 'DEPOSITOS A PLAZO FIJO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '19', 'GARANTIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '21', 'CREDITO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '26', 'BRANCH EXPLORER - SAIP', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '36', 'REPORTES SUPER BANCARIA', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '42', 'SERVICIOS BANCARIOS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '60', 'HERRAMIENTA CUADRE CONTABLE', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '177', 'PALM COBIS', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '201', 'NOMINA', 'V')

----------------------------------------------------------------------------------------------


update cl_seqnos
   set siguiente = @w_codigo
 where tabla = 'cl_tabla'

 go

