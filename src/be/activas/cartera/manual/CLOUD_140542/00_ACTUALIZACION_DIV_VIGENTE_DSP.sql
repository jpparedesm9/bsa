




use cob_cartera 
go 


update ca_desplazamiento  set 
de_dividendo_vig = 1 
where de_archivo  = 'WORKFLOW'

select 
dividendo      = di_dividendo, 
operacion      = di_operacion,
secuencial_dsp = de_secuencial 
into #dividendos_dsp
from ca_dividendo, ca_desplazamiento 
where di_operacion = de_operacion 
and   (de_fecha_ini>=di_fecha_ini and di_fecha_ven > = de_fecha_fin)
and  de_dividendo_vig is null 

update ca_desplazamiento  set 
de_dividendo_vig = dividendo
from #dividendos_dsp
where operacion = de_operacion
and   secuencial_dsp = de_secuencial 
and  de_dividendo_vig is null 

--drop table #dividendos_dsp2 select * from ca_desplazamiento where de_dividendo_vig is null 


select 
dividendo      = max(di_dividendo), 
operacion      = di_operacion,
secuencial_dsp = de_secuencial 
into #dividendos_dsp2
from ca_dividendo, ca_desplazamiento 
where di_operacion = de_operacion 
and   (di_fecha_ini >=de_fecha_ini and de_fecha_fin <di_fecha_ven)
and di_dias_cuota >14
and   de_dividendo_vig is null 
group by di_operacion,de_secuencial



update ca_desplazamiento  set 
de_dividendo_vig = dividendo
from #dividendos_dsp2
where operacion = de_operacion
and   secuencial_dsp = de_secuencial 
and   de_dividendo_vig is null



select 
dividendo      = max(di_dividendo), 
operacion      = di_operacion,
secuencial_dsp = de_secuencial 
into #dividendos_dsp3
from ca_dividendo, ca_desplazamiento 
where di_operacion = de_operacion 
and   (di_fecha_ini >= de_fecha_ini  and  de_fecha_fin <= di_fecha_ven)
and   de_dividendo_vig is null 
group by di_operacion,de_secuencial

update ca_desplazamiento  set 
de_dividendo_vig = dividendo
from #dividendos_dsp3
where operacion = de_operacion
and   secuencial_dsp = de_secuencial 
and   de_dividendo_vig is null

select 
dividendo      = max(di_dividendo), 
operacion      = di_operacion,
secuencial_dsp = de_secuencial 
into #dividendos_dsp4
from ca_dividendo, ca_desplazamiento 
where di_operacion = de_operacion 
and   (di_fecha_ini >= de_fecha_ini  and  di_fecha_ven <=de_fecha_fin )
and   de_dividendo_vig is null 
group by di_operacion,de_secuencial

update ca_desplazamiento  set 
de_dividendo_vig = dividendo
from #dividendos_dsp4
where operacion = de_operacion
and   secuencial_dsp = de_secuencial 
and   de_dividendo_vig is null



drop table #dividendos_dsp 
drop table #dividendos_dsp2
drop table #dividendos_dsp3
drop table #dividendos_dsp4
go 



