USE cob_cartera
GO

exec cob_cartera..sp_pagos_corresponsal_batch 
@i_param1  = 'B'
go



