use cob_cartera
go

print '*****  creacion tabla cb_boc_log_rep_tmp'
if object_id('ca_error_log_rep_tmp') is not null
   drop table ca_error_log_rep_tmp
go

print '*****  creacion batch'
use cobis
go

DECLARE @w_server varchar(24) = null,
@w_path_fuente_CCA  varchar(255) = null,
@w_path_destino_CCA varchar(255) = null,
@w_sarta int,
@w_batch int,
@w_secuencial int

select @w_server = pa_char
from   cl_parametro
where  pa_producto = 'ADM'
and    pa_nemonico = 'SRVR'

select @w_path_fuente_CCA = pp_path_fuente, @w_path_destino_CCA = pp_path_destino
from   ba_path_pro
where  pp_producto = 8 --en los instaladores ira ruta de CARTERA

--BA_BATCH
select * from ba_batch WHERE ba_batch IN (7960)
delete ba_batch WHERE ba_batch IN (7960)

--BA_PARAMETRO
select * from ba_parametro WHERE pa_batch IN (7960)
DELETE ba_parametro WHERE pa_batch IN (7960)
go
