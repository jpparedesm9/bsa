
select * from cob_pac..bpl_rule
where rl_acronym = 'MAXINTEXT'


update cob_pac..bpl_rule set
rl_name = 'Número Máximo Entidades Externa'
where rl_acronym = 'MAXINTEXT'

select * from cob_pac..bpl_rule
where rl_acronym = 'MAXINTEXT'