/* ************************************************************************* */
--                    No Bug: 75550
--            Título del Bug: MAN - Mantenimiento Causales ND/NC por oficina
--                     Fecha: 23/Junio/2016
--  Descripción del Problema: No existe catálogo del campo Catálogo.
--Descripción de la Solución: Se inserta el catalogo ah_tablas_causales_ndc
--                     Autor: Walther Toledo Q.
/* ************************************************************************* */

use cobis
go

/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('ah_tablas_causales_ndc')
  and codigo = cp_tabla
go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('ah_tablas_causales_ndc')
   and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
 where cl_tabla.tabla in ('ah_tablas_causales_ndc')
go

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

select @w_codigo= @w_codigo + 1
print 'Tablas Causales Notas Debito/Notas Credito'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'ah_tablas_causales_ndc', 'Tablas Causales ND/NC')
insert into cl_catalogo_pro values ('AHO', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '1', 'ah_causa_nc', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, '2', 'ah_causa_nd', 'V')