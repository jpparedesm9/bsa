-----------------------------------------------------------------------------------
-- CREACION DEL BATCH - 
-----------------------------------------------------------------------------------

use cobis
go
 
declare 
@w_server           varchar(24),
@w_path_fuente_CLI  varchar(255),
@w_producto         int,
@w_batch            int
 
select @w_server = pa_char
from cl_parametro
where pa_nemonico  = 'SRVR'

SELECT @w_producto = pd_producto 
FROM cobis..cl_producto WHERE pd_abreviatura = 'CRE'
 
select @w_path_fuente_CLI = pp_path_fuente
from  ba_path_pro
where pp_producto = @w_producto

-----------
--SARTA 22
-----------


select @w_batch = 21007
--BATCH 
if exists (select 1 from ba_batch where ba_batch =  @w_batch  and ba_nombre = '(CRE) PASO HISTORICO BURO' )
begin
   delete ba_batch where ba_batch =  @w_batch  and ba_nombre = '(CRE) PASO HISTORICO BURO'
end
insert into cobis..ba_batch(
ba_batch,          ba_nombre,             ba_descripcion,         ba_lenguaje, 
ba_fecha_creacion, ba_producto,           ba_tipo_batch,          ba_sec_corrida, 
ba_ente_procesado, ba_arch_resultado,     ba_arch_fuente,         ba_frec_reg_proc, 
ba_impresora,      ba_serv_destino,       ba_reproceso,           ba_path_fuente,
ba_path_destino
)
VALUES (
@w_batch ,        '(CRE) PASO HISTORICO BURO', 'PASO HISTORICO BURO',                 'SP', 
getdate(),        @w_producto,                 'P',                                   1, 
'BURO',           null,                        'cob_credito..sp_paso_buro_historico', 1,   
null,             @w_server,                   'S',                                   @w_path_fuente_CLI, 
null
)

GO