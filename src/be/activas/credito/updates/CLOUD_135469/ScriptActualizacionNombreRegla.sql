
select * from cob_pac..bpl_rule
where rl_acronym = 'MAXINTEXT'


update cob_pac..bpl_rule set
rl_name = 'N�mero M�ximo Externos Original'
where rl_acronym = 'MAXINTEXT'

select * from cob_pac..bpl_rule
where rl_acronym = 'MAXINTEXT'