
USE cob_cartera
GO
  
SELECT getdate()

DECLARE @w_operacion         int,
        @w_secuecial_corresp int,
        @w_secuencial        int

create table #operaciones_padre
( secuencial         int identity,
  codigo_interno     int null,
  secuencial_corresp int null
)

insert into #operaciones_padre(
       codigo_interno,   secuencial_corresp) 
select distinct codigo_interno, secuencial_corresp 
from tmp_114349_dcu
where estado_proc_pago ='N'  

SELECT @w_secuencial = 0

WHILE 1=1
BEGIN
   SELECT top 1 @w_operacion         = codigo_interno,
                @w_secuecial_corresp = secuencial_corresp,
                @w_secuencial        = secuencial
     FROM #operaciones_padre
    WHERE secuencial > @w_secuencial
    ORDER BY secuencial

   IF @@ROWCOUNT = 0
   BEGIN
      break   
   END
   
      
   select @w_secuencial,
          @w_operacion,
          @w_secuecial_corresp
          
          
   DELETE ca_corresponsal_det 
     from ca_corresponsal_trn 
   where cd_secuencial     = co_secuencial 
      and co_codigo_interno = @w_operacion
      and co_secuencial     = @w_secuecial_corresp
      AND co_estado = 'P'
      AND co_accion = 'I'
      AND co_tipo   = 'PG' 
   	
   
   SELECT DISTINCT cd.* 
     FROM ca_corresponsal_det cd, 
          ca_corresponsal_trn 
    where cd_secuencial     = co_secuencial 
      AND co_codigo_interno = @w_operacion
      and co_secuencial     = @w_secuecial_corresp
      
          
   UPDATE ca_corresponsal_trn 
      SET co_estado    = 'I', 
          co_error_id  = 0,  
          co_error_msg = ''
    where co_codigo_interno = @w_operacion
      and co_secuencial     = @w_secuecial_corresp
      AND co_estado = 'P'
      AND co_accion = 'I'
      AND co_tipo   = 'PG'

   SELECT * 
     from ca_corresponsal_trn 
    where co_codigo_interno = @w_operacion
    and   co_secuencial     = @w_secuecial_corresp

      
    update tmp_114349_dcu
    set   estado_proc_pago = 'S'
    where codigo_interno     = @w_operacion
    and   secuencial_corresp = @w_secuecial_corresp


END 
SELECT getdate()

drop table #operaciones_padre
go



