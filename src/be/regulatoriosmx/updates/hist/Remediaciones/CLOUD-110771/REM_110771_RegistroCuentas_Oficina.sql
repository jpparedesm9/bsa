---------------
--CASO 110771
---------------

use cob_cartera
go

--Actualiza oficinas
--Grupo 2397
UPDATE cob_cartera..ca_transaccion
SET tr_ofi_usu= 1122
WHERE tr_tran= 'DES'
AND tr_secuencial = 1
AND tr_operacion IN (
158010,
158013,
158016,
158019,
158022,
158025,
158028,
158031
)
--Grupo 1496
UPDATE cob_cartera..ca_transaccion
SET tr_ofi_usu= 3348
WHERE tr_tran= 'DES'
AND tr_secuencial = 1
AND tr_operacion IN (
172159,
172162,
172165,
172168,
172171,
172174,
172177,
172180
)
go

--Actualiza forma de pago
UPDATE cob_cartera..ca_det_trn SET dtr_concepto = 'GAR_DEB', dtr_codvalor = 132
WHERE dtr_concepto = 'GAR_CRE'
AND dtr_operacion IN(19774,
45561,
45564,
45567,
45570,
45573,
45576,
45579,
45582)

go

---permisos de oficinas
use cob_conta
go


update cb_corte
set co_estado = 'V'
where co_fecha_ini = '12/19/2018'



update cb_corte
set co_estado = 'V'
where co_fecha_ini = '12/20/2018'


--abrir cortes
use cob_conta
go

declare @w_oficina int


select * into #of_modelo 
from cb_plan_general
where 1=2

select @w_oficina = 0

while (1= 1) begin

   set rowcount 1 
   
   select @w_oficina = of_oficina 
   from cb_oficina 
   where of_movimiento = 'S'
   and of_oficina > @w_oficina
   and of_oficina in (1112)
   order by of_oficina
   
   if @@ROWCOUNT = 0 begin 
      set rowcount 0
      break 
   end 
   
   set rowcount 0 
   
   truncate table #of_modelo
   
   insert into #of_modelo 
   select * 
   from cb_plan_general
   where pg_oficina = 3348 
   and pg_area = 1090
   
   update #of_modelo set
   pg_oficina = @w_oficina,
   pg_clave = convert(varchar, pg_empresa) + convert(varchar, pg_cuenta)+ convert(varchar, pg_oficina) +convert(varchar, pg_area) 
   
   delete #of_modelo 
   from cb_plan_general a ,#of_modelo b
   where a.pg_oficina = b.pg_oficina 
   and a.pg_area = b.pg_area 
   and a.pg_cuenta = b.pg_cuenta
   
   select 'REGISTROS ANADIDOS', * from #of_modelo
   
   insert into cb_plan_general
   select * 
   from #of_modelo t
   where not exists(select 1 
                    from cb_plan_general d
                    where d.pg_oficina = t.pg_oficina
                    and   d.pg_area    = t.pg_area)

end


drop table #of_modelo
go