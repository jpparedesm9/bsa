use cob_cartera 
go 


declare 
@w_fecha_valor   datetime ,
@w_fecha_proceso datetime ,
@w_banco         cuenta   ,
@w_error         int      ,
@w_commit        char(1)  ,
@w_monto         money    ,
@w_forma_pago   descripcion ,
@w_oficina      int, 
@w_secuencial_ing  int ,
@w_msg          varchar(255) ,
@w_cuenta       cuenta,
@s_user         login ,
@s_term         descripcion,
@w_operacionca  int ,
@s_srv          descripcion,
@s_ssn          int ,
@w_secuencial_pag int 

    
--DATOS DE LA OPERACION 
select 
@w_operacionca  = op_operacion,
@w_banco        =  op_banco ,
@w_oficina      =  op_oficina ,
@w_cuenta       =  op_cuenta
from ca_operacion where op_banco = '214790021212'


select 
@s_user         = 'usrbatch',
@w_forma_pago   = 'ND_BCO_MN',
@s_term         = 'batch'

--FECHA PROCESO 
select @w_fecha_proceso = fp_fecha 
from cobis..ba_fecha_proceso


--INICIO ATOMICIDAD 
select @w_commit = 'N'

if @@trancount = 0 begin 
   select @w_commit = 'S'
   begin tran 
end

select 'ANTES', * from ca_abono where ab_operacion = @w_operacionca
select 'ANTES', op_fecha_ult_proceso,op_estado,* from ca_operacion where op_banco = @w_banco  
select 'ANTES',* from ca_desembolso where dm_operacion = @w_operacionca
select 'ANTES',
tr_fecha_ref, tr_secuencial,tr_tran,dtr_monto, dtr_concepto
from cob_cartera..ca_transaccion , cob_cartera..ca_det_trn
where  tr_operacion = dtr_operacion 
and tr_secuencial =dtr_secuencial 
and tr_estado <> 'RV'
and tr_secuencial > 0
and dtr_concepto = 'CAP'
and tr_operacion = @w_operacionca
order by tr_secuencial,tr_fecha_ref 

--MARCAR COMO ELIMINADO ULTIMO REGISTRO DE PAGO EN NA 

select @w_secuencial_pag = ab_secuencial_ing 
from ca_abono 
where ab_operacion    = @w_operacionca
and   ab_secuencial_ing = 30                --SECUENCIAL DE PAGO CON NA

exec @w_error      = sp_eliminar_pagos
@s_ssn             = @s_ssn,
@s_srv             = @s_srv,
@s_date            = @w_fecha_proceso,
@s_user            = @s_user,
@s_term            = @s_term,
@s_ofi             = @w_oficina ,
@i_banco           = @w_banco,
@i_operacion       = 'D',
@i_secuencial_ing  = @w_secuencial_pag,
@i_en_linea        = 'N',
@i_pago_ext        = 'N'

if @w_error  <> 0 begin 
  select @w_msg = 'ERROR: AL ELIMINAR PAGO' 
  goto   ERROR
end

--UTILIZACION AL  '02/25/2019'
select 
@w_fecha_valor =  '02/25/2019',--FECHA DE LA  SEGUNDA UTILIZACION
@w_monto       = 1500

exec @w_error  = sp_lcr_desembolsar_batch  
@i_param1      = @w_banco ,
@i_param2      = @w_monto ,
@i_fecha_valor = @w_fecha_valor

if @w_error  <> 0 begin 
  select @w_msg = 'ERROR: AL DESEMBOLSAR AL'+convert(varchar,@w_fecha_valor)  
  goto   ERROR
end


--FECHA VALOR AL '02/26/2019'
select @w_fecha_valor =  '02/26/2019'--FECHA DE LA  SEGUNDA UTILIZACION

exec @w_error = sp_fecha_valor 
@s_date              = @w_fecha_proceso,
@s_user              = 'consola',
@s_term              = 'cobis',
@i_fecha_valor       = @w_fecha_valor,
@i_banco             = @w_banco,
@i_operacion         = 'F',
@i_en_linea          = 'N'

if @w_error  <> 0 begin 
  select @w_msg = 'ERROR: AL REALIZAR FV AL:'+convert(varchar,@w_fecha_valor)  
  goto   ERROR
end

