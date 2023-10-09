----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>
----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>
--cr_doc_prospecto
use cobis
go

print 'cr_doc_prospecto'

declare @w_tabla smallint
select @w_tabla = codigo from cl_tabla where tabla = 'cr_doc_prospecto'

select * from cobis..cl_catalogo where tabla = @w_tabla and codigo = '009'
delete cobis..cl_catalogo where tabla = @w_tabla and codigo = '009'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '009', 'ACTA DE NACIMIENTO', 'V')

----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>
----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>----------->>>>>>>>>>>
--cr_doc_digitalizado_ind
use cobis
go

print 'cr_doc_digitalizado_ind'

declare @w_tabla smallint
select @w_tabla = codigo from cl_tabla where tabla = 'cr_doc_digitalizado_ind'

select * from cobis..cl_catalogo where tabla = @w_tabla and codigo = '009'
delete cobis..cl_catalogo where tabla = @w_tabla and codigo = '009'
insert into cobis..cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '009', 'ACTA DE NACIMIENTO', 'V')

go