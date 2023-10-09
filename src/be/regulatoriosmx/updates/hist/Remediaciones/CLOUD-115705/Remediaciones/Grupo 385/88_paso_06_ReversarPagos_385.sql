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
fecha_ori    DATETIME NULL,
fecha_nueva  DATETIME NULL
)
GO



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
-- grupo 385
INSERT #pagos_reversar 
SELECT
      0,
      banco     = op_banco, 
      operacion = op_operacion,
      sec_ing   = ab_secuencial_ing,
      sec_pag   = ab_secuencial_pag,
      ab_fecha_pag,
      '03/12/2019'
from ca_abono,
     ca_operacion
where op_operacion = ab_operacion
and ab_estado    = 'A'
and ab_fecha_pag >= '03/12/2019'
AND op_operacion IN (
163914,
163917,
163920,
163923,
163926,
163929,
163932,
163935,
163938
)
ORDER BY ab_operacion, ab_secuencial_pag DESC 

select * from #pagos_reversar

--/////////////////////////////////////


UPDATE cobis..cl_parametro SET pa_char = 'N'
where pa_nemonico = 'PAVACA'
AND pa_producto = 'CCA'


delete from #pagos_reversar where sec_pag = 0

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

BEGIN try
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

END TRY
BEGIN CATCH
 PRINT 'error'
END CATCH
   
	select '@w_error' = @w_error			   ,
          '@w_banco' = @w_banco,
          '@w_sec_pag'= @w_sec_pag
         
end  -- while

delete from ca_corresponsal_det
where cd_secuencial in (80301, 82143, 82566, 90287, 90288, 90289, 90290 )

      
   update ca_corresponsal_trn set 
   	co_estado     = 'I',
   	co_error_id   = 0,
   	co_error_msg  = '',
   	co_fecha_valor = '03/12/2019'
   where co_secuencial  in (80301, 82143, 82566, 90287, 90288, 90289, 90290 )


UPDATE cobis..cl_parametro SET pa_char = 'S'
where pa_nemonico = 'PAVACA'
AND pa_producto = 'CCA'

GO
