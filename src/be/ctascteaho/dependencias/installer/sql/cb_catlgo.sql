use cobis
go

/*************/
/*   TABLA   */
/*************/

delete cl_catalogo_pro
  from cl_tabla
 where tabla in ('cb_tipo_impuesto')
  and codigo = cp_tabla

go

delete cl_catalogo
  from cl_tabla
 where cl_tabla.tabla in ('cb_tipo_impuesto')
   and cl_tabla.codigo = cl_catalogo.tabla

go

delete cl_tabla
 where cl_tabla.tabla in ('cb_tipo_impuesto')
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
select @w_codigo = @w_codigo + 1
print 'Tipo Impuesto'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 'cb_tipo_impuesto','Tipo Impuesto')
insert into cl_catalogo_pro values ('CON', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'V','IVA COBRADO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'C','ICA','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'E','ESTAMPILLAS','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'I','IVA RETENIDO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'P','IVA PAGADO','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'R','RETEFUENTE','V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo,'T','TIMBRE','V')

----------------------------------------------------------------------------------------------

update cl_seqnos
   set siguiente = @w_codigo
 where tabla = 'cl_tabla'

go

