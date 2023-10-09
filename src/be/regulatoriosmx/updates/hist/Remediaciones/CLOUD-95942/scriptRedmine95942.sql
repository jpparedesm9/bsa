

use cob_cartera
go

declare @w_error int 

exec @w_error     = cob_cartera..sp_actualiza_grupal 
     @i_banco     = '233510001065', --LAS CHICAS DE SAN PABLO
     @i_desde_cca = 'N' -- N = tablas definitivas   