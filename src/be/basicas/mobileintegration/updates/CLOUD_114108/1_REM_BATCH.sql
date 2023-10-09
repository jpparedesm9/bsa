-----------------------------------------------------------------------------------
-- CREACION DE PARAMETRO PARA EL TIEMPO ANTES DE ELIMINAR LA DATA DE SINCRONIZACION
-----------------------------------------------------------------------------------
USE cobis 
GO

IF NOT EXISTS(SELECT 1 FROM cobis..cl_parametro WHERE pa_nemonico='TPERDS')
BEGIN
INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES ('TIEMPO PARA ELIMINAR REGISTROS DE SINCRONIZACION','TPERDS','S',NULL, NULL,3,NULL,NULL,NULL,NULL,'ADM')
END
GO

-----------------------------------------------------------------------------------
-- CREACION DEL BATCH - 
-----------------------------------------------------------------------------------

use cobis
go
 
declare @w_server varchar(24),
        @w_path_fuente_CLI varchar(255),
        @w_path_destino_CLI varchar(255)
 
select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'
 
select @w_path_fuente_CLI = pp_path_fuente, 
       @w_path_destino_CLI = pp_path_destino
from ba_path_pro
where pp_producto = 2

-----------
--SARTA 13
-----------
 
--BATCH 
if exists (select 1 from ba_batch where ba_batch =  21991 and ba_nombre = 'LIMPIEZA DE LAS TABLAS DE SINCRONIZACION' )
begin
   delete ba_batch where ba_batch =  21991 and ba_nombre = 'LIMPIEZA DE LAS TABLAS DE SINCRONIZACION'
end
insert into cobis..ba_batch(
ba_batch,         ba_nombre,          ba_descripcion,         ba_lenguaje, 
ba_fecha_creacion, ba_producto,        ba_tipo_batch,          ba_sec_corrida, 
ba_ente_procesado, ba_arch_resultado,  ba_arch_fuente,         ba_frec_reg_proc, 
ba_impresora,      ba_serv_destino,    ba_reproceso,           ba_path_fuente,
ba_path_destino
)
VALUES (
21991,  'LIMPIEZA DE LAS TABLAS DE SINCRONIZACION', 'LIMPIEZA DE LAS TABLAS DE SINCRONIZACION','SP', 
getdate(), 2, 'P', 1, 
'MOBILE',null,'cob_sincroniza..sp_limp_data_sincro', 1,   
null, @w_server, 'S', @w_path_fuente_CLI, 
@w_path_destino_CLI
)
