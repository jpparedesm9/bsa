---------------------------CREACION DE TABLA-no refleja git
use cob_cartera
go

IF OBJECT_ID ('ca_reporte_pago_tmp_tti') IS NOT NULL
   DROP TABLE ca_reporte_pago_tmp_tti
GO

CREATE TABLE ca_reporte_pago_tmp_tti
(
	rp_region             varchar (64),
	rp_oficina            varchar (64),
	rp_oficina_id         varchar (40),
	rp_gerente            varchar (64),
	rp_coordinador        varchar (64),
	rp_asesor             varchar (64),
	rp_contrato           varchar (40),
	rp_grupo_id           varchar (40),
	rp_grupo              varchar (64),
	rp_cliente_id         varchar (40),
	rp_cliente            varchar (64),
	rp_dia_pago           varchar (64),
	rp_valor_cuota        varchar (40),
	rp_cuotas_pendientes  varchar (40),
	rp_cuotas_en_atraso   varchar (40),
	rp_fecha_trn          varchar (40),
	rp_fecha_valor        varchar (40),
	rp_saldo_cap_antes    varchar (40),
	rp_saldo_cap_ex_antes varchar (40),
	rp_fecha_ult_pago     varchar (40),
	rp_nro_cuota_pagada   varchar (40),
	rp_fecha_cuota_pagada varchar (40),
--	rp_eventos_pago       varchar (40),
	rp_importe_tot        varchar (40),
	rp_importe_cap        varchar (40),
	rp_importe_int        varchar (40),
	rp_importe_iva_int    varchar (40),
	rp_importe_imo        varchar (40),
	rp_importe_iva_imo    varchar (40),
	rp_importe_com        varchar (40),
	rp_importe_iva_com    varchar (40),
	rp_importe_sob        varchar (40),
	rp_saldo_cap_desp     varchar (40),
	rp_saldo_cap_ex_desp  varchar (40),
	rp_trn_corresp_id     varchar (40),
	rp_tipo_pago          varchar (40),
	rp_reverso            varchar (40),
	rp_origen_pago        varchar (64),
	rp_usuario            varchar (40)
	)
go

---------------------------CREACION DE BATCH
use cobis
go
 
declare @w_server varchar(24),
        @w_path_fuente_REG varchar(255),
        @w_path_destino_REG varchar(255),
        @w_batch int, 
        @w_producto int
select @w_batch = 7092, @w_producto = 7

select @w_server = pa_char
from cl_parametro
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'
 
select @w_path_fuente_REG = pp_path_fuente, 
       @w_path_destino_REG = pp_path_destino
from ba_path_pro
where pp_producto = @w_producto

if exists (select 1 from ba_batch where ba_batch =  @w_batch and ba_nombre = 'REPORTE DIARIO DE PAGOS TTI' )
begin
   select * from ba_batch where ba_batch = @w_batch and ba_nombre = 'REPORTE DIARIO DE PAGOS TTI'
   delete ba_batch where ba_batch = @w_batch and ba_nombre = 'REPORTE DIARIO DE PAGOS TTI'
end

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (@w_batch, 'REPORTE DIARIO DE PAGOS TTI', 'REPORTE DIARIO DE PAGOS TTI', 'SP', getdate(), @w_producto, 'P', 1, 'CARTERA', 'COBRANZA_tti_DDMMYYYY.txt', 'cob_cartera..sp_reporte_pagos_tti', 1, NULL, @w_server, 'S', @w_path_fuente_REG, @w_path_destino_REG)

--PARAMETRO 
if exists(select 1 from ba_parametro where pa_batch = @w_batch)
begin
   select * from ba_parametro where pa_batch = @w_batch
   delete ba_parametro where pa_batch = @w_batch
end
--13
insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
values (0, @w_batch, 0, 1, 'FECHA_PROCESO', 'D', '03/11/2020')
go
