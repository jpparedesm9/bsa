--Remediacion caso 115005

use cob_cartera
go

--Grupo 3901
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3901
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go

--Grupo 3840
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3840
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

go
--Grupo 18
DECLARE @w_error int
EXEC @w_error = cob_cartera..sp_genera_xml_gar_liquida
   @i_tramite           = 56176,
   @i_opcion            = 'I',
   @i_vista_previa      = 'S',
   @o_gar_pendiente     = 'S'
SELECT @w_error
GO

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 18
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

--Grupo 336
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 336
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'


--Grupo 418
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 418
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

--Grupo 1217
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 1217
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

--Grupo 1232
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 1232
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

--Grupo 1396
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 1396
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

--Grupo 2227
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 2227
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

--Grupo 2259
update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 2259
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

go

--Grupo 2380
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 2380
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go

--Grupo 2421
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 2421
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go
--Grupo 3840
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3840
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go
--Grupo 3870
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3870
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go
--Grupo 3879
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3879
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

go
--Grupo 3895
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3895
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go
--Grupo 3900
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3900
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

go
--Grupo 3901
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3901
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go
--Grupo 3903
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3903
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go
--Grupo 3906
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3906
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go
--Grupo 3907
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3907
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go
--Grupo 3911
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3911
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go
--Grupo 3912
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3912
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'
go

--Grupo 3914
DECLARE @w_error int

update ca_corresponsal_trn
SET co_estado = 'I',
    co_error_id  = 0,  
    co_error_msg = ''
WHERE co_codigo_interno = 3914
AND co_estado = 'P'
AND co_accion = 'I'
AND co_tipo   = 'GL'
and co_fecha_proceso = '03/27/2019'

go

exec cob_cartera..sp_pagos_corresponsal_batch 
     @i_param1  = 'B'



go


