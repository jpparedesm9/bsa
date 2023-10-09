USE cobis
GO

declare @w_ente INT, @w_nombre_op varchar(64)

select @w_ente = 101313

update cobis..cl_ente
set    en_nombre = 'J.',
       en_nomlar = 'J. FELICIANO MENDEZ GUZMAN'
where  en_ente = @w_ente

go
