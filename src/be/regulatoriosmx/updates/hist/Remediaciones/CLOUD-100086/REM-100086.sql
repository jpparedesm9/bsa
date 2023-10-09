use cob_cartera
go

IF OBJECT_ID ('ca_reporte_pago_tmp') IS NOT NULL
   DROP TABLE ca_reporte_pago_tmp
GO

CREATE TABLE ca_reporte_pago_tmp(
rp_region            	  varchar(40),
rp_oficina                VARCHAR(40),
rp_oficina_id             varchar(40),
rp_gerente                VARCHAR(40),
rp_coordinador            VARCHAR(40),
rp_asesor                 VARCHAR(40),
--rp_asesor_id              VARCHAR(40),
rp_contrato               VARCHAR(40),
--rp_operacion              VARCHAR(40),
--rp_secuencial             VARCHAR(40),
rp_grupo_id               VARCHAR(40),
rp_grupo                  varchar(40),
rp_cliente_id             varchar(40),
rp_cliente                VARCHAR(40),
rp_dia_pago               VARCHAR(40),
rp_valor_cuota            VARCHAR(40),
rp_cuotas_pendientes      VARCHAR(40),
rp_cuotas_en_atraso       VARCHAR(40),
rp_fecha_trn              VARCHAR(40),
rp_fecha_valor            VARCHAR(40),
rp_saldo_cap_antes        varchar(40),
rp_saldo_cap_ex_antes     VARCHAR(40),
rp_fecha_ult_pago         VARCHAR(40),
rp_nro_cuota_pagada       VARCHAR(40),
rp_fecha_cuota_pagada     varchar(40),
rp_eventos_pago           VARCHAR(40),
rp_importe_tot            VARCHAR(40),
rp_importe_cap            VARCHAR(40),
rp_importe_int            VARCHAR(40),
rp_importe_iva_int        VARCHAR(40),
rp_importe_imo            VARCHAR(40),
rp_importe_iva_imo        VARCHAR(40),
rp_importe_com            VARCHAR(40),
rp_importe_iva_com        varchar(40),
rp_importe_sob            VARCHAR(40),
rp_saldo_cap_desp         varchar(40),
rp_saldo_cap_ex_desp      VARCHAR(40),
rp_trn_corresp_id         VARCHAR(40),
rp_tipo_pago              VARCHAR(40),
rp_reverso                VARCHAR(40),
rp_origen_pago            VARCHAR(40),
rp_usuario                VARCHAR(40)
)                           
go
