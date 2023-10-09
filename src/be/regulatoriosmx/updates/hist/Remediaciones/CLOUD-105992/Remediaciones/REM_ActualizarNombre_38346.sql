use cobis
go

declare @w_ente int

select @w_ente = 38346

update cobis..cl_ente
set en_nombre = 'MA',
en_nomlar = 'MA CECILIA JUAREZ ORTIZ'
where en_ente = @w_ente

update cob_cartera..ca_operacion
set op_nombre = 'JUAREZ ORTIZ MA'
where op_cliente = @w_ente

update cob_cartera..ca_operacion_his
set oph_nombre = 'JUAREZ ORTIZ MA'
where oph_cliente = @w_ente

update cob_cartera_his..ca_operacion_his
set oph_nombre = 'JUAREZ ORTIZ MA'
where oph_cliente = @w_ente

update cob_cartera_his..ca_operacion
set op_nombre = 'JUAREZ ORTIZ MA'
where op_cliente = @w_ente

go
