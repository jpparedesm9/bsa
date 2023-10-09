use cob_pac
GO

declare @w_rv_id     int

select @w_rv_id = rv_id 
from bpl_rule_version rv,
bpl_rule r
where rv.rl_id = r.rl_id
and rv.rv_status = 'PRO'
and r.rl_acronym = 'FREPAG'

update cob_pac.dbo.bpl_condition_rule
set cr_last_parent_condition = cr_parent
where rv_id = @w_rv_id  
and cr_is_last_son = 1

go