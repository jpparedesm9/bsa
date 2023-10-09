-- Actualización parametro
select * from cobis..cl_parametro where pa_nemonico = 'NUFAEM' and pa_producto = 'ADM'

update cobis..cl_parametro 
set pa_int = 10000
where pa_nemonico = 'NUFAEM' 
and pa_producto = 'ADM'

select * from cobis..cl_parametro where pa_nemonico = 'NUFAEM' and pa_producto = 'ADM'
 


-- Actualización zips
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

 create table #num_operation_faltante
 (
  codigo    int identity,
  operation varchar(15),
  ente  varchar(15),
  folio_ref varchar(25),
  fecha_fm  date
 )

insert into #num_operation_faltante (operation, ente, folio_ref, fecha_fm)
select 
       nec_banco,
       in_cliente_rfc,
       in_folio_ref,
       in_fecha_fin_mes
from cob_conta_super..sb_ns_estado_cuenta 
where  in_estd_timb = 'N'

select count(1)
from cob_credito..cr_resultado_xml,
     #num_operation_faltante
where num_operation = operation
and rfc_ente = ente
and rx_folio_ref = folio_ref
and rx_fecha_fin_mes = fecha_fm
   

update cob_credito..cr_resultado_xml
set status = 'P'
from #num_operation_faltante
where num_operation = operation
and rfc_ente = ente
and rx_folio_ref = folio_ref
and rx_fecha_fin_mes = fecha_fm
   
select top 1  * from cob_conta_super..sb_ns_estado_cuenta 
where  in_estd_timb = 'N'
