declare @w_tramite int
select @w_tramite = 12129

update cob_credito..cr_tramite
set   tr_oficina = 1039 -- antes 1037
where tr_tramite = @w_tramite
go
