use cob_remesas
GO

/* pe_ts_contrato_producto */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER OFF
go

if exists (select 1 from sysobjects 
			where name = 'pe_ts_contrato_producto')
	drop view pe_ts_contrato_producto
go

create view pe_ts_contrato_producto (
        fecha, secuencial, tipo_transaccion,oficina,usuario,
        terminal, reentry,operacion, tipo_variacion,producto,
        prod_banc, tipo_persona, titularidad, estado, plantilla, descripcion,hora, es_especial
) as
select 
        ts_fecha,ts_secuencial, ts_tipo_transaccion,ts_oficina, ts_usuario, 
        ts_terminal, ts_reentry,ts_operacion,ts_tipo_variacion,ts_producto,
        ts_prod_banc, ts_tipo, ts_posteo, ts_estado, ts_plantilla, ts_descripcion,ts_hora, ts_rubro
from pe_tran_servicio
where ts_tipo_transaccion = 2946
go

