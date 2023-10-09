--INCORRECTO
--MARIA DOMINGUEZ GALLOSO
--
--CORRECTO:
--MARIA DOMINGUEZ GAYOSSO

use cobis
go

declare @w_ente int

select @w_ente = 57328

update cobis..cl_ente
set p_s_apellido = 'GAYOSSO',
en_nomlar = 'MARIA  DOMINGUEZ GAYOSSO'
where en_ente = @w_ente

go

