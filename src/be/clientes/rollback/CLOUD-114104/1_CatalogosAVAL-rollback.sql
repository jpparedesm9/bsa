use cobis
go

declare
@w_ca_fl_ind int

select @w_ca_fl_ind = (select codigo from cobis..cl_tabla where tabla = 'cr_doc_digitalizado_flujo_ind')

delete cobis..cl_catalogo where tabla=@w_ca_fl_ind and codigo='011'
delete cobis..cl_catalogo where tabla=@w_ca_fl_ind and codigo='012'
