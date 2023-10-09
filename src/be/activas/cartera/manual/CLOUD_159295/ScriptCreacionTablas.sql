use cob_cartera
go


if object_id ('dbo.ca_reporte_restructura') is not null
   drop table dbo.ca_reporte_restructura
go

create table dbo.ca_reporte_restructura
(  
rr_credito_original      varchar(24),
rr_credito_destino       varchar(24),
rr_buc                   varchar(20),
rr_fecha_alta            varchar(20),
rr_fecha_formalizacion   varchar(20),
rr_situacion_conta       varchar(30),
rr_clasificacion_dest    varchar(30),
rr_dia_mora              varchar(20),
rr_exigible_origen       varchar(30),
rr_exigible_ori_actual   varchar(30),
rr_importe_refinan       varchar(25),
rr_monto_formalizado     varchar(20),
rr_flag_carencia_int     varchar(30),
rr_inicio_carencia_int   varchar(30),
rr_fin_carencia_int      varchar(30),
rr_flag_carencia_cap     varchar(30),
rr_inicio_carencia_cap   varchar(30),
rr_fin_carencia_cap      varchar(30),
rr_quita_cap_destino     varchar(30),
rr_quita_int_destino     varchar(30),
rr_quita_cap_origen      varchar(30),
rr_quita_int_origen      varchar(30),
rr_fecha_fin_contrato    varchar(25),
rr_monto_pago_cliente    varchar(20),
rr_amortiza_cap_ori      varchar(30),
rr_amortiza_int_ori      varchar(30),
rr_amortiza_cap_des      varchar(30),
rr_amortiza_int_des      varchar(30)
)
go





use cobis
go
--Nuevo
delete ba_batch where ba_batch= 7976
INSERT INTO ba_batch (ba_batch, ba_nombre               , ba_descripcion          , ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado   , ba_arch_fuente                             , ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso , ba_path_fuente                         , ba_path_destino)
              VALUES (7976   , 'REPORTE RESTRUCTURA', 'REPORTE RESTRUCTURA', 'SP'       , getDATE()        , 7         , 'P'          , 1             , NULL             , 'LAYOUT_REESTRUCTURAS_', 'cob_cartera..sp_reporte_proc_renova', 10000           , NULL        , 'CTSSRV'       , 'S'          , 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')

if not exists (select 1 from ba_parametro where pa_batch = 7976 and pa_nombre = 'FECHA PROCESO' )
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 7976, 0, 1, 'FECHA PROCESO', 'D', '12/01/2021')
