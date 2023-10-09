




--LISTA 1:
--DEJAR CREDITO A 16 SEMANAS, MANTENIENDO EL DESPLAZAMIENTO
--APLICAR REESTRUCTURA PARA GENERACIÓN DE INTERESES EN ESPERA A 16 SEMANAS
--APLICAR CONDONACION
--APLICAR LOS PAGOS REALIZADOS POR EL GRUPO HASTA LA FECHA


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
@w_tiene_seguro       char(1),
@w_div_inicio         int,
@w_div_fin            int,
@w_dividendo          int,
@w_monto_cobrar       money, 
@w_valor_seguro       money ,
@w_moneda             int ,
@w_toperacion         catalogo,
@w_secuencial_iva_espera  int ,
@w_secuencial_espera    int 



select 
@w_bloque_ini = 2000,
@w_bloque_fin = 4000



select @w_valor_seguro = isnull(pa_money,48) from cobis..cl_parametro where pa_nemonico = 'SEGAD' and pa_producto='CCA'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso


select @w_id = @w_bloque_ini ,@w_secuencial_dsp = 0, @w_secuencial_res = 0 , @w_segundo_dsp = 'N'

--TABLA AUXILIAR DE TRABAJO 
if object_id('tempdb..#operaciones_142443_1') is not null  
   drop table tempdb..#operaciones_142443_1


select 
id                   = id,
op_operacion         = op_operacion,
op_banco             = op_banco ,
op_oficina           = op_oficina,
op_cliente           = op_cliente,
op_moneda            = op_moneda,
op_toperacion        = op_toperacion,
op_procesado         = op_procesado
into #operaciones_142443_1
from operaciones_142443_1  with (nolock)
where id > @w_bloque_ini  and id <= @w_bloque_fin
order by id asc


create unique nonclustered index ca_operacion_1
	on #operaciones_142443_1 (id)	


delete #operaciones_142443_1 where op_procesado  in ('S','N')

--delete #operaciones_142443_1 where op_operacion   not in (1236339)
--update operaciones_142443_1 set op_procesado = null where op_operacion = 1236339



