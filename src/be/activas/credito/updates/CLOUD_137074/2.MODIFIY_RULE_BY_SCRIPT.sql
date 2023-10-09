use cob_pac
go
declare @w_id_rule int, @w_rv_id int
SELECT @w_id_rule= rl_id from cob_pac..bpl_rule where rl_acronym ='ENTFEDE2'
select @w_rv_id=max(rv_id) 
                          from cob_pac..bpl_rule_version 
                          where rl_id = @w_id_rule 
                          and rv_status = 'PRO'


UPDATE cob_pac..bpl_condition_rule
SET cr_max_value='308'
WHERE rv_id=@w_rv_id AND cr_max_value='160'

UPDATE cob_pac..bpl_condition_rule
SET cr_max_value='555'
WHERE rv_id=@w_rv_id AND cr_max_value='440'

UPDATE cob_pac..bpl_condition_rule
SET cr_max_value='1110'
WHERE rv_id=@w_rv_id AND cr_max_value='800'
go