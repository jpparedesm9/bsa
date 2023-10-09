





--Lista 3:
--Dejar crédito a 16 semanas, manteniendo el desplazamiento
--Aplicar los pagos realizados por el grupo hasta la fecha


use cob_cartera
go

declare 
@w_operacion           int,
@w_fecha_proceso       datetime,
@w_banco               cuenta,
@w_error               int,
@w_secuencial          int,
@w_id                  int ,
@w_fecha_ini           datetime,
@w_oficina             int ,
@w_cliente             int ,
@w_msg                 varchar(255) ,
@w_secuencial_dsp      int,
@w_secuencial_res      int,
@w_bloque_ini          int,
@w_bloque_fin          int ,
@w_fecha_dsp           datetime ,
@w_segundo_dsp       char(1),
@w_min_sec_dsp        int ,
@w_max_sec_dsp        int ,
@w_fecha_ini_dsp      datetime,
@w_secuencial_espera  int, 
@w_secuencial_iva_espera int 




select 
@w_bloque_ini = 0,
@w_bloque_fin = 2000




select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso



select @w_id = @w_bloque_ini ,@w_secuencial_dsp = 0, @w_secuencial_res = 0 , @w_segundo_dsp = 'N'

--TABLA AUXILIAR DE TRABAJO 
if object_id('tempdb..#operaciones_142443_2') is not null  
   drop table tempdb..#operaciones_142443_2

select 
id                   = id,
op_operacion         = op_operacion,
op_banco             = op_banco ,
op_oficina           = op_oficina,
op_cliente           = op_cliente,
op_procesado         = op_procesado
into #operaciones_142443_2
from operaciones_142443_2  with (nolock)
where id > @w_bloque_ini  and id <= @w_bloque_fin
order by id asc


create unique nonclustered index ca_operacion_1
	on #operaciones_142443_2 (id)	


delete #operaciones_142443_2 where op_procesado  in ('S','N')

--delete #operaciones_142443_2 where op_operacion   not in (942265)
--update operaciones_142443_2 set op_procesado = null where op_operacion = 942265
-- delete 
--PRIMER BLOQUE 0-2500

