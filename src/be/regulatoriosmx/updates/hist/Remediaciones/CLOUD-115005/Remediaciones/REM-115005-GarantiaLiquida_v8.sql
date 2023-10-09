--Remediacion caso 115005

use cob_cartera
go
select 'antes'
SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 323, 497, 2493, 3342, 3876,2424,3873,3888,3897, 1256, 2305 )
   and co_tipo = 'GL'

SELECT * FROM ca_garantia_liquida
WHERE gl_grupo  IN ( 323, 497, 2493, 3342, 3876,2424,3873,3888,3897,1256, 2305 )
ORDER BY gl_tramite


--Grupo 323
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 54930,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 323
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/26/2019'

--Grupo 497
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 58701,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 497
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/26/2019'

--Grupo 3342
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 48514,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3342
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/26/2019'

--Grupo 3876
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 58555,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3876
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/26/2019'

--Grupo 2493
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 58542,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 2493
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/26/2019'

--Grupo 3897
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 58795,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3897
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

--Grupo 3888
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 58753,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3888
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

--Grupo 3873
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 58692,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3873
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

--Grupo 2424
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 56191,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 2424
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'




--Grupo 1256
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 56181,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 1256
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'



--Grupo 2305
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 54374,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 2305
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/26/2019'


exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B'

select 'despues'

SELECT * 
  FROM ca_corresponsal_trn
 where co_codigo_interno IN ( 323, 497, 2493, 3342, 3876,2424,3873,3888,3897 )
   and co_tipo = 'GL'
 
SELECT * FROM ca_garantia_liquida
WHERE gl_grupo  IN ( 323, 497, 2493, 3342, 3876,2424,3873,3888,3897 )
ORDER BY gl_tramite

go


