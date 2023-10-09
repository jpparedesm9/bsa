use cob_workflow 
go 


--Se respalda la tabla con los registros en una temporal
if not exists (select 1 from sysobjects where name = 'wf_inst_proceso_103378') begin
   select * into wf_inst_proceso_103378  
   from  wf_inst_proceso
   where io_oficina_inicio = 9001
end 

select 
tramite = io_campo_3,
oficina = null  
into #of_inst_proceso
from wf_inst_proceso
where io_oficina_inicio = 9001


update #of_inst_proceso
set oficina = tr_oficina 
from cob_credito..cr_tramite 
where tramite = tr_tramite 


update cob_workflow..wf_inst_proceso set 
io_oficina_inicio  = isnull(oficina,0),
io_oficina_entrega = isnull(oficina,0)
from #of_inst_proceso
where tramite = io_campo_3



drop table #of_inst_proceso 
go 