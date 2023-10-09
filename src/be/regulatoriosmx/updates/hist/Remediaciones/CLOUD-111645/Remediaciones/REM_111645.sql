use cob_cartera
go

print '*****  creacion tabla cb_boc_log_rep_tmp'
if object_id('ca_error_log_rep_tmp') is not null
   drop table ca_error_log_rep_tmp
go

create table ca_error_log_rep_tmp(
    rtbl_campo1 varchar(255) null,
    rtbl_campo2 varchar(255) null,
    rtbl_campo3 varchar(255) null,
    rtbl_campo4 varchar(255) null,
    rtbl_campo5 varchar(255) null,
    rtbl_campo6 varchar(255) null,
    rtbl_campo7 varchar(255) null,
    rtbl_campo8 varchar(255) null,
    rtbl_campo9 varchar(255) null,
    rtbl_campo10 varchar(255) null,
    rtbl_campo11 varchar(255) null,
    rtbl_campo12 varchar(255) null,
    rtbl_campo13 varchar(255) null,
    rtbl_campo14 varchar(255) null,
    rtbl_campo15 varchar(255) null,
    rtbl_campo16 varchar(255) null
)
go
/*
use co_cartera
go
exec sp_rep_errores_logs
@i_param1 = '01/10/2019'
*/

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
insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (7960, 'REPORTE LOGS', 'REPORTE LOGS', 'SP', getdate(), 7, 'R', 1, 'REGISTROS', 'REPORTE_LOGS_DD_MM_AA.txt', 'cob_cartera..sp_rep_errores_logs', 1,   null, @w_server, 'S', @w_path_fuente_CCA, @w_path_destino_CCA)

--BA_PARAMETRO
select * from ba_parametro WHERE pa_batch IN (7960)
DELETE ba_parametro WHERE pa_batch IN (7960)
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) 
VALUES (0, 7960, 0, 1, 'param1', 'D', '01/01/2019')
go
