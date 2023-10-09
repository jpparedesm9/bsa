use cob_credito
go


update cr_resultado_xml set
status = 'P'
where status = 'W'


select status, count(1)
from cr_resultado_xml
group by status