use cobis
go

if exists (select 1 from cobis..cl_parametro where pa_producto = 'CCA' AND pa_nemonico = 'AN31DS')
    delete cobis..cl_parametro where pa_producto = 'CCA' AND pa_nemonico = 'AN31DS'
else
    print 'ya no existe para parametro AN31DS de CCA'
	
select * from cobis..cl_parametro where pa_producto = 'CCA' AND pa_nemonico = 'AN31DS'

go
