


use cob_cartera
go 

--INSTALADOR DE REFERENCIA src/be/activas/cartera/installer/sql/ca_parametros.sql
delete from cobis..cl_parametro where pa_nemonico = 'UFRCO'

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ULTIMA FECHA DE EJECUCION REPORTE DE COBRANZAS', 'UFRCO', 'D', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
GO



--INSTALADOR REFERENCIA src/be/activas/cartera/installer/sql/ca_table.sql

if object_id ('dbo.ca_reporte_cobranza_tmp') is not null
	drop table dbo.ca_reporte_cobranza_tmp
go

create table ca_reporte_cobranza_tmp(


rc_contrato        varchar(40)          ,rc_cliente_id           varchar(40)               ,rc_grupo_id           varchar(40),
rc_grupo           varchar(64)          ,rc_fecha_trn            varchar(40)               ,rc_canal_id           varchar(40),
rc_fecha_valor     varchar(40)          ,rc_cuota_abonada        varchar(40)               ,rc_fecha_cuota_pagada varchar(40),
rc_importe_tot     varchar(40)          ,rc_eventos_pago         varchar(40)               ,rc_importe_cap        varchar(40),
rc_importe_int     varchar(40)          ,rc_importe_iva_int      varchar(40)               ,rc_importe_imo        varchar(40),
rc_importe_iva_imo varchar(40)          ,rc_importe_com          varchar(40)               ,rc_importe_iva_com    varchar(40),
rc_importe_sob     varchar(40)          ,rc_saldo_cap_desp       varchar(40)               ,rc_saldo_cap_ex_desp  varchar(40),
rc_trn_id          varchar(40)          ,rc_tipo_pago            varchar(40)               ,rc_reverso            varchar(40),
rc_origen_pago     varchar(40)          ,rc_referencia           varchar(40)               ,rc_pag_estado         varchar(40)    )       
																												   
																												   
																												   
																												   
use cobis 
go 


--INSTALADOR REFRENCIA src/be/activas/cartera/installer/sql/Param_Conta_MX/cb_batch.sql
delete ba_batch where ba_batch = 287932

INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (287932, 'REPORTE COBRANZA', 'REPORTE COBRANZA', 'SP', '01/19/2018 05:08:08', 36, 'P', 1, NULL, 'MC_COBRANZA_', 'cob_cartera..sp_reporte_cobranza', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch1\Regulatorios\Objetos\', 'C:\Cobis\VBatch1\Regulatorios\listados\')
GO

