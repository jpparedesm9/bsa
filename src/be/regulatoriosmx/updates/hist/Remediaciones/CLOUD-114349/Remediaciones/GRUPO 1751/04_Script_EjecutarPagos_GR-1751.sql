
USE cob_cartera
GO

select getdate()
exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B'
select getdate()



SELECT * 
  FROM ca_corresponsal_trn
 where co_secuencial IN (select distinct secuencial_corresp from tmp_114349_dcu where estado_proc_pago='S')

 
GO
