USE  cobis
GO

declare @w_ba_batch int 

select @w_ba_batch = 36433

delete from [dbo].[ba_batch] where ba_batch = @w_ba_batch

/*generar el codigo en la estructura ba batch*/
INSERT INTO [dbo].[ba_batch]
(ba_batch,          ba_nombre,          ba_descripcion,
ba_lenguaje,        ba_fecha_creacion,  ba_producto,
ba_tipo_batch,      ba_sec_corrida,     ba_ente_procesado,
ba_arch_resultado,  ba_arch_fuente,     ba_frec_reg_proc,
ba_impresora,       ba_serv_destino,    ba_reproceso,
ba_path_fuente,     ba_path_destino) 
VALUES
(@w_ba_batch,                               'B2C LOG DE TRANSACCIONES',                         'REPORTE LOG DE TRANSACCIONES B2C',
'SP',                                       cast('2019-10-15 00:00:00.000' as datetime),        18,
'R',                                        1,                                                  'LOG',
'LOGB2C',                                   'cob_bvirtual..sp_b2c_consulta_transacciones',      1,
'lp',                                       'CTSSRV',                                           'S',
'C:\Cobis\VBatch\Regulatorios\Objetos\',    'C:\Cobis\VBatch\Regulatorios\listados\')
GO

/*indice para estructura bv_tran_servicio*/
USE  cob_bvirtual
GO

if object_id('cob_bvirtual..bv_temp_tran_servicio') is not null
    drop table cob_bvirtual..bv_temp_tran_servicio
GO

CREATE TABLE bv_temp_tran_servicio(
tts_secuencial       varchar(75) null,
tts_cliente          varchar(75) null,
tts_buc              varchar(75) null,
tts_fecha            varchar(75) null,
tts_hora             varchar(75) null,
tts_tipo_transaccion varchar(240) null,
tts_monto            varchar(75) null,
tts_ref_interna      varchar(240) null,
tts_ref_externa      varchar(240) null,
tts_ip_origen        varchar(240) null)
GO

if exists(select 1 from sys.indexes where name = 'bv_tran_servicio_idx1' and object_id = OBJECT_ID('bv_tran_servicio'))
    DROP INDEX bv_tran_servicio_idx1 on [dbo].[bv_tran_servicio]
else
    CREATE NONCLUSTERED INDEX [bv_tran_servicio_idx1] on [dbo].[bv_tran_servicio] (
        [ts_int01] ASC, 
        [ts_fecha] ASC
    )WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO

GO