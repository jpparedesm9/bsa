

select  *
from cob_workflow..wf_inst_proceso
where io_campo_4 = 'INDIVIDUAL'
and   io_fecha_crea <= '12/07/2018'


update cob_workflow..wf_inst_proceso
set io_estado = 'CAN'
where io_campo_4 = 'INDIVIDUAL'
and   io_fecha_crea <= '12/07/2018'

select  *
from cob_workflow..wf_inst_proceso
where io_campo_4 = 'INDIVIDUAL'
and   io_fecha_crea <= '12/07/2018'



select *
from cob_sincroniza..si_sincroniza
where si_estado    = 'D'
and   si_fecha_ing <= '12/06/2018'


update cob_sincroniza..si_sincroniza
set   si_estado    = 'E' 
where si_estado    = 'D'
and   si_fecha_ing <= '12/06/2018'


select *
from cob_sincroniza..si_sincroniza
where si_estado    = 'D'
and   si_fecha_ing <= '12/06/2018'



