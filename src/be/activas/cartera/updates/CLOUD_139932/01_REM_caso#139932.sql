use cobis
go

if not exists (select 1 from cobis..cl_parametro where pa_producto = 'CCA' AND pa_nemonico = 'AN31DS')
    INSERT INTO cobis..cl_parametro VALUES('ACTIVAR 3 DIAS ANTES PARA 1ER DSD CALCULO DIAS MORA Y MAX', 'AN31DS', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
else
    print 'ya existe para parametro AN31DS de CCA'
	
select * from cobis..cl_parametro where pa_producto = 'CCA' AND pa_nemonico = 'AN31DS'

go
