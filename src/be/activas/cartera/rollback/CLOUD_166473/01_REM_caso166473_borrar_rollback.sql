use cob_cartera
go

---------->>>>>>>>>>---------->>>>>>>>>>---------->>>>>>>>>>---------->>>>>>>>>>---------->>>>>>>>>>
update ca_det_ciclo
set dc_ciclo = T.dc_ciclo
from ca_det_ciclo_resp_166473_tmp T, ca_det_ciclo R
where T.dc_grupo = R.dc_grupo	
and T.dc_ciclo_grupo = R.dc_ciclo_grupo
and T.dc_cliente = R.dc_cliente
and T.dc_operacion = R.dc_operacion
and T.dc_referencia_grupal = R.dc_referencia_grupal

if OBJECT_ID ('dbo.ca_det_ciclo_resp_166473_tmp') is not null
	drop table dbo.ca_det_ciclo_resp_166473_tmp
go

---------->>>>>>>>>>---------->>>>>>>>>>---------->>>>>>>>>>---------->>>>>>>>>>---------->>>>>>>>>>

/*SELECT T.dc_ciclo, R.dc_ciclo, T.dc_grupo ,T.dc_ciclo_grupo, T.dc_cliente, T.dc_operacion, T.dc_referencia_grupal
FROM cob_cartera..ca_det_ciclo R, cob_cartera..ca_det_ciclo_resp_166473_tmp T
where T.dc_grupo = R.dc_grupo	
and T.dc_ciclo_grupo = R.dc_ciclo_grupo
and T.dc_cliente = R.dc_cliente
and T.dc_operacion = R.dc_operacion
and T.dc_referencia_grupal = R.dc_referencia_grupal ORDER BY T.dc_cliente, T.dc_operacion
*/