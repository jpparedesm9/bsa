use cobis
go

select *
from cobis..cl_alertas_riesgo
where ar_ente     = 25336
and   ar_contrato = '214800024512'

delete
from cobis..cl_alertas_riesgo
where ar_ente     = 25336
and   ar_contrato = '214800024512'


select *
from cobis..cl_alertas_riesgo
where ar_ente     = 25336
and   ar_contrato = '214800024512'



select *
from cobis..cl_alertas_riesgo
where ar_contrato in (select op_banco from cob_cartera..ca_operacion where op_toperacion = 'REVOLVENTE')


delete
from cobis..cl_alertas_riesgo
where ar_contrato in (select op_banco from cob_cartera..ca_operacion where op_toperacion = 'REVOLVENTE')


select *
from cobis..cl_alertas_riesgo
where ar_contrato in (select op_banco from cob_cartera..ca_operacion where op_toperacion = 'REVOLVENTE')


select *
from cobis..cl_alertas_riesgo
where ar_contrato in (select tg_prestamo
                      from cob_cartera..ca_operacion,
                           cob_credito..cr_tramite_grupal
                      where op_banco = tg_referencia_grupal
                      and   op_promocion = 'S')

delete
from cobis..cl_alertas_riesgo
where ar_contrato in (select tg_prestamo
                      from cob_cartera..ca_operacion,
                           cob_credito..cr_tramite_grupal
                      where op_banco = tg_referencia_grupal
                      and   op_promocion = 'S')


select *
from cobis..cl_alertas_riesgo
where ar_contrato in (select tg_prestamo
                      from cob_cartera..ca_operacion,
                           cob_credito..cr_tramite_grupal
                      where op_banco = tg_referencia_grupal
                      and   op_promocion = 'S')
                      
                      