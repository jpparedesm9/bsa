use cob_cartera
go

declare 
@s_ssn integer,
@w_return integer,
@w_tramite int,
@w_op_banco  cuenta,
@w_op_banco_2  cuenta,
@w_monto     money,
@w_monto2     money,
@w_fecha     datetime

exec  @s_ssn = ADMIN...rp_ssn  

select  @w_tramite = max(tr_tramite) +1 from cob_credito..cr_tramite -- where tr_tramite < 100
--------------------------
-- FECHA PROCESO
--------------------------
select @w_fecha = fp_fecha from cobis..ba_fecha_proceso 

print '--------------------------------------------'
print '-- CREACION DE OPERACION'
print '--------------------------------------------'

exec @w_return = sp_crear_operacion
@s_user           = 'admuser',
@i_tramite        = @w_tramite, -- 7,
@s_date           = @w_fecha, -- '11/10/2015',
@s_term           = 'admuser',
@i_cliente        = 100001,
@i_nombre         = 'ANDY ESTEBAN GARCIA MORLA',
@i_sector         = 4,
@i_toperacion     = 'AGROMIACAT',
@i_oficina        = 1,
@i_moneda         = 0,
@i_comentario     = 'OP PARA RENOVACION',
@i_oficial        = 4, 
@i_fecha_ini      = @w_fecha, -- '11/10/2015',
@i_monto          = 10000,
@i_monto_aprobado = 10000,
@i_destino        = '01'		, ------ojo esta heredando el de la operaci½n que viene
@i_ciudad         = 1,
@i_formato_fecha  = 101,
@i_salida         = 'N',
@i_fondos_propios = 'N',
@i_origen_fondos  = 'Q',
@i_batch_dd       = 'N',
@i_clase_cartera  = 4,
@o_banco          = @w_op_banco output

select @w_op_banco

select @s_ssn = @s_ssn + 1

-- PASO A  DEFINITIVAS 
exec @w_return = sp_operacion_def
@s_date   = @w_fecha, --  '11/10/2015',
@s_sesn   = @s_ssn, -- 10006,
@s_user   = 'ADMUSER',
@s_ofi    = 1,
@i_banco  = @w_op_banco  

select @w_op_banco  -- 177



-- ** sp_tramite 

print '--------------------------------------------'
print '-- CONSULTA SALDO'
print '--------------------------------------------'

exec cob_cartera..sp_saldocca   
  @i_fecha_proceso = @w_fecha, -- '12/21/16',
  @i_operacionca   = @w_op_banco,
  @i_tipo_cobro	   ='P',
  @i_num_dec	   =2,
  @i_tasa_prepago  = 0,
  @o_monto   	   = @w_monto out
   
select @w_monto  -- 14414
select @w_monto2 = @w_monto -- + 1000
select @w_monto2  -- 15414


print '--------------------------------------------'
print '-- TRAMITE'
print '--------------------------------------------'

select @s_ssn = @s_ssn + 1
    
exec cob_credito..sp_tramite_cca 
   @s_ssn                = @s_ssn, --2000,
   @s_user               = 'admuser',
   @s_sesn               = @s_ssn, -- 1005,
   @s_term               = 'pc-jta',
   @s_date               = @w_fecha, --'11/10/2015',
   @s_srv                = 'pc-jta',
   @s_lsrv               = 'pc-jta',
   @s_ofi                = 1,
   @t_trn                = 21020,
   @i_oficina_tr         = 1,
   @i_usuario_tr         = 'admuser',
   @i_fecha_crea         = @w_fecha, --'11/10/2015',
   @i_oficial            = 4,
   @i_sector             = '4', -- select * from cobis..cl_tabla where tabla like '%sector%'
   @i_ciudad             = 1,   -- select * from cobis..cl_ciudad 
   @i_fecha_apr          = @w_fecha, --'11/10/2015',
   @i_usuario_apr        = 'admuser',
   @i_banco              = @w_op_banco,  -- '140740117704',
   @i_toperacion         = 'CREDVEHI',
   @i_producto           = 'CCA',
   @i_monto              = @w_monto, -- 718,
   @i_tipo               = 'R',
   @i_moneda             = 0,  -- select op_moneda,* from cob_cartera..ca_operacion where op_estado in (1)
   @i_periodo            = 'M',
   @i_num_periodos       = 0,
   @i_destino            = 1001,
   @i_ciudad_destino     = '11001',
   @i_cliente            = 100001, -- 45206,   --SBU: 02/mar/2000
   @i_clase              = 4,--AUMENTADO CLASE DE CARTERA 2/FEB/99
   @i_monto_mn           = @w_monto, -- 718,
   @i_monto_des          = @w_monto, -- 718, 
   @o_tramite            = @w_tramite out
   
