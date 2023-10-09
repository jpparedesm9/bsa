use cob_cartera
go

set nocount off

declare 
@s_ssn integer,
@w_return integer,
@w_tramite_0 int,
@w_tramite int,
@w_operacion_0  int,
@w_operacion  int,
@w_monto money,
@w_monto2 money,
@w_fecha datetime

exec  @s_ssn = ADMIN...rp_ssn  
select  @w_tramite_0 = max(tr_tramite) +1 from cob_credito..cr_tramite 

update cobis..cl_seqnos
set siguiente = @w_tramite_0
where tabla = 'cr_tramite'

--------------------------
-- FECHA PROCESO
--------------------------
select @w_fecha = fp_fecha from cobis..ba_fecha_proceso 
print '--------------------------------------------'
print '-- TRAMITE ANTERIOR'
print '--------------------------------------------'
select @s_ssn = @s_ssn + 1000
    
exec cob_credito..sp_tramite_cca 
   @s_ssn                =  @s_ssn,
   @s_user               = 'admuser',
   @s_sesn               = @s_ssn, 
   @s_term               = 'pc-jta',
   @s_date               = @w_fecha, 
   @s_srv                = 'pc-jta',
   @s_lsrv               = 'pc-jta',
   @s_ofi                = 1,
   @t_trn                = 21020,
   @i_oficina_tr         = 1,
   @i_usuario_tr         = 'admuser',
   @i_fecha_crea         = @w_fecha,
   @i_oficial            = 4,
   @i_sector             = '1', -- select * from cobis..cl_tabla where tabla like '%sector%'
   @i_ciudad             = 1,   -- select * from cobis..cl_ciudad 
   @i_fecha_apr          = @w_fecha,
   @i_usuario_apr        = 'admuser',
   @i_banco              = 203, 
   @i_toperacion         = 'CREDSEMI',
   @i_producto           = 'CCA',
   @i_monto              = 10000, 
   @i_tipo               = 'O',
   @i_moneda             = 0, 
   @i_periodo            = 'M',
   @i_num_periodos       = 0,
   @i_destino            = 1001,
   @i_ciudad_destino     = '11001',
   @i_cliente            = 100001, 
   @i_clase              = 4,	--AUMENTADO CLASE DE CARTERA 2/FEB/99
   @i_monto_mn           = 10000, 
   @i_monto_des          = 10000,
   @o_tramite            = @w_tramite_0 out
   
select @w_tramite_0  
SELECT * FROM cobis..ba_fecha_proceso

print '--------------------------------------------'
print '-- CREACION DE OPERACION'
print '--------------------------------------------'
exec @w_return = sp_crear_operacion
@s_user           = 'admuser',
@s_ofi            = 1,
@i_tramite        = @w_tramite_0, 
@s_date           = @w_fecha, 
@s_term           = 'admuser',
@i_cliente        = 100001,
@i_nombre         = 'ANDY ESTEBAN GARCIA MORLA',
@i_sector         = 1,
@i_toperacion     = 'CREDSEMI',
@i_oficina        = 1,
@i_moneda         = 0,
@i_comentario     = 'OP PARA RENOVACION',
@i_oficial        = 4, 
@i_fecha_ini      = @w_fecha, 
@i_monto          = 10000,
@i_monto_aprobado = 10000,
@i_destino        = '01', 
@i_ciudad         = 1,
@i_formato_fecha  = 101,
@i_salida         = 'N',
@i_fondos_propios = 'N',
@i_origen_fondos  = 'Q',
@i_batch_dd       = 'N',
@i_clase_cartera  = 4,
@o_banco          = @w_operacion_0 output

select @w_operacion_0

select @s_ssn = @s_ssn + 1

-- PASO A  DEFINITIVAS 
exec @w_return = sp_operacion_def
@s_date   = @w_fecha, --  '11/10/2015',
@s_sesn   = @s_ssn, -- 10006,
@s_user   = 'ADMUSER',
@s_ofi    = 1,
@i_banco  = @w_operacion_0  

select @w_operacion_0  -- 177
update cob_cartera..ca_operacion
set op_estado = 1 -- vigente
where op_operacion = @w_operacion_0

GO


---------------------------------------------------------------------------------------------------------
-- SE ASUME QUE TRAMITE ANTERIOR FUE LA OPERACION ANTERIOR

use cob_cartera
go

declare 
@s_ssn          integer,
@w_return       integer,
@w_tramite_0    int,
@w_tramite      int,
@w_operacion_0  int,
@w_op_banco_0   cuenta,
@w_op_banco     cuenta,
@w_monto        money,
@w_monto2       money,
@w_fecha        datetime

exec  @s_ssn = ADMIN...rp_ssn  

select  @w_tramite_0 = max(tr_tramite) from cob_credito..cr_tramite 

update cobis..cl_seqnos
set siguiente = @w_tramite_0  
where tabla = 'cr_tramite'

select @w_op_banco_0  = op_banco from cob_cartera..ca_operacion where op_tramite = @w_tramite_0
select @w_operacion_0 = op_operacion from cob_cartera..ca_operacion where op_tramite = @w_tramite_0

--------------------------
-- FECHA PROCESO
--------------------------
select @w_fecha = fp_fecha from cobis..ba_fecha_proceso 

update cob_credito..cr_op_renovar
set or_num_operacion = @w_operacion_0,
or_toperacion = 'CREDSEMI'
where  or_tramite = @w_tramite_0  

select @s_ssn = @s_ssn + 1000

exec cob_cartera..sp_saldocca   
  @i_fecha_proceso = @w_fecha, 
  @i_operacionca   = @w_operacion_0,
  @i_tipo_cobro	   ='P',
  @i_num_dec	   =2,
  @i_tasa_prepago  = 0,
  @o_monto   	   = @w_monto out

