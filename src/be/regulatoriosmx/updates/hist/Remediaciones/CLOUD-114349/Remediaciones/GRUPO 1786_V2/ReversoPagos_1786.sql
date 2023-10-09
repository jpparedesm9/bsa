declare @w_secuencial        int,
        @w_operacion_grupal  int,
        @w_banco_grupal      varchar(20),
        @w_observacion       varchar(50),
        @w_fecha_valor       datetime,
        @w_oficina_oper      int,
        @w_error             int,
        @w_fecha_proceso     datetime,
        @w_secuencial_corresponsal  int

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

--select @w_secuencial_corresponsal = 60714

select  *
into #pagos_grupales_prueba
from cob_cartera..ca_corresponsal_trn
where co_secuencial IN( 60714, 70082, 73915 ) --@w_secuencial_corresponsal


select @w_secuencial = 0

while 1 = 1
begin
     select top 1 
            @w_secuencial       = co_secuencial    ,
            @w_operacion_grupal = co_codigo_interno,
            @w_observacion      = 'Reverso Operacion',
            @w_fecha_valor      = co_fecha_valor
     from #pagos_grupales_prueba
     where co_secuencial > @w_secuencial 
     ORDER BY co_secuencial
     
     
     if @@ROWCOUNT = 0
        break
     
     select @w_banco_grupal = op_banco,
            @w_oficina_oper = op_oficina 
     from cob_cartera..ca_operacion
     where op_operacion = @w_operacion_grupal
     
     select '@w_secuencial'  = @w_secuencial  ,
            '@w_banco_grupal'= @w_banco_grupal,
            '@w_observacion' = @w_observacion ,
            '@w_fecha_valor' = @w_fecha_valor ,
            '@w_oficina_oper'= @w_oficina_oper
       
     BEGIN TRY 	
     
         exec @w_error = cob_cartera..sp_fecha_valor 
         @s_date       = @w_fecha_proceso   ,
         @s_lsrv       = 'CTSSRV'       ,
         @s_ofi        = @w_oficina_oper,
         @s_org        = 'U'            ,
         @s_rol        = 29             ,
         @s_ssn        = 1535734        ,
         @s_sesn       = 31712          ,
         @s_srv        = 'CTSSRV'       ,
         @s_term       = 'consola',
         @s_user       = 'usrbatch'   ,
         @t_trn        = 7049           ,
         @i_fecha_mov  = @w_fecha_valor ,         
         @i_banco      = @w_banco_grupal,
         @i_secuencial = @w_secuencial  ,
         @i_operacion  = 'R'            ,
         @i_observacion= @w_observacion ,
         @i_grupal     = 'S'
     
     END TRY
	 BEGIN CATCH
	     goto SIGUIENTE
     END CATCH
          
     SIGUIENTE:
        
end

--actualizacion de los pagos corresponsales
update cob_cartera..ca_corresponsal_trn
set    co_fecha_real     = '03/25/2019 08:00'
where  co_estado         = 'I'
and    co_codigo_interno = 99294
--and    co_secuencial IN( 60714, 70082, 73915 )


select *
from  cob_cartera..ca_corresponsal_trn
where  co_estado = 'I'

exec cob_cartera..sp_pagos_corresponsal_batch 
@i_param1  = 'B'


go



drop table #pagos_grupales_prueba
