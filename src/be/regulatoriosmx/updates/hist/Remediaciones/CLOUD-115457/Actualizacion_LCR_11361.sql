
USE cob_cartera
GO

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

SELECT @w_fecha_proceso = fp_fecha FROM cobis..ba_fecha_proceso



--DATOS DE LA OPERACION LCR 
select 
@w_operacionca  = op_operacion,
@w_banco        =  op_banco ,
@w_oficina      =  op_oficina ,
@w_cuenta       =  op_cuenta
from ca_operacion where op_banco = '233510044602'

  
select 
@s_user         = 'usrbatch',
@w_forma_pago   = 'ND_BCO_MN',
@s_term         = 'batch'


select 'ANTES',   * from ca_desembolso   where dm_operacion  = @w_operacionca
select 'ANTES', * from ca_amortizacion where am_operacion = @w_operacionca    
select 'ANTES', * from ca_dividendo where di_operacion = @w_operacionca 

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




--INICIO ATOMICIDAD 
select @w_commit = 'N'

if @@trancount = 0 begin 
   select @w_commit = 'S'
   begin tran 
end



select @w_fecha_valor = '03/12/2019'

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


select @w_fecha_valor =  '03/26/2019'

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


select 'DESPUES',   * from ca_desembolso   where dm_operacion  = @w_operacionca
select 'DESPUES', * from ca_amortizacion where am_operacion = @w_operacionca
select 'DESPUES', * from ca_dividendo    where di_operacion = @w_operacionca 

select 'DESPUES'
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