select @w_monto = 10000
select @w_monto2 = @w_monto + 2000

print '--------------------------------------------'
print '-- TRAMITE RENOVACION'
print '--------------------------------------------'

select @s_ssn = @s_ssn + 1
    
exec cob_credito..sp_tramite_cca 
   @s_ssn                = @s_ssn, 
   @s_user               = 'admuser',
   @s_sesn               = @s_ssn, 
   @s_term               = 'pc-jta',
   @s_date               = @w_fecha, 
   @s_srv                = 'pc-jta',
   @s_lsrv               = 'pc-jta',
   @s_ofi                = 1,
   @t_trn                = 21020,
   @i_oficina_tr         = 1,
   @i_usuario_tr         = 'admuser',
   @i_fecha_crea         = @w_fecha, 
   @i_oficial            = 4,
   @i_sector             = '1', -- select * from cobis..cl_tabla where tabla like '%sector%'
   @i_ciudad             = 1,   -- select * from cobis..cl_ciudad 
   @i_fecha_apr          = @w_fecha, 
   @i_usuario_apr        = 'admuser',
   @i_banco              = @w_op_banco_0, 
   @i_toperacion         = 'CREDSEMI',
   @i_producto           = 'CCA',
   @i_monto              = @w_monto, 
   @i_tipo               = 'R',
   @i_moneda             = 0,  -- select op_moneda,* from cob_cartera..ca_operacion where op_estado in (1)
   @i_periodo            = 'M',
   @i_num_periodos       = 0,
   @i_destino            = 1001,
   @i_ciudad_destino     = '11001',
   @i_cliente            = 100001, 
   @i_clase              = 4,  --AUMENTADO CLASE DE CARTERA 2/FEB/99
   @i_monto_mn           = @w_monto, 
   @i_monto_des          = @w_monto,
   @o_tramite            = @w_tramite out
   
-- select @w_tramite 
-- select * from cob_credito..cr_tramite 
-- where tr_tramite =  @w_tramite

print '--------------------------------------------'
print '-- ACTUALIZA CR_OP_rENOVAR'
print '--------------------------------------------'

select @s_ssn = @s_ssn + 1         
exec @w_return = cob_credito..sp_op_renovar
@t_trn                = 21130,
@s_date               = @w_fecha,
@s_user               = 'admuser', 
@s_term               = 'pc-jta',
@s_ofi                = 1,
@s_lsrv               = 'pc-jta',
@s_srv                = 'pc-jta',
@s_ssn                = @s_ssn,
@i_operacion          = "I",
@i_tramite            = @w_tramite, 
@i_num_operacion      = @w_op_banco_0, 
@i_abono              = 0,
@i_moneda_abono       = 0,
@i_saldo_original     = @w_monto, 
@i_producto           = "CCA"
--@i_formato_fecha    = 103
--@i_capitaliza       = @w_capitaliza
         
-- select * from cob_credito..cr_op_renovar
-- where or_tramite = @w_tramite -- 8
       
exec cob_cartera..sp_ren_autoriza
@s_date = @w_fecha, 
@s_term = 'pc-JTA',
@s_ofi = 1,
@i_tramite = @w_tramite, 
@i_usuario = 'admuser',
@t_trn = 7979
       
print '--------------------------------------------'
print '-- NUEVA OPERACION'
print '--------------------------------------------'

exec @w_return = sp_crear_operacion
@s_user           = 'admuser',
@s_ofi            = 1,
@i_tramite        = @w_tramite, 
@s_date           = @w_fecha, 
@s_term           = 'admuser',
@i_cliente        = 100001,
@i_nombre         = 'ANDY ESTEBAN GARCIA MORLA',
@i_sector         = 1,
@i_toperacion     = 'CREDSEMI',
@i_oficina        = 1,
@i_moneda         = 0,
@i_comentario     = 'OP PARA RENOVACION',
@i_oficial        = 4, 
@i_fecha_ini      = @w_fecha, 
@i_monto          = @w_monto2, 
@i_monto_aprobado = @w_monto2, 
@i_destino        = '01', 
@i_ciudad         = 1,
@i_formato_fecha  = 101,
@i_salida         = 'N',
@i_fondos_propios = 'N',
@i_origen_fondos  = 'Q',
@i_batch_dd       = 'N',
@i_clase_cartera  = 4,
@o_banco          = @w_op_banco output
      	
-- select @w_op_banco
      
-- PASO A  DEFINITIVAS 
select @s_ssn = @s_ssn + 1

exec @w_return = sp_operacion_def
@s_date   = @w_fecha,
@s_sesn   = @s_ssn,
@s_user   = 'ADMUSER',
@s_ofi    = 1,
@i_banco  = @w_op_banco  
       
update cob_cartera..ca_operacion 
set op_fecha_ult_proceso = @w_fecha 
where op_operacion= @w_op_banco 
       
update cob_credito..cr_tramite 
set tr_estado = 'A'
where tr_tramite = @w_tramite 

----------------------------------------------

UPDATE cob_cartera..ca_operacion 
SET op_estado = 0
WHERE op_operacion = @w_op_banco

UPDATE cob_cartera..ca_operacion 
SET op_anterior = @w_op_banco_0 
WHERE op_operacion = @w_op_banco

select '-------------------------'
select 'Tramite Anterior   : ' + cast ( @w_tramite_0 as varchar)
select 'Operación Anterior : ' + cast ( @w_operacion_0 as varchar)
select 'Tramite Renovacion : ' + cast ( @w_tramite as varchar)
select 'Operación Renovada : ' + cast ( @w_op_banco as varchar)

update cob_cartera..ca_dividendo
set di_estado = 2 -- VENCE todas los dividendos
where  di_operacion = @w_operacion_0


go
