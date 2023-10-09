use cob_credito_his
go

IF OBJECT_ID ('dbo.cr_b2c_registro_his') IS NOT NULL
	DROP table dbo.cr_b2c_registro_his
go

create table dbo.cr_b2c_registro_his
	(
	rbh_registro_id       cuenta,
	rbh_id_inst_proc      int,
	rbh_cliente           int,
	rbh_fecha_ingreso     datetime,
	rbh_fecha_vigencia    datetime,
	rbh_fecha_reg_exitoso datetime
	)
go


create index idx on dbo.cr_b2c_registro_his (rbh_cliente)
	
go

use cobis
go


delete cobis..cl_parametro
where pa_nemonico = 'NMVIGR'


insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo,  pa_tinyint,  pa_producto)
values ('NUMERO MESES DE VIGENCIA DE REGISTROS', 'NMVIGR', 'T', 2,   'CRE')

select *
from cobis..cl_parametro
where pa_nemonico = 'NMVIGR'

go



use cobis
go

--Nuevo
delete from ba_batch where ba_batch= 21992
INSERT INTO ba_batch (ba_batch, ba_nombre                      , ba_descripcion                 , ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado   , ba_arch_fuente                             , ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso , ba_path_fuente                         , ba_path_destino)
              VALUES (21992   , 'PASO HISTORICO TABLAS CREDITO', 'PASO HISTORICO TABLAS CREDITO', 'SP'       , getDATE()        , 21         , 'P'          , 1             , NULL             , '', 'cob_credito..sp_paso_historico', 10000           , NULL        , 'CTSSRV'       , 'S'          , 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')

if not exists (select 1 from ba_parametro where pa_batch = 21992 and pa_nombre = 'FECHA PROCESO' )
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 21992, 0, 1, 'FECHA PROCESO', 'D', '12/06/2021')