while 1 = 1 begin

   select  top 1
   @w_id                = id,
   @w_operacion         = op_operacion,
   @w_banco             = op_banco ,
   @w_oficina           = op_oficina,
   @w_cliente           = op_cliente
   from #operaciones_142443_2
   where id > @w_id  
   order by id asc
   
   if @@rowcount = 0 break 
   
   --CARGAMOS EN TEMPORALES LAS REESTRUTURACIONES PARA REVERSAR 
   
   
   select 
   @w_secuencial_res  = isnull(tr_secuencial,0) ,
   @w_fecha_ini       = tr_fecha_ref
   from ca_transaccion 
   where tr_operacion = @w_operacion
   and tr_tran = 'RES'
   and tr_secuencial >0 
   and tr_estado <> 'RV' 
   
   
   
   if  @w_secuencial_res = 0  or  @w_secuencial_res is null begin 

	  insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70001,'',2)
	  
      update operaciones_142443_2 set  op_procesado = 'N' where id =   @w_id
	  
      goto Siguiente
	  
   end 
   
   select @w_segundo_dsp  = 'N'

       

   
   select @w_fecha_ini_dsp = tr_fecha_ref,@w_max_sec_dsp = max(tr_secuencial)
   from ca_transaccion where 
   tr_operacion = @w_operacion 
   and tr_tran = 'DSP' 
   and tr_estado <> 'RV' 
   and tr_secuencial <@w_secuencial_res
   group by tr_fecha_ref
   
   if exists (select 1 from ca_transaccion where tr_operacion = @w_operacion and tr_tran = 'DSP' and tr_estado <> 'RV' and tr_secuencial >@w_secuencial_res) begin 
   
      select @w_segundo_dsp = 'S'
      
      select @w_min_sec_dsp = min(tr_secuencial)
      from ca_transaccion where 
      tr_operacion = @w_operacion 
      and tr_tran = 'DSP' 
      and tr_estado <> 'RV' 
      and tr_secuencial >@w_secuencial_res
         
   end 
   
    --REVERSAMOS LA ORIGINAL REESTRUTURA 
   if @w_secuencial_res  > 0 begin 
   
   ----REVERSAR TRANSACCIONES RES  -------------- 
      exec @w_error = sp_fecha_valor 
      @s_date        = @w_fecha_proceso,
      @s_user        = 'usrbatch',
      @s_term        = 'consola',
      @t_trn         = 7049,
      @i_fecha_mov   = @w_fecha_proceso,
      @i_banco       = @w_banco,
      @i_secuencial  = @w_secuencial_res ,
      @i_operacion   = 'R'
	  
	  if @w_error <> 0 or @@error <> 0 begin 
	  
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70002,'',2)
		  
         update operaciones_142443_2 set  op_procesado = 'N' where id =   @w_id
		 
         goto Siguiente
		 
      end         
   
   end 
   
   if  @w_segundo_dsp = 'S'begin
      update ca_desplazamiento set 
      de_estado = 'R',
      de_secuencial = @w_min_sec_dsp
      where de_operacion = @w_operacion 
      and de_estado   = 'I'
   end 
   

   
   --PARA LEVANTAR PAGOS QUE SE HAYAN DADO ENTRE EL DSP Y LAS RES ENVIAMOS FV HACIA EL FECHA FIN DEL DSP
   
    select 
	@w_fecha_dsp = de_fecha_ini,
    @w_fecha_ini = de_fecha_fin
    from ca_desplazamiento where de_operacion = @w_operacion and de_estado = 'A'
   

   --LLEVAMOS OPERACIONES  HACIA LA FECHA INI DEL DSP   
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @s_ofi         = @w_oficina,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_dsp   ,
   @i_banco       = @w_banco,
   @i_operacion   = 'F'  

    if @w_error <> 0 or @@error <> 0 begin 
	  
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70003,'',2)
		  
         update operaciones_142443_2 set  op_procesado = 'N' where id =   @w_id
		 
         goto Siguiente
		 
      end     
   
   --REVERSAMOS EL DSP  SE TIENE QUE MARCAR CON R PARA EVITAR DUPLICIDAD 
   update ca_desplazamiento set 
   de_estado = 'R',
   de_secuencial      = @w_max_sec_dsp
   where de_operacion = @w_operacion 
   and de_estado   = 'I'
      
   
   ---GENERAMOS LOS NUEVOS DSPS SIN GENERALES LOS INTS ESPERA 
      
   if @w_segundo_dsp = 'S' begin 
   
      
      exec @w_error=sp_desplazamiento	
      @i_banco          = @w_banco  ,
      @i_cliente        = @w_cliente,
      @i_fecha_valor    = @w_fecha_ini_dsp  ,--fecha de proceso
      @i_cuotas         = 12 ,
      @i_cuota_vencida = 'N',
      @i_archivo        = 'DESPLAZAMIENTO_140566.txt' ,--nombre del archivo
      @i_genera_int_esp = 'N'       ,                  --NO SE GENERA NINGUN INTERES ESPERA 
      @o_msg            = @w_msg   out
	  
	  
      if @w_error <> 0 or @@error <> 0 begin 
      
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70004,@w_msg,2)
         
         update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
         
         goto Siguiente
      
      end 
      
   end  else begin 

      exec @w_error=sp_desplazamiento	
      @i_banco          = @w_banco  ,
      @i_cliente        = @w_cliente,
      @i_fecha_valor    = @w_fecha_ini_dsp  ,--fecha de proceso
      @i_cuotas         = 8 ,
      @i_cuota_vencida = 'N',
      @i_archivo        = 'DESPLAZAMIENTO_140566.txt' ,--nombre del archivo
      @i_genera_int_esp = 'N'       ,                  --NO SE GENERA NINGUN INTERES ESPERA 
      @o_msg            = @w_msg   out
	  
	  
      if @w_error <> 0 or @@error <> 0 begin 
      
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70005,@w_msg,2)
         
         update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
         
         goto Siguiente
      
      end 
   
   
   end 
   
   
    select 
   @w_secuencial_espera  = ab_secuencial_ing
   from cob_cartera..ca_abono,cob_cartera..ca_abono_det
   where ab_operacion            = @w_operacion
   and   ab_operacion      = abd_operacion
   and   ab_secuencial_ing = abd_secuencial_ing
   and   ab_estado         in ('A', 'NA', 'ING')
   and   abd_tipo          = 'CON'
   and   abd_concepto      in ('INT_ESPERA')
   
   
   select @w_secuencial_iva_espera  = ab_secuencial_ing
   from cob_cartera..ca_abono,cob_cartera..ca_abono_det
   where ab_operacion      = @w_operacion
   and   ab_operacion      = abd_operacion
   and   ab_secuencial_ing = abd_secuencial_ing
   and   ab_estado         in ('A', 'NA', 'ING')
   and   abd_tipo          = 'CON'
   and   abd_concepto      in ('IVA_ESPERA')
	  

   if (@w_secuencial_espera > 0 ) begin
	  
 
	  
      exec @w_error      = sp_eliminar_pagos
      @s_ssn             = 101,
      @s_srv             = 'srv',
      @s_date            = @w_fecha_proceso,
      @s_user            = 'usrbatch',
      @s_term            = 'consola',
      @s_ofi             = @w_oficina,
      @i_banco           = @w_banco,
      @i_operacion       = 'D',
      @i_secuencial_ing  = @w_secuencial_espera,
      @i_en_linea        = 'N',
      @i_pago_ext        = 'N'
	  
      if @w_error <> 0 begin  
      
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70005,'',1)
         
         update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
         
         goto Siguiente 
      
      end 
	  
	 
	  
	  exec @w_error      = sp_eliminar_pagos
      @s_ssn             = 102,
      @s_srv             = 'srv',
      @s_date            = @w_fecha_proceso,
      @s_user            = 'usrbatch',
      @s_term            = 'consola',
      @s_ofi             = @w_oficina,
      @i_banco           = @w_banco,
      @i_operacion       = 'D',
      @i_secuencial_ing  = @w_secuencial_iva_espera ,
      @i_en_linea        = 'N',
      @i_pago_ext        = 'N'

	  
      if @w_error <> 0 begin  
      
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70005,'',1)
         
         update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
         
         goto Siguiente 
      
      end 
   	  
   end 



   
   --LLEVAMOS OPERACIONES  HACIA LA FECHA PROCESO   
   exec @w_error = sp_fecha_valor 
   @s_date        = @w_fecha_proceso,
   @s_user        = 'usrbatch',
   @s_term        = 'consola',
   @s_ofi         = @w_oficina,
   @t_trn         = 7049,
   @i_fecha_mov   = @w_fecha_proceso,
   @i_fecha_valor = @w_fecha_proceso   ,
   @i_banco       = @w_banco,
   @i_operacion   = 'F'            
                     
       
   if @w_error <> 0 or @@error <> 0 begin 
   
      insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70006,'',2)
	   
      update operaciones_142443_2 set  op_procesado = 'N' where id =   @w_id
	  
      goto Siguiente
	  
   end         
   
  
   
   
    update operaciones_142443_2 set  op_procesado = 'S' where id =   @w_id
	
	
   
   Siguiente:   
end





select 'VERIFICACION DE MONTOS ESPERA POSTERIOR'

select
operacion = am_operacion , 
cuota = sum(am_cuota) 
into #verificaciones 
from ca_amortizacion 
where am_operacion in ( select op_operacion from #operaciones_142443_2 where id>@w_bloque_ini and id<= @w_bloque_fin)
and am_concepto in( 'INT_ESPERA')
group by am_operacion , am_concepto




select 
operacion, 
cuota, 
sum(de_int_dsp) 
from 
#verificaciones , ca_desplazamiento 
where de_operacion = operacion
and de_estado = 'A'
group by operacion,cuota


select 'VERIFICACION DE DIVIDENDOS'

select di_operacion , count(di_dividendo)
from ca_dividendo 
where di_operacion in(select op_operacion from #operaciones_142443_2 where id>@w_bloque_ini and id<= @w_bloque_fin)
group by di_operacion



drop table #verificaciones
drop table #operaciones_142443_2
