use cob_pac
go

 

declare
@w_rule_id        int,
@w_rule_version   int
select @w_rule_id = rl_id from cob_pac..bpl_rule where rl_acronym = 'PLREC'
select @w_rule_version = rv_id from cob_pac..bpl_rule_version where rl_id = @w_rule_id and rv_status = 'PRO'

 


select a.cr_last_parent_condition as last_parent_cond_1, b.cr_last_parent_condition as last_parent_cond_2, b.cr_id as  id
into #conditions
from cob_pac..bpl_condition_rule a, cob_pac..bpl_condition_rule b
where a.cr_id = b.cr_parent
and a.rv_id = @w_rule_version 
and a.cr_is_last_son = 1

 

select * from #conditions

 

update cob_pac..bpl_condition_rule set 
cr_last_parent_condition = last_parent_cond_1
from #conditions
where cr_id = id

 

select a.cr_last_parent_condition as last_parent_cond_1, b.cr_last_parent_condition as last_parent_cond_2, b.cr_id as  id
from cob_pac..bpl_condition_rule a, cob_pac..bpl_condition_rule b
where a.cr_id = b.cr_parent
and a.rv_id = @w_rule_version 
and a.cr_is_last_son = 1
go
