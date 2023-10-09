-----------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------
use cob_cartera
go

update cob_cartera..ca_operacion
set    op_valor_cat = vcc_valor_cat
from   valor_cat_caso_126494
where  op_operacion = vcc_operacion
and    op_banco     = vcc_banco
and    op_tramite   = vcc_tramite
and    op_cliente   = vcc_cliente

IF OBJECT_ID ('dbo.valor_cat_caso_126494') IS NOT NULL
	DROP table dbo.valor_cat_caso_126494
go
