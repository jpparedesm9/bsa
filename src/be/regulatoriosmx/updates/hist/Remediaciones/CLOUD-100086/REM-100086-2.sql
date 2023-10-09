use cob_cartera
go

update cob_cartera..ca_producto
set cp_descripcion = 'GARANTIA'
where cp_producto in ('GAR_CRE', 'GAR_DEB')

go
