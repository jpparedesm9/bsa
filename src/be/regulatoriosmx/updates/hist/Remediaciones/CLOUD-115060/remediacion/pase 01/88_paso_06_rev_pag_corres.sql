use cob_cartera
GO

DROP table #pagos_reversar
GO
CREATE TABLE #pagos_reversar(
id INT IDENTITY,
secuencial INT,
banco      VARCHAR(32),
operacion  INT,
sec_ing    INT,
sec_pag    INT,
fecha_ori    DATETIME,
fecha_nueva  DATETIME
)
GO


UPDATE cobis..cl_parametro SET pa_char = 'N'
where pa_nemonico = 'PAVACA'
AND pa_producto = 'CCA'

go

declare @w_error      int,
        @w_oficina    int,
        @w_banco      varchar(20),
        @w_sec_pag    int,
        @w_fecha_proceso datetime,
        @w_sec_ing       int,
        @w_secuencial    INT,
        @w_id            INT,
        @w_fecha_ori     DATETIME,
        @w_fecha_nueva   DATETIME

 select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

--///////////////////////////////
-- grupo 832 
INSERT #pagos_reversar 
select 
secuencial= cd_secuencial, 
banco     = cd_banco, 
operacion = cd_operacion,
sec_ing   = cd_sec_ing,
sec_pag   = convert(int,0),
NULL,
'03/14/2019'
from ca_corresponsal_det cd 
where cd_secuencial IN( 
82161,
82759,
83631,
85134
)
--/////////////////////////////////////



update #pagos_reversar set
	sec_pag = ab_secuencial_pag,
	fecha_ori = ab_fecha_pag
from ca_abono
where operacion = ab_operacion
and ab_secuencial_ing = sec_ing
and ab_estado = 'A'

select * from #pagos_reversar


delete from #pagos_reversar where sec_pag=0

SELECT @w_id = 0

while 1 =1
begin
     
     select top 1
     @w_banco   = banco,
     @w_sec_pag = sec_pag,
     @w_sec_ing = sec_ing,
     @w_secuencial  = secuencial,
     @w_id          = id,
     @w_fecha_nueva = fecha_nueva
     from #pagos_reversar
     where id > @w_id
     order by id
     
     if @@rowcount = 0 break
    
     select @w_oficina = op_oficina
     from cob_cartera..ca_operacion
     where op_banco    = @w_banco    


     exec @w_error = sp_fecha_valor 
		       @s_date       = @w_fecha_proceso,
			   @s_user       = 'usrbatch',
			   @s_term       = 'consola',
			   @t_trn        = 7049,
			   @i_fecha_mov  = @w_fecha_proceso,
			   @i_banco      = @w_banco,
			   @i_secuencial = @w_sec_pag  ,
			   @i_operacion  = 'R',
			   @s_ofi        = @w_oficina

   delete from ca_corresponsal_det
   where cd_secuencial = @w_secuencial
   and cd_banco = @w_banco
   and cd_sec_ing = @w_sec_ing


	SELECT 'antes', * FROM ca_corresponsal_trn
   where co_secuencial = @w_secuencial
      
   update ca_corresponsal_trn set 
   	co_estado     = 'I',
   	co_error_id   = 0,
   	co_error_msg  = '',
   	co_fecha_valor = @w_fecha_nueva
   where co_secuencial = @w_secuencial


	SELECT 'despues', * FROM ca_corresponsal_trn
   where co_secuencial = @w_secuencial
      
	select '@w_error' = @w_error			   ,
          '@w_banco' = @w_banco,
          '@w_sec_pag'= @w_sec_pag
         
end  -- while




GO
