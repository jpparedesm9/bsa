-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
use cob_cartera
go

IF OBJECT_ID ('dbo.valor_cat_caso_126494') IS NOT NULL
	DROP table dbo.valor_cat_caso_126494
go

create table valor_cat_caso_126494(
    vcc_operacion int,
    vcc_banco     varchar(24),
    vcc_tramite   int,
    vcc_cliente   int,
    vcc_valor_cat float,
	vcc_tdividendo  varchar(10),
	vcc_periodo_int smallint
)

insert into valor_cat_caso_126494
select op_operacion, op_banco, op_tramite, op_cliente, op_valor_cat, op_tdividendo, op_periodo_int
from cob_cartera..ca_operacion
where op_toperacion = 'REVOLVENTE'

update cob_cartera..ca_operacion
set    op_valor_cat = 245.94
where  op_toperacion = 'REVOLVENTE'
and    op_tdividendo  = 'W'
and	   op_periodo_int = 1

update cob_cartera..ca_operacion
set    op_valor_cat  = 161.58
where  op_toperacion = 'REVOLVENTE'
and    op_tdividendo  = 'W'
and	   op_periodo_int = 2

go
