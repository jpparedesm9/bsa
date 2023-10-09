use cob_cartera
go

update cob_cartera..ca_producto
set cp_descripcion = 'INCREMENTAR VALOR DE LA GARANTIA'
where cp_producto = 'GAR_CRE'

update cob_cartera..ca_producto
set cp_descripcion = 'DISMINUIR VALOR DE LA GARANTIA'
where cp_producto = 'GAR_DEB'

go