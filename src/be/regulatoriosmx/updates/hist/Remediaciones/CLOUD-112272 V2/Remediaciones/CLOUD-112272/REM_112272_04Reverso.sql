USE cob_cartera
GO

select getdate()
exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B'
select getdate()


SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 34840,42241, 45996, 50156, 60044, 61786, 83347, 124391, 126989, 134084, 143713,150281,152263,  182909 )

 
GO



