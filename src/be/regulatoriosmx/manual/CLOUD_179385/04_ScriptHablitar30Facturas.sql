use cob_credito
go


select top 30 *
into #no_actualizar_estado
from cr_resultado_xml
where status = 'P'
order by num_operation


update cr_resultado_xml set
status = 'W'
where num_operation not in (select num_operation from #no_actualizar_estado)


select status, count(1)
from cr_resultado_xml
group by status