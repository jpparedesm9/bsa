use cobis
go

delete from cobis..cl_parametro
where pa_nemonico='CPSATC'
and pa_producto='REC'

select * from cobis..cl_parametro
where pa_nemonico='CPSATC'
and pa_producto='REC'

go

use cobis
go

delete cl_parametro where pa_nemonico = 'NUFAEM'
select  top 1 * from cl_parametro where pa_nemonico = 'NUFAEM'

delete cl_parametro where pa_nemonico = 'NOPAFA'
select * from cl_parametro where pa_nemonico = 'NOPAFA'

delete cl_parametro where pa_nemonico = 'NOPACO'
select * from cl_parametro where pa_nemonico = 'NOPACO'


use cobis
go

delete cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion'
delete cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion_complemento'

select * from cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion'
select * from cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion_complemento'

use cobis
go

delete from cobis..cl_parametro where pa_nemonico='SMCLP' and pa_producto='REC'
select * from cobis..cl_parametro where pa_nemonico='SMCLP' and pa_producto='REC'

go