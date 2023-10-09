use cob_cartera
go
select *
from cob_cartera..ca_santander_orden_deposito_fallido,
 cob_cartera..ca_santander_orden_deposito
where sod_fecha        = '02/05/2019'
and   sod_consecutivo <= 4
and   sod_banco not in ('cabecera', 'pie')
and   sod_banco       = odf_banco
and   sod_consecutivo = odf_consecutivo
and   sod_linea       = odf_linea
and   sod_fecha       = odf_fecha


delete cob_cartera..ca_santander_orden_deposito_fallido
from cob_cartera..ca_santander_orden_deposito
where sod_fecha        = '02/05/2019'
and   sod_consecutivo <= 4
and   sod_banco not in ('cabecera', 'pie')
and   sod_banco       = odf_banco
and   sod_consecutivo = odf_consecutivo
and   sod_linea       = odf_linea
and   sod_fecha       = odf_fecha


select *
from cob_cartera..ca_santander_orden_deposito_fallido,
 cob_cartera..ca_santander_orden_deposito
where sod_fecha        = '02/05/2019'
and   sod_consecutivo <= 4
and   sod_banco not in ('cabecera', 'pie')
and   sod_banco       = odf_banco
and   sod_consecutivo = odf_consecutivo
and   sod_linea       = odf_linea
and   sod_fecha       = odf_fecha