select @w_tramite  -- 20


select * from cob_credito..cr_tramite 
where tr_tramite =  @w_tramite


print '--------------------------------------------'
print '-- ACTUALIZA CR_OP_rENOVAR'
print '--------------------------------------------'

select @s_ssn = @s_ssn + 1
         
exec @w_return = cob_credito..sp_op_renovar
@t_trn                = 21130,
@s_ssn                = @s_ssn,
@i_operacion          = "I",
@i_tramite            = @w_tramite, -- 8,
@i_num_operacion      = @w_op_banco, -- '100010000048',
@i_abono              = 0,
@i_moneda_abono       = 0,
@i_saldo_original     = @w_monto, -- 718,
@i_producto           = "CCA"
--@i_formato_fecha    = 103
--@i_capitaliza       = @w_capitaliza
         
select * from cob_credito..cr_op_renovar
where or_tramite = @w_tramite -- 8
       
exec cob_cartera..sp_ren_autoriza
@s_date = @w_fecha, -- '11/10/2015',
@s_term = 'pc-JTA',
@s_ofi = 1,
@i_tramite = @w_tramite, --8,
@i_usuario = 'admuser',
@t_trn = 7979
       

	   
	   
print '--------------------------------------------'
print '-- NUEVA OPERACION'
print '--------------------------------------------'
     
exec @w_return = sp_crear_operacion
@s_user           = 'admuser',
@i_tramite        = @w_tramite, -- 8,
@s_date           = @w_fecha, -- '11/10/2015',
@s_term           = 'admuser',
@i_cliente        = 100001,
@i_nombre         = 'ANDY ESTEBAN GARCIA MORLA',
@i_sector         = 4,
@i_toperacion     = 'AGROMIACAT',
@i_oficina        = 1,
@i_moneda         = 0,
@i_comentario     = 'OP PARA RENOVACION',
@i_oficial        = 4, 
@i_fecha_ini      = @w_fecha, -- '11/10/2015',
@i_monto          = @w_monto2, -- 718,
@i_monto_aprobado = @w_monto2, -- 718,
@i_destino        = '01'		, ------ojo esta heredando el de la operaci½n que viene
@i_ciudad         = 1,
@i_formato_fecha  = 101,
@i_salida         = 'N',
@i_fondos_propios = 'N',
@i_origen_fondos  = 'Q',
@i_batch_dd       = 'N',
@i_clase_cartera  = 4,
@o_banco          = @w_op_banco_2 output
      	
select @w_op_banco_2
      
      
-- PASO A  DEFINITIVAS 
select @s_ssn = @s_ssn + 1

exec @w_return = sp_operacion_def
@s_date   = @w_fecha,
@s_sesn   = @s_ssn, -- 10007,
@s_user   = 'ADMUSER',
@s_ofi    = 1,
@i_banco  = @w_op_banco_2  
       
select @w_op_banco_2


select * from cob_cartera..ca_operacion 
where op_operacion = @w_op_banco_2 -- 178
       
update cob_cartera..ca_operacion 
set op_fecha_ult_proceso = '11/10/2015'
where op_operacion= @w_op_banco_2 -- 178
       
update cob_credito..cr_tramite 
set tr_estado = 'A'
where tr_tramite = @w_tramite --  8

----------------------------------------------

UPDATE cob_cartera..ca_operacion 
SET op_estado = 0
WHERE op_operacion = @w_op_banco_2

UPDATE cob_cartera..ca_operacion 
SET op_anterior = '100010000048'
WHERE op_operacion = @w_op_banco_2