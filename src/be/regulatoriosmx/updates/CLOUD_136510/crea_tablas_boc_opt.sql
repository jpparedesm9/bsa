use cob_conta
go

drop table cb_boc_opt
drop table cb_boc_det_opt

select *
into cob_conta..cb_boc_opt
from cob_conta..cb_boc
where 1=2
go

select *
into cob_conta..cb_boc_det_opt
from cob_conta..cb_boc_det
where 1=2
go

create index idx1 on cb_boc_opt	(bo_cliente, bo_cuenta, bo_oficina, bo_fecha)
go
create index idx2 on cb_boc_opt (bo_producto)
go
create index idx3 on cb_boc_opt (bo_cuenta)
go