while 1 = 1 begin

   select  top 1
   @w_id                = id,
   @w_operacion         = op_operacion,
   @w_banco             = op_banco ,
   @w_oficina           = op_oficina,
   @w_cliente           = op_cliente,
   @w_moneda            = op_moneda,
   @w_toperacion        = op_toperacion
   from #operaciones_142443_1
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
   
   if  @w_secuencial_res = 0 or @w_secuencial_res is null begin 
   
	  
      insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70001,'',1)
	  
      update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
	  
      goto Siguiente
	  
   end 
   
   --INICIALIZAMOS SI TIENE O NO SEGUNDO DSP
   
   select @w_segundo_dsp  = 'N'
   select @w_tiene_seguro = 'N'
   
   if exists(select 1 from ca_amortizacion where am_operacion =  @w_operacion and am_concepto like '%SEGAD%') 
      select @w_tiene_seguro = 'S'
  
   
   --OBTENEMOS LA FECHA REF DEL ULTIMO DSP ANTES DE LA RES 
   select 
   @w_fecha_ini_dsp = tr_fecha_ref,
   @w_max_sec_dsp   = max(tr_secuencial)
   from ca_transaccion where 
   tr_operacion = @w_operacion 
   and tr_tran = 'DSP' 
   and tr_estado <> 'RV' 
   and tr_secuencial <@w_secuencial_res
   group by tr_fecha_ref
   
   --SI EXISTE UN DSP POSTERIOR AL RES ENTONCES HUBO UN SEGUNDO DSP CAPTURAMOS ESE SECUENCIAL DEL DSP 
   
   if exists (select 1 from ca_transaccion where tr_operacion = @w_operacion and tr_tran = 'DSP' and tr_estado <> 'RV' and tr_secuencial >@w_secuencial_res) begin 
   
      select @w_segundo_dsp = 'S'
      
      select @w_min_sec_dsp = min(tr_secuencial)
      from ca_transaccion 
	  where tr_operacion = @w_operacion 
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
	    
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70002,'',1)
		 
         update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
		 
         goto Siguiente
		 
      end         
   
   end 
   
   
   --SI TUVO UN SEGUNDO DSP AL MOMENTO DE REESTRUTURAR SE COLOCA EN I EL DESPLAZAMIENTO PARA ESTO LO REVERSAMOS
   if  @w_segundo_dsp = 'S'begin
   
      update ca_desplazamiento set 
      de_estado = 'R',
      de_secuencial = @w_min_sec_dsp
      where de_operacion = @w_operacion 
      and de_estado   = 'I'
	  
	  
   end 
   

   
   --PARA LEVANTAR PAGOS QUE SE HAYAN DADO ENTRE EL DSP Y LAS RES ENVIAMOS FV HACIA EL FECHA FIN DEL DSP
   
    select 
	@w_fecha_dsp = de_fecha_ini
    from ca_desplazamiento 
	where de_operacion = @w_operacion 
	and de_estado = 'A'
   

   --LLEVAMOS OPERACIONES  HACIA LA FECHA FIN DEL DSP   
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
   
      insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70003,'',1)
	  
      update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
	  
      goto Siguiente
   
   end     
   
   --REVERSAMOS EL DSP  SE TIENE QUE MARCAR CON R PARA EVITAR DUPLICIDAD  EN ESTE PUNTO TODAS LAS DSP DEBERIAN ESTAR REVERSADAS
   update ca_desplazamiento set 
   de_estado = 'R',
   de_secuencial      = @w_max_sec_dsp
   where de_operacion = @w_operacion 
   and de_estado   = 'I'
      

   --SI TENEMOS DOS DESPLAZAMIENTOS CUOTAS = 12 CASO CONTRARIO 8
      
   if @w_segundo_dsp = 'S' begin 
   
      
      exec @w_error=sp_desplazamiento	
      @i_banco          = @w_banco  ,
      @i_cliente        = @w_cliente,
      @i_fecha_valor    = @w_fecha_ini_dsp  ,--fecha de proceso
      @i_cuotas         = 12 ,
      @i_cuota_vencida = 'S',
      @i_archivo        = 'DESPLAZAMIENTO_140566.txt' ,--nombre del archivo
      @i_genera_int_esp = 'S'       ,                  --NO SE GENERA NINGUN INTERES ESPERA 
      @o_msg            = @w_msg   out
	  
	  
      if @w_error <> 0 or @@error <> 0 begin 
      
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70004,@w_msg,1)
		 
         update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
		 
         goto Siguiente
      
      end 
       
	  
   end else begin 

      exec @w_error=sp_desplazamiento	
      @i_banco          = @w_banco  ,
      @i_cliente        = @w_cliente,
      @i_fecha_valor    = @w_fecha_ini_dsp  ,--fecha de proceso
      @i_cuotas         = 8 ,
      @i_cuota_vencida = 'S',
      @i_archivo        = 'DESPLAZAMIENTO_140566.txt' ,--nombre del archivo
      @i_genera_int_esp = 'S'       ,                  --NO SE GENERA NINGUN INTERES ESPERA 
      @o_msg            = @w_msg   out
   
     if @w_error <> 0 or @@error <> 0 begin 
      
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70005,@w_msg,1)
		 
         update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
		 
         goto Siguiente
      
      end 
       
   
   end 
   

   

  --COLOCACION DEL RUBRO SEGAD 
   if (@w_tiene_seguro = 'S')  begin 
   
      select @w_div_inicio = di_dividendo
      from   ca_dividendo
      where  di_operacion = @w_operacion
      and    di_estado = 1
      
      select @w_div_fin = max(di_dividendo)
      from ca_dividendo
      where di_operacion = @w_operacion
      
      select @w_dividendo = @w_div_inicio
      
      select @w_monto_cobrar = round(@w_valor_seguro/(@w_div_fin -@w_dividendo+1),2)
      
      
      while @w_dividendo <= @w_div_fin begin
	   	
         if (@w_dividendo = @w_div_fin) select @w_monto_cobrar = @w_valor_seguro - (@w_monto_cobrar * (@w_div_fin -@w_div_inicio))
         
         exec @w_error=sp_otros_cargos	
         @s_date            = @w_fecha_proceso,
         @s_user	 	    = 'segad_covid19',
         @s_term  		    = 'consola',
         @s_ofi	       	    = @w_oficina,
         @i_banco        	= @w_banco,
         @i_moneda      	= @w_moneda,
         @i_operacion		= 'I',
         @i_toperacion	    = @w_toperacion,
         @i_desde_batch 	= 'N',
         @i_en_linea		= 'N',
         @i_tipo_rubro	    = 'O',
         @i_concepto		= 'SEGAD',
         @i_monto		    = @w_monto_cobrar,
         @i_div_desde	    = @w_dividendo,
         @i_div_hasta	    = @w_dividendo,
         @i_generar_trn	= 'N',
         @i_comentario	    = 'Generado por reestructuracion SEGAD'
		 
		 if @w_error <> 0 or @@error <> 0 begin 
      
            insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70009,'SEGAD',1)
		    
            update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
		    
            goto Siguiente
      
        end 
		 
      
         select @w_dividendo = @w_dividendo +1
      
      end --fin del while de otros cargos 
   
   end ---FIN SI TUVO SEGURO 

   --APLICAMOS LAS CONDONACIONES 
   
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
   
      
      exec @w_error = cob_cartera..sp_proceso_condonacion_tmp
      @i_banco              = @w_banco,
	  @i_fecha_valor        = @w_fecha_ini_dsp,
      @t_debug              = 'N'
      
      if @w_error <> 0 begin  
     
         insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70005,'',1)
		 
         update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
		 
         goto Siguiente 
      
      end 
	  
	  
end 
   -------------------------------------------
   
   
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
   
      insert into  errores_142443 (banco,error,descripcion,lista) values (@w_banco,70006,'',1)
	  
      update operaciones_142443_1 set  op_procesado = 'N' where id =   @w_id
	  
      goto Siguiente
	  
   end         
   
  
   
   
    update operaciones_142443_1 set  op_procesado = 'S' where id =   @w_id
	
	
   
   Siguiente:   
end





select 'VERIFICACION DE MONTOS ESPERA POSTERIOR'

select
operacion = am_operacion , 
cuota = sum(am_cuota) 
into #verificaciones 
from ca_amortizacion 
where am_operacion in ( select op_operacion from #operaciones_142443_1 where id>@w_bloque_ini and id<= @w_bloque_fin)
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
where di_operacion in(select op_operacion from #operaciones_142443_1 where id>@w_bloque_ini and id<= @w_bloque_fin)
group by di_operacion



drop table #verificaciones
drop table #operaciones_142443_1



