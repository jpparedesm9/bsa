use cobis
go

declare @w_ente int

select @w_ente = 29343

update cobis..cl_ente
set p_s_nombre = 'MA.',
en_nomlar = 'ROSA MA. LAUREANO JACINTO'
where en_ente = @w_ente

go

