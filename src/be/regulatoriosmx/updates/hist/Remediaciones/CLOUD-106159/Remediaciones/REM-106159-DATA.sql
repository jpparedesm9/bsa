use cob_cartera
go

declare @w_fecha datetime,
        @w_operacion    int,
        @w_referencia   varchar(255),
        @w_sec_ing      int,
        @w_sec_ing_2    int,
        @w_secuencial   int,
        @w_count_1      int,
        @w_count_2      int,
		@w_referencia_aux varchar(255),
		@w_rowcount     int
		

        
select @w_referencia = '', 
       @w_referencia_aux = '', 
       @w_sec_ing  = 0,
       @w_sec_ing_2 = 0,
       @w_count_1 = 0,
       @w_count_2 = 0,
       @w_rowcount = 0

select 'REGISTROS EN NULO ANTES' = count(*) 
from cob_cartera..ca_corresponsal_det, cob_cartera..ca_abono
where cd_sec_ing  = ab_secuencial_ing
and cd_operacion = ab_operacion
and cd_secuencial is null
and ab_estado <>'RV'
and ab_usuario = 'usrbatch'


select @w_secuencial = 0--13624

select top 1 @w_referencia = co_referencia,
@w_secuencial = co_secuencial,
@w_fecha      = co_fecha_proceso
from cob_cartera..ca_corresponsal_trn
where co_secuencial > @w_secuencial
and co_accion = 'I'
order by co_secuencial asc


while @@rowcount > 0 begin
   select @w_secuencial  
 
   select distinct  @w_sec_ing = cd_sec_ing   
   from cob_cartera..ca_abono, cob_cartera..ca_corresponsal_det
   where cd_sec_ing =  ab_secuencial_ing 
   and cd_operacion = ab_operacion
   and cd_secuencial is null
   and cd_referencia = @w_referencia
   and datediff(dd,@w_fecha,ab_fecha_ing) = 0
   and ab_estado <>'RV'
   and ab_usuario = 'usrbatch'
   order by cd_sec_ing asc
   
   select @w_rowcount= @@rowcount 

   
   if @w_rowcount = 1 begin
      print 'REGISTRO ACTUALIZADO:'
      print @w_referencia
      print @w_fecha
      print @w_sec_ing
      print @w_secuencial
      
	  --select @w_secuencial, cd_sec_ing, ab_fecha_ing
	  --from cob_cartera..ca_corresponsal_det,cob_cartera..ca_abono
      --where cd_sec_ing =  ab_secuencial_ing 
      --and cd_operacion = ab_operacion
      --and cd_referencia = @w_referencia
      --and cd_sec_ing    = @w_sec_ing
      --and datediff(dd,@w_fecha,ab_fecha_ing) = 0
	  --and ab_estado <>'RV'
      --and ab_usuario = 'usrbatch'
	  --and cd_secuencial is null
	  
      update cob_cartera..ca_corresponsal_det 
      set cd_secuencial   = @w_secuencial
      from cob_cartera..ca_corresponsal_det,cob_cartera..ca_abono
      where cd_sec_ing =  ab_secuencial_ing 
      and cd_operacion = ab_operacion
      and cd_referencia = @w_referencia
      and cd_sec_ing    = @w_sec_ing
      and datediff(dd,@w_fecha,ab_fecha_ing) = 0
	  and ab_estado <>'RV'
      and ab_usuario = 'usrbatch'
	  and cd_secuencial is null	  
	  
	  select @w_count_2 = @w_count_2 + @@rowcount

   end
  
   
   
   select top 1 @w_referencia = co_referencia,
   @w_secuencial = co_secuencial,
   @w_fecha      = co_fecha_proceso
   from cob_cartera..ca_corresponsal_trn
   where co_secuencial > @w_secuencial
   and co_accion = 'I'
   order by co_secuencial asc

end



select 'REGISTROS ACTUALIZADOS PARTE 1... '+convert(varchar,@w_count_2)

select ab_operacion, ab_fecha_ing, count(1)
from cob_cartera..ca_abono
where ab_estado <>'RV'
and ab_usuario = 'usrbatch'
group by ab_operacion, ab_fecha_ing
having count(1) > 1

select 'REGISTROS EN NULO DESPUES... '+convert(varchar,@@rowcount)

select 'REGISTROS ACTUALIZADOS PARTE 2... ' = count(*) 
from cob_cartera..ca_corresponsal_det 
where cd_secuencial is null	