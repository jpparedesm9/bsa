use cobis
go
/*************/
/*   TABLA   */
/*************/
delete cl_catalogo_pro from cl_tabla
where  cl_tabla.tabla = 're_marca_servicio'
  and  codigo = cp_tabla

delete cl_catalogo from cl_tabla
where  cl_tabla.tabla = 're_marca_servicio'
  and  cl_tabla.codigo = cl_catalogo.tabla

delete cl_tabla
where  cl_tabla.tabla = 're_marca_servicio'
go

---------------------------------------------------------------------------------------------------
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


select @w_codigo = @w_codigo + 1
print 'Marcas de servicios'
insert into cl_tabla (codigo, tabla, descripcion) values (@w_codigo, 're_marca_servicio', 'Signo de Causas de ND/NC')
insert into cl_catalogo_pro values ('REM', @w_codigo)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'CNB',  'SERVICIO PARA ABONO DE COMISIONES CB', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'COM', 'COMERCIO BANCAMOVIL', 'V')
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_codigo, 'REMWU', 'RECEPCION DE REMESAS WU', 'V')
---------------------------------------------------------------------------------------------------


update cl_seqnos set siguiente = @w_codigo
    where tabla='cl_tabla'