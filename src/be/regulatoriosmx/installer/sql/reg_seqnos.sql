
use cobis
go

delete cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion'

insert into dbo.cl_seqnos (bdatos, tabla, siguiente) values ('cob_conta_super', 'sb_facturacion', 1)

delete cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion_complemento'

insert into dbo.cl_seqnos (bdatos, tabla, siguiente) values ('cob_conta_super', 'sb_facturacion_complemento', 1)


select * from cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion'
select * from cobis..cl_seqnos where bdatos = 'cob_conta_super' and tabla = 'sb_facturacion_complemento'