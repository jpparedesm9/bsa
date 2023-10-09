use cob_cartera
go

set nocount off

declare 
@s_ssn integer,
@w_return integer,
@w_tramite_0 int,
@w_tramite_1 int,
@w_tramite_2 int,
@w_operacion_0  int,
@w_operacion_1  int,
@w_operacion_2  int,
@w_op_banco_0   cuenta,
@w_op_banco_1   cuenta,
@w_op_banco_2   cuenta,
@w_monto_0 money,
@w_monto_1 money,
@w_monto_2 money,
@w_fecha datetime

exec  @s_ssn = ADMIN...rp_ssn  
select  @w_tramite_0 = max(tr_tramite) +1 from cob_credito..cr_tramite 
update cobis..cl_seqnos set siguiente = @w_tramite_0 where tabla = 'cr_tramite'

select @w_monto_0 = 4000
select @w_monto_1 = 6000
select @w_monto_2 = 11000

--------------------------
-- FECHA PROCESO
--------------------------
select @w_fecha = fp_fecha from cobis..ba_fecha_proceso 
print '--------------------------------------------'
print '-- TRAMITE ANTERIOR'
print '--------------------------------------------'
select @s_ssn = @s_ssn + 1000

select @w_fecha = dateadd(mm, -5, @w_fecha)

    
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
   @i_monto              = @w_monto_0, 
   @i_tipo               = 'O',
   @i_moneda             = 0, 
   @i_periodo            = 'M',
   @i_num_periodos       = 0,
   @i_destino            = 1001,
   @i_ciudad_destino     = '11001',
   @i_cliente            = 100001, 
   @i_clase              = 4,	--AUMENTADO CLASE DE CARTERA 2/FEB/99
   @i_monto_mn           = @w_monto_0, 
   @i_monto_des          = @w_monto_0,
   @o_tramite            = @w_tramite_0 out
   
/*select @w_tramite_0  
SELECT * FROM cobis..ba_fecha_proceso*/

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
@i_monto          = @w_monto_0,
@i_monto_aprobado = @w_monto_0,
@i_destino        = '01', 
@i_ciudad         = 1,
@i_formato_fecha  = 101,
@i_salida         = 'N',
@i_fondos_propios = 'N',
@i_origen_fondos  = 'Q',
@i_batch_dd       = 'N',
@i_clase_cartera  = 4,
@o_banco          = @w_operacion_0 output

-- select @w_operacion_0
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


---------------------------------------------------------------------------------------------------------



exec  @s_ssn = ADMIN...rp_ssn  
select  @w_tramite_1 = max(tr_tramite) +1 from cob_credito..cr_tramite 
update cobis..cl_seqnos set siguiente = @w_tramite_1 where tabla = 'cr_tramite'

select @w_fecha = fp_fecha from cobis..ba_fecha_proceso 

select @w_fecha = dateadd(mm, -11, @w_fecha)


print '--------------------------------------------'
print '-- TRAMITE ANTERIOR 2'
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
   @i_monto              = @w_monto_1, 
   @i_tipo               = 'O',
   @i_moneda             = 0, 
   @i_periodo            = 'M',
   @i_num_periodos       = 0,
   @i_destino            = 1001,
   @i_ciudad_destino     = '11001',
   @i_cliente            = 100001, 
   @i_clase              = 4,	--AUMENTADO CLASE DE CARTERA 2/FEB/99
   @i_monto_mn           = @w_monto_1, 
   @i_monto_des          = @w_monto_1,
   @o_tramite            = @w_tramite_1 out
   

print '--------------------------------------------'
print '-- CREACION DE OPERACION 2'
print '--------------------------------------------'
exec @w_return = sp_crear_operacion
@s_user           = 'admuser',
@s_ofi            = 1,
@i_tramite        = @w_tramite_1, 
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
@i_monto          = @w_monto_1,
@i_monto_aprobado = @w_monto_1,
@i_destino        = '01', 
@i_ciudad         = 1,
@i_formato_fecha  = 101,
@i_salida         = 'N',
@i_fondos_propios = 'N',
@i_origen_fondos  = 'Q',
@i_batch_dd       = 'N',
@i_clase_cartera  = 4,
@o_banco          = @w_operacion_1 output

-- select @w_operacion_1

select @s_ssn = @s_ssn + 1

-- PASO A  DEFINITIVAS 
exec @w_return = sp_operacion_def
@s_date   = @w_fecha, --  '11/10/2015',
@s_sesn   = @s_ssn, -- 10006,
@s_user   = 'ADMUSER',
@s_ofi    = 1,
@i_banco  = @w_operacion_1  

select @w_operacion_1  -- 177
update cob_cartera..ca_operacion
set op_estado = 1 -- vigente
where op_operacion = @w_operacion_1




---------------------------------------------------------------------------------------------------------
-- SE ASUME QUE TRAMITE ANTERIOR FUE LA OPERACION ANTERIOR


exec  @s_ssn = ADMIN...rp_ssn  
select @w_tramite_2 = max(tr_tramite) from cob_credito..cr_tramite 
update cobis..cl_seqnos set siguiente = @w_tramite_2 where tabla = 'cr_tramite'

select @w_op_banco_0  = op_banco,
       @w_operacion_0 = op_operacion
  from cob_cartera..ca_operacion 
 where op_tramite = @w_tramite_0

select @w_op_banco_1  = op_banco,
       @w_operacion_1 = op_operacion
  from cob_cartera..ca_operacion 
 where op_tramite = @w_tramite_1


print '--------------------------------------------'
print '-- TRAMITE RENOVACION'
print '--------------------------------------------'

