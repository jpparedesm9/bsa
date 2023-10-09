select bc_tipo_contrato, * 
from   cob_credito..cr_buro_cuenta
where  bc_id_cliente in (103095,103104,103107,103112,103124,103516)

update cob_credito..cr_buro_cuenta
set    bc_tipo_contrato = 'CS'
where  bc_id_cliente in (103095,103104,103107,103112,103124,103516)
and    bc_tipo_contrato = 'CT'

select bc_tipo_contrato, * 
from   cob_credito..cr_buro_cuenta
where  bc_id_cliente in (103095,103104,103107,103112,103124,103516)
go
