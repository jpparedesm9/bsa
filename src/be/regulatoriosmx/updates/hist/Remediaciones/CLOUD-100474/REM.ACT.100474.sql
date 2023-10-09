
---permisos de oficinas
use cob_conta
go

--abrir cortes 

select * into cb_corte_30052018 from cb_corte where co_estado = 'V'


update cb_corte 
set co_estado = 'V'
where co_fecha_ini between '01/01/2018' and '05/29/2018'
go

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
   and   of_oficina not in ( 9001,9002)
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


--revers grupo 19, 41, 87
use cob_cartera 
go 

update ca_transaccion 
set tr_ofi_usu = tr_ofi_oper
where tr_ofi_usu in (9001, 9002)
and tr_estado  = 'ING'
go 


use cob_conta
go 


update cb_cuenta 
set cu_acceso = 'A'
where cu_movimiento = 'S'
and cu_acceso <> 'A'
and cu_cuenta in (select distinct re_substring from cb_relparam where  re_substring 
                   not like '11%' and re_substring not like '1391%') 
go




