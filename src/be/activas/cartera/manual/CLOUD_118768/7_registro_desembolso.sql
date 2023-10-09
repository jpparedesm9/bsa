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
       @w_fecha_valor = '05/28/2019'

select @w_banco    = op_banco,
       @w_oficina  = op_oficina   
from cob_cartera..ca_operacion
where op_operacion = @w_operacion
       
begin tran 

exec @w_error =  cob_cartera..sp_lcr_desembolsar 
     @i_canal      = 'B2C',
     @i_banco      = @w_banco,
     @i_monto      = 1500.0,
     @t_trn        = 7297,
     @o_msg        = ' ',
     @s_srv        = 'BRANCHSRV', 
     @s_user       = 'usuariobv',
     @s_term       = '5519120215',
     @i_fecha_valor= @w_fecha_valor,
     @s_ofi        = 1,
     @s_rol        = 96,
     @s_ssn        = 100517070,
     @s_lsrv       = 'CTSSRV',
     @s_date       = @w_fecha_valor,
     @s_sesn       = 0,
     @s_org        = 'U'

if @w_error<>0
begin
    rollback 
end   
			   

commit tran