select @w_fecha = fp_fecha from cobis..ba_fecha_proceso 

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
   @i_monto              = @w_monto_2, 
   @i_tipo               = 'R',
   @i_moneda             = 0,  -- select op_moneda,* from cob_cartera..ca_operacion where op_estado in (1)
   @i_periodo            = 'M',
   @i_num_periodos       = 0,
   @i_destino            = 1001,
   @i_ciudad_destino     = '11001',
   @i_cliente            = 100001, 
   @i_clase              = 4,  --AUMENTADO CLASE DE CARTERA 2/FEB/99
   @i_monto_mn           = @w_monto_2, 
   @i_monto_des          = @w_monto_2,
   @o_tramite            = @w_tramite_2 out
   
-- select @w_tramite_2 
-- select * from cob_credito..cr_tramite 
-- where tr_tramite =  @w_tramite_2

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
@i_tramite            = @w_tramite_2, 
@i_num_operacion      = @w_op_banco_0, 
@i_abono              = 0,
@i_moneda_abono       = 0,
@i_saldo_original     = @w_monto_2, 
@i_producto           = "CCA"
--@i_formato_fecha    = 103
--@i_capitaliza       = @w_capitaliza
         
-- select * from cob_credito..cr_op_renovar
-- where or_tramite = @w_tramite_2 -- 8
       
exec cob_cartera..sp_ren_autoriza
@s_date = @w_fecha, 
@s_term = 'pc-JTA',
@s_ofi = 1,
@i_tramite = @w_tramite_2, 
@i_usuario = 'admuser',
@t_trn = 7979
       
print '--------------------------------------------'
print '-- NUEVA OPERACION'
print '--------------------------------------------'

exec @w_return = sp_crear_operacion
@s_user           = 'admuser',
@s_ofi            = 1,
@i_tramite        = @w_tramite_2, 
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
@i_monto          = @w_monto_2, 
@i_monto_aprobado = @w_monto_2, 
@i_destino        = '01', 
@i_ciudad         = 1,
@i_formato_fecha  = 101,
@i_salida         = 'N',
@i_fondos_propios = 'N',
@i_origen_fondos  = 'Q',
@i_batch_dd       = 'N',
@i_clase_cartera  = 4,
@o_banco          = @w_op_banco_2 output
      	
-- select @w_op_banco_2
      
-- PASO A  DEFINITIVAS 
select @s_ssn = @s_ssn + 1

exec @w_return = sp_operacion_def
@s_date   = @w_fecha,
@s_sesn   = @s_ssn,
@s_user   = 'ADMUSER',
@s_ofi    = 1,
@i_banco  = @w_op_banco_2  
       
update cob_cartera..ca_operacion 
set op_fecha_ult_proceso = @w_fecha 
where op_operacion= @w_op_banco_2 
       
update cob_credito..cr_tramite 
set tr_estado = 'A'
where tr_tramite = @w_tramite_2

----------------------------------------------

UPDATE cob_cartera..ca_operacion 
SET op_estado = 0
WHERE op_operacion = @w_op_banco_2

UPDATE cob_cartera..ca_operacion 
SET op_anterior = @w_op_banco_0 
WHERE op_operacion = @w_op_banco_2

select '-------------------------'
select 'Tramite Anterior 1   : ' + cast ( @w_tramite_0 as varchar)
select 'Operación Anterior 1 : ' + cast ( @w_operacion_0 as varchar)
select 'Tramite Anterior 2   : ' + cast ( @w_tramite_1 as varchar)
select 'Operación Anterior 2 : ' + cast ( @w_operacion_1 as varchar)
select 'Tramite Renovacion   : ' + cast ( @w_tramite_2 as varchar)
select 'Operación Renovada   : ' + cast ( @w_op_banco_2 as varchar)

update cob_cartera..ca_dividendo
set di_estado = 2 -- VENCE todas los dividendos
where  di_operacion = @w_operacion_0

update cob_cartera..ca_dividendo
set di_estado = 2 -- VENCE todas los dividendos
where  di_operacion = @w_operacion_1

----------------------------------------------------------------------------------------------------------

update cob_cartera..ca_operacion 
set op_fecha_ult_proceso = (select fp_fecha from cobis..ba_fecha_proceso)
where op_operacion in (@w_operacion_0, @w_operacion_1, @w_op_banco_2)


insert into cob_credito..cr_op_renovar
(
or_tramite, or_num_operacion, or_producto, or_abono, or_moneda_abono, 
or_monto_original, or_moneda_original, or_saldo_original, or_fecha_concesion, or_toperacion, 
or_operacion_original, or_cancelado, or_monto_inicial, or_moneda_inicial, or_aplicar, 
or_capitaliza, or_login, or_fecha_ingreso, or_finalizo_renovacion, or_sec_prn
)
select 
or_tramite, @w_op_banco_1 , or_producto, or_abono, or_moneda_abono, 
or_monto_original, or_moneda_original, or_saldo_original, or_fecha_concesion, or_toperacion, 
or_operacion_original, or_cancelado, or_monto_inicial, or_moneda_inicial, or_aplicar, 
or_capitaliza, or_login, or_fecha_ingreso, or_finalizo_renovacion, or_sec_prn
from cob_credito..cr_op_renovar where or_tramite = @w_tramite_2 and or_num_operacion = @w_op_banco_0

----------------------------------------------------------------------------------------------------------

update cob_cartera..ca_operacion
set op_reajuste_especial = 'N'
where op_operacion in (@w_operacion_0,@w_operacion_1)

update cob_cartera..ca_operacion
set op_fecha_ult_proceso = (select fp_fecha from cobis..ba_fecha_proceso)
where op_operacion in (@w_operacion_0,@w_operacion_1)

go

