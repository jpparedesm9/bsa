use cob_cartera
go


select * from cob_cartera..ca_seguro_externo
where se_tipo_seguro IS null
and   se_monto > 0
and   se_monto is not null

update cob_cartera..ca_seguro_externo set
se_tipo_seguro  = 'BASICO'
where se_tipo_seguro IS null
and   se_monto > 0
and   se_monto is not null


select * from cob_cartera..ca_seguro_externo
where se_tipo_seguro IS null
and   se_monto > 0
and   se_monto is not null

go

