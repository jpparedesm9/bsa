USE cob_cartera
GO


DECLARE 
@w_fecha_proceso  DATETIME,
@w_error          INT,
@w_secuencial     INT,
@w_secuencial_des INT,
@w_secuencial_ing INT,
@w_banco          VARCHAR(32),
@w_grupo          INT,
@w_oficina        INT,
@w_ab_estado      VARCHAR(10),
@w_operacion      int

--Reversar Desembolso

select @w_operacion = 217305

select @w_secuencial_des = tr_secuencial 
from cob_cartera..ca_transaccion
where tr_operacion = @w_operacion
and   tr_tran      = 'DES'
and   tr_secuencial > 0
and   tr_estado    <> 'RV'
and   tr_fecha_ref = '05/28/2019'


select *
from cob_cartera..ca_transaccion
where tr_operacion = @w_operacion
and   tr_tran      = 'DES'
and   tr_secuencial > 0
and   tr_estado    <> 'RV'
and   tr_fecha_ref = '05/28/2019'
and   tr_secuencial=@w_secuencial_des 


select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select @w_banco    = op_banco,
       @w_oficina  = op_oficina   
from cob_cartera..ca_operacion
where op_operacion = @w_operacion
  

PRINT '@w_banco1 ' + @w_banco

PRINT '@w_secuencial_des:  ' + convert(VARCHAR,@w_secuencial_des)

begin tran

exec @w_error = sp_fecha_valor 
     @s_date       = @w_fecha_proceso,
	 @s_user       = 'usrbatch',
	 @s_term       = 'consola',
	 @t_trn        = 7049,
	 @i_fecha_mov  = @w_fecha_proceso,
	 @i_banco      = @w_banco,
	 @i_secuencial = @w_secuencial_des,
	 @i_operacion  = 'R',
	 @s_ofi        = @w_oficina
	 
	 if @w_error<>0
	 begin
	    rollback 
	 end   
			   
commit tran			   

select *
from cob_cartera..ca_transaccion
where tr_operacion = @w_operacion
and   tr_tran      = 'DES'
and   tr_secuencial > 0
and   tr_fecha_ref = '05/28/2019'

go



