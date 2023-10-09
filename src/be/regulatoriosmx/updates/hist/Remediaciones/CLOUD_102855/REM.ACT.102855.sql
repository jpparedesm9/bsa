
---permisos de oficinas
use cob_conta
go

--abrir cortes 


declare @w_oficina int 



select  * into #of_modelo 
from cb_plan_general
where 1=2

select @w_oficina  = 0

while (1= 1) begin 

   set rowcount 1 
   
   select @w_oficina = of_oficina 
   from  cb_oficina 
   where of_movimiento = 'S'
   and   of_oficina > @w_oficina
   and   of_oficina  in ( 1036,1039)
   order by of_oficina
   
   if @@ROWCOUNT = 0 begin 
      set rowcount 0
      break 
   end 
   
   set rowcount 0 
   
   truncate table #of_modelo
   
   insert into #of_modelo 
   select  * from cb_plan_general
   where pg_oficina = 3348 
   and   pg_area    = 1090

   update #of_modelo set
   pg_oficina = @w_oficina,
   pg_clave   = convert(varchar, pg_empresa) + convert(varchar, pg_cuenta)+ convert(varchar, pg_oficina) +convert(varchar, pg_area) 
   
   delete #of_modelo 
   from cb_plan_general a ,#of_modelo b
   where a.pg_oficina = b.pg_oficina 
   and   a.pg_area    = b.pg_area   
   and   a.pg_cuenta  = b.pg_cuenta

   select 'REGISTROS ANADIDOS', * from #of_modelo
   
   insert into cb_plan_general
   select * from #of_modelo


end



drop table #of_modelo
go





