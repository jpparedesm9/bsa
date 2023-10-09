declare @_tramite int
select @_tramite = 24902

SELECT * FROM cob_credito..cr_tramite 
where tr_tramite = @_tramite

update cob_credito..cr_tramite 
set tr_estado = 'P'
where tr_tramite = @_tramite

SELECT * FROM cob_credito..cr_tramite 
where tr_tramite = @_tramite
go
