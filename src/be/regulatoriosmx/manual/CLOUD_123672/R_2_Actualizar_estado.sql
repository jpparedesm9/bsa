use cob_credito
go


select top 1000 'operation' = num_operation,
                'folio'     = rx_folio_ref,
                'fecha'     = rx_fecha_fin_mes
into #temp_facturas				
from cob_credito..cr_resultado_xml

select 'Estado P ' = count(1) from cr_resultado_xml where status = 'P'

update cob_credito..cr_resultado_xml
set status = 'P'
from #temp_facturas
where num_operation = operation
and   rx_folio_ref  = folio
and   rx_fecha_fin_mes = fecha
   
select 'Estado P ' = count(1) from cr_resultado_xml where status = 'P'