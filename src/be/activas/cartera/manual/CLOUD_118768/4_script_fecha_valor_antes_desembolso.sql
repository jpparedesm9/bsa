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
@w_operacion      int,
@w_fecha_valor    datetime

select @w_operacion   = 217305,
       @w_fecha_valor = '05/21/2019'

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

select op_fecha_ult_proceso, *
from cob_cartera..ca_operacion
where op_operacion = @w_operacion

select @w_banco    = op_banco,
       @w_oficina  = op_oficina   
from cob_cartera..ca_operacion
where op_operacion = @w_operacion

begin tran

   exec @w_error = sp_fecha_valor 
        @s_date        = @w_fecha_proceso,
        @s_user        = 'usrbatch',
        @s_term        = 'consola',
        @s_ofi         = @w_oficina,
        @t_trn         = 7049,
        @i_fecha_mov   = @w_fecha_proceso,
        @i_fecha_valor = @w_fecha_valor,
        @i_banco       = @w_banco,
        @i_operacion   = 'F'            
       
    
   if @w_error<>0
	 begin
	    rollback 
	 end   
			   
commit tran	


select op_fecha_ult_proceso, *
from cob_cartera..ca_operacion
where op_operacion = @w_operacion