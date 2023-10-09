
use cob_credito
go

declare @w_gar float

select 'ant' = 'ant', tr_porc_garantia, * 
from   cob_credito..cr_tramite, act_tramite_tmp_caso_129530 
where  tr_tramite = tramite

update cob_credito..cr_tramite
set    tr_porc_garantia = porcentaje
from   act_tramite_tmp_caso_129530
where  tr_tramite = tramite

select 'desp' = 'desp', tr_porc_garantia, * 
from   cob_credito..cr_tramite, act_tramite_tmp_caso_129530
where  tr_tramite = tramite

go
