USE cob_cartera
GO

select getdate()
exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B'
select getdate()

GO



