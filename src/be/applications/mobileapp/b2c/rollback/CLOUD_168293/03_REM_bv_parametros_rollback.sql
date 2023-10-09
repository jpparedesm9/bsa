use cobis
go
delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('IDCHAN','IDORIG','IDCOUN','URLPRO','URLDOM','URLPOR','TIFLOW','BOUPRO','BOUDO1','BOUDO2','BOUDO3','BOUDO4','BOUURI','BOUPOR')
delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('FIBRNC','FICHNL','FITRTP', 'FIUPRO', 'FIUDO1', 'FIUDO2', 'FIUDO3', 'FIUPOR', 'FIUURI')
delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('NUMINT')
delete cl_parametro where pa_producto = 'CLI'  and pa_nemonico in ('MOVAIN')

go
