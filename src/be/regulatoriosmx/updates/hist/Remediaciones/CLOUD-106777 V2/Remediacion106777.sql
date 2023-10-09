use cob_cartera
go

--GRUPO:579


create table #pago    (grupo int, secuencial int)
create table #pagos_g (banco cuenta, operacion int, sec_ing int)
go

insert into #pago values(579,23882)

declare
@w_grupo 			int,
@w_operacionca 		int,
@w_error 			int,
@w_fecha_proceso 	datetime,
@w_referencia 		varchar(64),
@w_banco 			varchar(24),
@w_secuencial_pag 	int,
@w_secuencial 		int,
@w_fecha_valor 		datetime,
@w_sec_ing          int 

select 
@w_grupo      = 0,
@w_secuencial = 0

select @w_fecha_proceso = fp_fecha
from cobis..ba_fecha_proceso

while 1=1 begin

   select top 1
   @w_grupo      = grupo,
   @w_secuencial = secuencial
   from #pago
   where secuencial > @w_secuencial
   order by secuencial
   
   if @@rowcount = 0  break 

   select 
   @w_operacionca = 0,
   @w_sec_ing     = 0
		  
   print 'REVERSANDO PAGO DEL GRUPO:'+convert(varchar,@w_grupo)+' SECUENCIAL:'+convert(varchar,@w_secuencial)
   
   truncate table #pagos_g
   
   
   insert into #pagos_g
   select cd_banco, cd_operacion, cd_sec_ing
   from ca_corresponsal_det
   where cd_secuencial = @w_secuencial
   and cd_operacion not in (26797)       
   
   if @@rowcount = 0 begin 
      print 'NO SE ENCONTRO DETALLE DE PAGO PARA EL SECUENCIAL:'+convert(varchar,@w_secuencial)
	  goto SIGUIENTE_GRUPO
   end

   select * from #pagos_g

   while 2=2 begin
   
      select top 1
	  @w_banco       = banco, 
      @w_operacionca = operacion, 
      @w_sec_ing     = sec_ing
      from #pagos_g
      where operacion > @w_operacionca
      order by operacion
      
      if @@rowcount  = 0  break
          
      select @w_secuencial_pag = ab_secuencial_pag
      from ca_abono 
      where ab_secuencial_ing = @w_sec_ing 
      and ab_operacion        = @w_operacionca
      and ab_estado           = 'A'
      
      if @@ROWCOUNT =0 continue
      
      --APLICAR REVERSOS 
      select 'REVERSANDO PAGO PRESTAMO:' = @w_banco , ' secuencial del pago:' = @w_secuencial_pag 
	  
      exec @w_error = sp_fecha_valor 
      @s_date       = @w_fecha_proceso,
      @s_user       = 'usrbatch',
      @s_term       = 'consola',
      @t_trn        = 7049,
      @i_fecha_mov  = @w_fecha_proceso,
      @i_banco      = @w_banco,
      @i_secuencial = @w_secuencial_pag,
      @i_operacion  = 'R'
      
      if @w_error <> 0 begin
         select 'Error al ejecutar sp_fecha_valor' = @w_error 
         goto SIGUIENTE_GRUPO
      end
   
   end 

   --ACTUALIZAR ESTADO 

   
   print 'ACTUALIZANDO CA_CORRESPONSAL_TRN'
   
   select 'ANTES',* from ca_corresponsal_trn where co_secuencial = @w_secuencial

   update ca_corresponsal_trn set 
   co_estado ='I', 
   co_error_msg ='' 
   where co_secuencial = @w_secuencial 

   select 'DESPUES',* from ca_corresponsal_trn where co_secuencial = @w_secuencial
   

   SIGUIENTE_GRUPO:

end


drop table #pago
drop table #pagos_g

go