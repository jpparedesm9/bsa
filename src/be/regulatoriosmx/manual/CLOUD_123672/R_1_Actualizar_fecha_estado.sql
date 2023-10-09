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
 

update cob_credito..cr_resultado_xml
set linea.modify('replace value of(/cfdiComprobante/@Fecha)[1] with sql:variable("@w_fecha")'),
    status = 'F'
   