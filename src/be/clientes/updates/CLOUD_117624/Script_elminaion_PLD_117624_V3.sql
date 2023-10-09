use cobis
go

select *
from cobis..cl_alertas_riesgo
where ar_ente     in (25336, 102637, 111852, 103891, 105005, 106802, 102700)
and   ar_contrato in ('214800024512', '210860005722', '211380000482', '210860005755','224030046540', '211070009420','210860005730')


delete
from cobis..cl_alertas_riesgo
where ar_ente     in (25336, 102637, 111852, 103891, 105005, 106802, 102700)
and   ar_contrato in ('214800024512', '210860005722', '211380000482', '210860005755','224030046540', '211070009420','210860005730')



select *
from cobis..cl_alertas_riesgo
where ar_ente     in (25336, 102637, 111852, 103891, 105005, 106802, 102700)
and   ar_contrato in ('214800024512', '210860005722', '211380000482', '210860005755','224030046540', '211070009420','210860005730')




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
                      
                      