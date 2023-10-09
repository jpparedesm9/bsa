use cob_externos
go

if object_id ('dbo.ex_operacion') is not null
	drop table dbo.ex_operacion
go

create table dbo.ex_operacion
(  
eo_fecha                   datetime not null,
eo_operacion               int not null,
eo_banco                   cuenta not null,
eo_cliente                 int,
eo_toperacion              catalogo not null,
eo_monto                   money not null,
eo_estado                  tinyint not null,
eo_aplicativo              tinyint not null
)
go

use cob_conta_super
go


if object_id ('dbo.sb_operacion') is not null
	drop table dbo.sb_operacion
go

create table dbo.sb_operacion
(  
op_fecha                   datetime not null,
op_operacion               int not null,
op_banco                   cuenta not null,
op_cliente                 int,
op_toperacion              catalogo not null,
op_aplicativo              tinyint not null
)
go

create nonclustered index  idx_sb_operacion on dbo.sb_operacion (op_cliente)
create nonclustered index  idx_sb_operacion_2 on dbo.sb_operacion (op_operacion)
go



use cobis
go
--Eliminacion anterior
delete from ba_batch where ba_batch= 152026

--Nuevo
delete from ba_batch where ba_batch= 36437
INSERT INTO ba_batch (ba_batch, ba_nombre               , ba_descripcion          , ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado   , ba_arch_fuente                             , ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso , ba_path_fuente                         , ba_path_destino)
              VALUES (36437   , 'REPORTE IMPACTO SOCIAl', 'REPORTE IMPACTO SOCIAl', 'SP'       , getDATE()        , 36         , 'P'          , 1             , NULL             , 'IS_COMPORTAMIENTO_', 'cob_conta_super..sp_rpt_comp_clientes_act', 10000           , NULL        , 'CTSSRV'       , 'S'          , 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')

if not exists (select 1 from ba_parametro where pa_batch = 36437 and pa_nombre = 'FECHA PROCESO' )
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 36437, 0, 1, 'FECHA PROCESO', 'D', '12/01/2021')

--Nuevo
delete from ba_batch where ba_batch= 36438
INSERT INTO ba_batch (ba_batch, ba_nombre                         , ba_descripcion                    , ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado   , ba_arch_fuente                             , ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso , ba_path_fuente                         , ba_path_destino)
              VALUES (36438   , 'INVENTARIO CLIENTES Y PROSPECTOS', 'INVENTARIO CLIENTES Y PROSPECTOS', 'SP'       , getDATE()        , 36         , 'P'          , 1             , NULL             , 'IS_PERSONAS_', 'cob_conta_super..sp_rpt_inv_clientes_prosp', 10000           , NULL        , 'CTSSRV'       , 'S'          , 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')

if not exists (select 1 from ba_parametro where pa_batch = 36438 and pa_nombre = 'FECHA PROCESO' )
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 36438, 0, 1, 'FECHA PROCESO', 'D', '12/01/2021')

go

use cobis
go

delete cl_parametro where pa_nemonico = 'NUDIVI' and pa_producto='ADM'

INSERT INTO cl_parametro(pa_parametro, pa_nemonico,pa_tipo,pa_int,pa_producto)
VALUES('NUMERO DIA VIERNES','NUDIVI','I',6,'ADM')

select * from cl_parametro where pa_nemonico = 'NUDIVI' and pa_producto='ADM'


delete cl_parametro where pa_nemonico = 'DIMAPR' and pa_producto='ADM'

INSERT INTO cl_parametro(pa_parametro, pa_nemonico,pa_tipo,pa_int,pa_producto)
VALUES('DIA MAXIMO PROCESAMIENTO','DIMAPR','I',8,'ADM')

select * from cl_parametro where pa_nemonico = 'DIMAPR' and pa_producto='ADM'