--PAGO DEL 02/26/2019
exec @w_error     = sp_pago_cartera_srv
@s_user           = @s_user,
@s_term           = @s_term,
@s_date           = @w_fecha_proceso,
@s_ofi            = @w_oficina,         
@i_banco          = @w_banco,
@i_fecha_valor    = @w_fecha_valor,
@i_forma_pago     = @w_forma_pago,
@i_monto_pago     = @w_monto,
@i_cuenta         = @w_cuenta,      --Cuenta Santander del Cliente
@o_msg            = @w_msg out,
@o_secuencial_ing = @w_secuencial_ing out

if @w_error  <> 0 begin 
  select @w_msg = 'ERROR: AL EJECUTAR PAGO A LA FECHA: '+ convert(varchar,@w_fecha_valor)   
  goto   ERROR
end


--UTILIZACION DEL  '02/27/2019'
select 
@w_fecha_valor =  '02/27/2019',--FECHA DE LA  SEGUNDA UTILIZACION
@w_monto       =  1500

exec @w_error  = sp_lcr_desembolsar_batch  
@i_param1      = @w_banco ,
@i_param2      = @w_monto ,
@i_fecha_valor = @w_fecha_valor

if @w_error  <> 0 begin 
  select @w_msg = 'ERROR: AL DESEMBOLSAR AL'+convert(varchar,@w_fecha_valor)  
  goto   ERROR
end

--FECHA VALOR AL 03/06/2019
select @w_fecha_valor =  '03/06/2019'--FECHA DEL SIGUIENTE PAGO 

exec @w_error = sp_fecha_valor 
@s_date              = @w_fecha_proceso,
@s_user              = 'consola',
@s_term              = 'cobis',
@i_fecha_valor       = @w_fecha_valor,
@i_banco             = @w_banco,
@i_operacion         = 'F',
@i_en_linea          = 'N'

if @w_error  <> 0 begin 
  select @w_msg = 'ERROR: AL REALIZAR FV AL :'+ convert(varchar,@w_fecha_valor)  
  goto   ERROR
end


--PAGO DEL '03/06/2019'
exec @w_error     = sp_pago_cartera_srv
@s_user           = @s_user,
@s_term           = @s_term,
@s_date           = @w_fecha_proceso,
@s_ofi            = @w_oficina,         
@i_banco          = @w_banco,
@i_fecha_valor    = @w_fecha_valor,
@i_forma_pago     = @w_forma_pago,
@i_monto_pago     = @w_monto,
@i_cuenta         = @w_cuenta,      --Cuenta Santander del Cliente
@o_msg            = @w_msg out,
@o_secuencial_ing = @w_secuencial_ing out

if @w_error  <> 0 begin 
  select @w_msg = 'ERROR: AL EJECUTAR PAGO A LA FECHA: '+ convert(varchar,@w_fecha_valor)   
  goto   ERROR
end

--MARCAMOS CON LA LETRA P DE PROCESADO Y FECHA VIEJA  LOS REGISTROS DE DESEMBOLSOS GENERADOS PARA QUE NO LOS TOME EL PROCESO ASINCRONICO


update ca_desembolso set 
dm_estado = 'RV'
where dm_operacion = @w_operacionca
and dm_terminal = 'batch-utilizacion' 

select @w_error = @@error


if @w_error  <> 0 begin 
  select @w_msg = 'ERROR: AL ACTUALIZAR DESEMBOLSO'  
  goto   ERROR
end

select 'DESPUES', * from ca_abono where ab_operacion = @w_operacionca
select 'DESPUES', op_fecha_ult_proceso,op_estado,* from ca_operacion where op_banco = @w_banco  
select 'DESPUES',* from ca_desembolso where dm_operacion = @w_operacionca
select 'DESPUES',
tr_fecha_ref, tr_secuencial,tr_tran,dtr_monto, dtr_concepto
from cob_cartera..ca_transaccion , cob_cartera..ca_det_trn
where  tr_operacion = dtr_operacion 
and tr_secuencial =dtr_secuencial 
and tr_estado <> 'RV'
and tr_secuencial > 0
and dtr_concepto = 'CAP'
and tr_operacion = @w_operacionca
order by tr_secuencial,tr_fecha_ref 

if @w_commit = 'S' begin 
   select @w_commit = 'N'
   commit tran 
end

ERROR:

print isnull(@w_msg ,'no hay mensaje')
print isnull(@w_error , 70001)

if @w_commit = 'S' begin 
   select @w_commit = 'N'
   rollback tran 
end