USE cob_cartera
GO

select  co_estado, * from ca_corresponsal_trn
where co_secuencial = 2896
go


update ca_corresponsal_trn
set co_estado = 'I'
where co_secuencial = 2896
go


select  co_estado, * from ca_corresponsal_trn
where co_secuencial = 2896
go

