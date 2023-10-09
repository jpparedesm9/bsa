USE cob_cartera
go
exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B',
     @i_ejecutar_fvalor = 'N'

GO
