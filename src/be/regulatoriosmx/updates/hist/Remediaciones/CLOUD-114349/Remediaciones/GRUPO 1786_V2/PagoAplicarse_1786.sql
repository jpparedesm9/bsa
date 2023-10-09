declare @w_secuencial        int,
        @w_operacion_grupal  int,
        @w_banco_grupal      varchar(20),
        @w_observacion       varchar(50),
        @w_fecha_valor       datetime,
        @w_oficina_oper      int,
        @w_error             int,
        @w_monto             money,
        @w_fecha_proceso     datetime,
        @w_secuencial_corresponsal int

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
--select @w_secuencial_corresponsal = 39869       
        
select top 20 co_secuencial,
              ab_fecha_ing         = co_fecha_valor,
              tg_referencia_grupal = op_banco,
              co_monto
into #procesa_dcu_pagos
from  cob_cartera..ca_corresponsal_trn,
      cob_cartera..ca_operacion
where co_secuencial IN( 60714, 70082, 73915 )
and   co_codigo_interno = op_operacion

select @w_secuencial = 0

while 1 = 1
begin
     select top 1 
            @w_secuencial       = co_secuencial       ,
            @w_fecha_valor      = ab_fecha_ing        ,
            @w_banco_grupal     = tg_referencia_grupal,
            @w_monto            = co_monto
     from #procesa_dcu_pagos
     where co_secuencial > @w_secuencial 
     order by co_secuencial
     
     
     if @@ROWCOUNT = 0
        break
     
     select '@w_secuencial'  = @w_secuencial  ,
            '@w_banco_grupal'= @w_banco_grupal,
            '@w_fecha_valor' = @w_fecha_valor ,
            '@w_oficina_oper'= @w_oficina_oper,
            '@w_monto'       = @w_monto
       
     BEGIN TRY 	
     
      exec   cob_cartera..sp_ing_detabono 
              @s_user            = 'usrbatch'   ,
              @s_date            = @w_fecha_proceso  ,
              @s_sesn            = 1540374        ,
              @s_term            = 'consola',
              @i_accion          = 'G'  ,
              @i_encerar         = 'S'  ,     
              @i_tipo            = 'PAG',
              @i_concepto        = 'SANTANDER',
              @i_cuenta          = @w_banco_grupal,
              @i_moneda          = 0,
              @i_beneficiario    = '',
              @i_monto_mpg       = @w_monto,
              @i_monto_mop       = @w_monto,
              @i_monto_mn        = @w_monto,
              @i_cotizacion_mpg  = 1,
              @i_cotizacion_mop  = 1,
              @i_tcotizacion_mpg = 'COT',
              @i_tcotizacion_mop = 'COT',
              @i_no_cheque       = 0,
              @i_inscripcion     = 0,
              @i_carga           = 0,
              @i_banco           = @w_banco_grupal,
              @i_porcentaje      = 0.0,
              @i_fecha_vig       = @w_fecha_valor
         
         
     
     END TRY
	 BEGIN CATCH
	     
	     select '@w_error'  = @w_error
	     goto SIGUIENTE
     END CATCH
     
     SIGUIENTE:
        
end



update cob_cartera..ca_corresponsal_trn
set    co_fecha_real     = '03/25/2019 08:00'
where  co_estado         = 'I'
and    co_codigo_interno = 99294


select *
from  cob_cartera..ca_corresponsal_trn
where  co_estado = 'I'

exec cob_cartera..sp_pagos_corresponsal_batch 
@i_param1  = 'B'


go

drop table #procesa_dcu_pagos
