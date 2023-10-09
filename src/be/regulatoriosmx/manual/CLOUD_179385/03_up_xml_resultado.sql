---update fecha para reproceso
use cob_conta_super
go


use cob_conta_super
go

declare 
    @w_xml              XML,
    @w_fecha            varchar(300),
    @num_codigo         int,
    @num_operacion      varchar(24),
    @w_rfc_cliente      varchar(25),
    @w_fecha_incio      datetime,
    @w_fecha_fin        datetime,
    @w_folio_refer      varchar(25)
 
set @w_fecha = format(dateadd(ss,-300,getdate()), 'yyyy-MM-ddTHH:mm:ss')

select TOP 10 * from cob_credito..cr_resultado_xml

select count(*), status from cob_credito..cr_resultado_xml GROUP BY status

update cob_credito..cr_resultado_xml
set status = 'P',
    linea.modify('replace value of(/cfdiComprobante/@Fecha)[1] with sql:variable("@w_fecha")')    

select count(*), status from cob_credito..cr_resultado_xml GROUP BY status

select TOP 10 * from cob_credito..cr_resultado_xml
go
