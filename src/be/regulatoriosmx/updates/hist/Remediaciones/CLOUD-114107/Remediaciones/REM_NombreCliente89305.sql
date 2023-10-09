--NOMBRE INCORRECTO MA DEL CARMEN
--NOMBRE CORRECTO MA. DEL CARMEN

use cobis
go

declare @w_ente int

select @w_ente = 89305

update cobis..cl_ente
set p_s_nombre = 'MA. DEL CARMEN',
en_nomlar = 'FELIX MA. DEL CARMEN URBINA MONROY'
where en_ente = @w_ente

go
